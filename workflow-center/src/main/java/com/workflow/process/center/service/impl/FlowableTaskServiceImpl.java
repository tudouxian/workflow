package com.workflow.process.center.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.workflow.process.center.api.domain.WorkFlowUserDTO;
import com.workflow.process.center.common.enums.ProcessStatusEnum;
import com.workflow.process.center.common.enums.entity.ButtonTypeEnum;
import com.workflow.process.center.common.enums.entity.CommentTypeEnum;
import com.workflow.process.center.config.flowable.canvas.MyProcessDiagramGenerator;
import com.workflow.process.center.domain.dto.FlowableNodeDTO;
import com.workflow.process.center.domain.dto.task.*;
import com.workflow.process.center.domain.entity.WorkFlowButton;
import com.workflow.process.center.domain.entity.WorkFlowExtendHisprocinst;
import com.workflow.process.center.domain.entity.WorkFlowHiComment;
import com.workflow.process.center.exception.BizException;
import com.workflow.process.center.mapper.FlowableExtensionMapper;
import com.workflow.process.center.service.*;
import com.workflow.process.center.service.cmd.rollback.RollbackCmd;
import com.workflow.process.center.utils.SnowIdUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.collections4.MapUtils;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;
import org.flowable.bpmn.constants.BpmnXMLConstants;
import org.flowable.bpmn.model.*;
import org.flowable.common.engine.impl.util.IoUtil;
import org.flowable.engine.ProcessEngine;
import org.flowable.engine.history.HistoricActivityInstance;
import org.flowable.engine.history.HistoricProcessInstance;
import org.flowable.engine.runtime.ActivityInstance;
import org.flowable.engine.runtime.Execution;
import org.flowable.engine.runtime.ProcessInstance;
import org.flowable.identitylink.api.IdentityLink;
import org.flowable.identitylink.api.IdentityLinkType;
import org.flowable.task.api.DelegationState;
import org.flowable.task.api.Task;
import org.flowable.task.api.TaskQuery;
import org.flowable.task.api.history.HistoricTaskInstance;
import org.flowable.task.service.impl.persistence.entity.TaskEntity;
import org.flowable.task.service.impl.persistence.entity.TaskEntityImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.InputStream;
import java.util.*;
import java.util.stream.Collectors;

import static com.workflow.process.center.common.contant.CommonContant.*;
import static com.workflow.process.center.common.enums.ProcessStatusEnum.SPZ;
import static com.workflow.process.center.common.enums.entity.ButtonTypeEnum.TODO;
import static com.workflow.process.center.common.enums.entity.ButtonTypeEnum.getButtonTypeEnumByKey;
import static org.flowable.bpmn.constants.BpmnXMLConstants.ELEMENT_GATEWAY_PARALLEL;
import static org.flowable.bpmn.constants.BpmnXMLConstants.ELEMENT_TASK_USER;

/**
 * @Author: 土豆仙
 * @Date: 2021/6/28 15:15
 * @Description: flowable任务相关操作
 */
@Slf4j
@Service
@Transactional
public class FlowableTaskServiceImpl implements FlowableTaskService {

    //获取当前登录用户

    @Autowired
    private ProcessEngine processEngine;

    @Autowired
    private FlowableBpmnModelService flowableBpmnModelService;

    @Autowired
    private FlowableExtensionMapper flowableExtensionMapper;

    @Autowired
    private MyProcessDiagramGenerator flowProcessDiagramGenerator;

    @Autowired
    private WorkFlowExtendHisprocinstService workFlowExtendHisprocinstService;

    @Autowired
    private WorkFlowHiCommentService workFlowHiCommentService;

    @Autowired
    private AuthService authService;

    @Autowired
    private WorkFlowButtonService workFlowButtonService;

    @Autowired
    private WorkFlowUserService workFlowUserService;

    @Autowired
    private WorkFlowGroupService workFlowGroupService;

    @Autowired
    private SnowIdUtils snowIdUtils;


    /**
     * 判断是否挂起状态
     *
     * @param processInstanceId 流程实例id
     * @return
     */
    private boolean isSuspended(String processInstanceId) {
        ProcessInstance processInstance = processEngine.getRuntimeService()
                .createProcessInstanceQuery()
                .processInstanceId(processInstanceId)
                .singleResult();
        if (processInstance != null) {
            return processInstance.isSuspended();
        }
        return true;
    }

    @Override
    public void complete(CompleteTaskDTO params) {

        updateProcessInsStatus(params.getProcessInstanceId(), ProcessStatusEnum.SPZ.toString());

        //1.查看当前任务是存在
        TaskEntity taskEntity = (TaskEntity) processEngine.getTaskService()
                .createTaskQuery()
                .taskId(params.getTaskId())
                .singleResult();
        if (taskEntity == null) {
            throw new BizException("该任务id对应任务不存在！");
        }

        if (!processInsInRun(taskEntity.getProcessInstanceId())) {
            throw new BizException("该流程不在运行中,请确认!");
        }

        String taskId = params.getTaskId();
        //生成审批意见
        addComment(taskEntity.getId(), taskEntity.getName(), taskEntity.getTaskDefinitionKey(), taskEntity.getName(),
                taskEntity.getProcessInstanceId(), CommentTypeEnum.SP, params.getMessage(),
                authService.getLoginUser().getNickName() + " => 审批 => " + taskEntity.getName());
        //更新流程实例状态
        updateProinstStatus(params.getProcessInstanceId(), SPZ.toString());

        //2.委派处理
        if (DelegationState.PENDING.equals(taskEntity.getDelegationState())) {
            //2.1生成历史记录
            TaskEntity task = this.createSubTask(taskEntity, params.getUserId());
            processEngine.getTaskService()
                    .complete(task.getId());
            taskId = task.getId();
            //2.2执行委派
            processEngine.getTaskService()
                    .resolveTask(params.getTaskId(), params.getVariables());
        } else {
            //3.1修改执行人 -签收
            processEngine.getTaskService()
                    .setAssignee(params.getTaskId(), params.getUserId());

            //如果是协同任务且是主任务-将子协同任务一并结束
            if (SYNERGY.equals(taskEntity.getScopeType()) && StringUtils.isEmpty(taskEntity.getParentTaskId())) {

                List<String> synergyTaskIds = flowableExtensionMapper.querySubTaskByParentTaskIdAndScopeType(SYNERGY, taskEntity.getId());
                //结束协同任务
                if (CollectionUtils.isNotEmpty(synergyTaskIds)) {
                    synergyTaskIds.forEach(_s -> {
                        processEngine.getTaskService()
                                .complete(_s);
                    });
                } else {
                    processEngine.getTaskService()
                            .resolveTask(params.getTaskId(), params.getVariables());
                }

            }

            //3.2执行任务
            processEngine.getTaskService()
                    .complete(params.getTaskId(), params.getVariables());
            //4.处理加签父任务
            String parentTaskId = taskEntity.getParentTaskId();
            if (StringUtils.isNotBlank(parentTaskId)) {
                int subTaskCount = flowableExtensionMapper.querySubTaskByParentTaskId(parentTaskId);
                //如果没有其他子任务
                if (subTaskCount == 0) {
                    Task task = processEngine.getTaskService()
                            .createTaskQuery()
                            .taskId(parentTaskId)
                            .singleResult();

                    //处理前后加签的任务
                    processEngine.getTaskService()
                            .resolveTask(parentTaskId);
                    if (AFTER_ADDSIGN.equals(task.getScopeType())) {
                        processEngine.getTaskService()
                                .complete(parentTaskId);
                    }
                }
            }
        }
        //TODO 发送mongodb的数据到消息队列里面
    }

    @Override
    public void stopProcessInstanceById(EndTaskDTO params) {
        ProcessInstance processInstance = processEngine.getRuntimeService()
                .createProcessInstanceQuery()
                .processInstanceId(params.getProcessInstanceId())
                .singleResult();
        if (processInstance == null) {
            throw new BizException("该流程不在运行中,请确认!");
        }

        //1、添加审批记录
        //生成审批意见
        addComment(null, null, null, null,
                params.getProcessInstanceId(), CommentTypeEnum.QZJS, params.getMessage(),
                authService.getLoginUser().getNickName() + " => 强制结束流程 ");
        //更新流程实例状态
        updateProinstStatus(params.getProcessInstanceId(), ProcessStatusEnum.QZJS.toString());

        //2、获取结束节点
        List<EndEvent> endNodes = flowableBpmnModelService.findEndFlowElement(processInstance.getProcessDefinitionId());
        String endId = endNodes.get(0).getId();
        String processInstanceId = params.getProcessInstanceId();
        //2、执行终止
        List<Execution> executions = processEngine.getRuntimeService()
                .createExecutionQuery()
                .parentId(processInstanceId)
                .list();
        List<String> executionIds = new ArrayList<>();
        executions.forEach(execution -> executionIds.add(execution.getId()));
        //3、跳转到结束节点
        moveExecutionsToSingleActivityId(executionIds, endId);

    }

    @Override
    public void revokeProcess(RevokeTaskDTO params) {
        updateProcessInsStatus(params.getProcessInstanceId(), ProcessStatusEnum.CH.toString());
        ProcessInstance processInstance = processEngine.getRuntimeService()
                .createProcessInstanceQuery()
                .processInstanceId(params.getProcessInstanceId())
                .singleResult();
        if (processInstance == null) {
            throw new BizException("该流程不在运行中,请确认!");
        }

        //撤销
        processEngine.getRuntimeService()
                .deleteProcessInstance(params.getProcessInstanceId(), params.getMessage());

        /*//2.设置提交人
        processEngine.getRuntimeService()
                .setVariable(params.getProcessInstanceId(), FLOW_SUBMITTER_VAR, processInstance.getStartUserId());
        //3.执行撤回
        Activity disActivity = flowableBpmnModelService.findActivityByName(processInstance.getProcessDefinitionId(), FLOW_SUBMITTER);

        //如果第一个不是提交人节点=》直接结束？
        if (disActivity !=null){
            //4.删除运行和历史的节点信息
            deleteActivity(disActivity.getId(), params.getProcessInstanceId());
            //5.执行跳转
            List<Execution> executions = processEngine.getRuntimeService()
                    .createExecutionQuery()
                    .parentId(params.getProcessInstanceId())
                    .list();
            List<String> executionIds = new ArrayList<>();
            executions.forEach(execution -> executionIds.add(execution.getId()));
            moveExecutionsToSingleActivityId(executionIds, disActivity.getId());
        }else {
            //撤销
            processEngine.getRuntimeService()
                    .deleteProcessInstance(params.getProcessInstanceId(),params.getMessage());
        }*/

        //1.添加撤回意见=>
        addComment(null, null, null, null,
                params.getProcessInstanceId(), CommentTypeEnum.LCZZ, params.getMessage(),
                authService.getLoginUser().getNickName() + " => 流程撤销中止 => ");
        //更新流程实例状态
        updateProinstStatus(params.getProcessInstanceId(), ProcessStatusEnum.ZZ.toString());

    }

    @Override
    public void turnTask(TurnTaskDTO params) {
        updateProcessInsStatus(params.getProcessInstanceId(), ProcessStatusEnum.ZB.toString());
        TaskEntityImpl currTask = (TaskEntityImpl) processEngine.getTaskService()
                .createTaskQuery()
                .taskId(params.getTaskId())
                .singleResult();
        if (currTask == null) {
            throw new BizException("没有运行时的任务实例,请确认!");
        }

        if (!processInsInRun(currTask.getProcessInstanceId())) {
            throw new BizException("该流程不在运行中,请确认!");
        }
        //1.生成历史记录
        TaskEntity task = createSubTask(currTask, params.getUserId());

        processEngine.getTaskService().complete(task.getId());
        //3.转办
        processEngine.getTaskService().setAssignee(params.getTaskId(), params.getTurnToUserId());
        processEngine.getTaskService().setOwner(params.getTaskId(), params.getUserId());


        String targetUser = "";
        WorkFlowUserDTO workFlowUserDTO = workFlowUserService.selectUserByUserId(params.getTurnToUserId());
        if (workFlowUserDTO != null) {
            targetUser = workFlowUserDTO.getNickName();
        }
        //2.添加审批意见
        addComment(currTask.getId(), currTask.getName(), currTask.getTaskDefinitionKey(), currTask.getName(),
                currTask.getProcessInstanceId(), CommentTypeEnum.ZB, params.getMessage(),
                authService.getLoginUser().getNickName() + " => 转办 => " + currTask.getName() + "【" + targetUser + "】");//action=>记录从谁转办给谁
        //更新流程实例状态
        updateProinstStatus(params.getProcessInstanceId(), SPZ.toString());

    }

    @Override
    public void delegateTask(DelegateTaskDTO params) {
        updateProcessInsStatus(params.getProcessInstanceId(), ProcessStatusEnum.WP.toString());
        TaskEntityImpl currTask = (TaskEntityImpl) processEngine.getTaskService()
                .createTaskQuery()
                .taskId(params.getTaskId())
                .singleResult();

        if (currTask == null) {
            throw new BizException("没有运行时的任务实例,请确认!");
        }

        if (!processInsInRun(currTask.getProcessInstanceId())) {
            throw new BizException("该流程不在运行中,请确认!");
        }

        //2.设置审批人就是当前登录人
        processEngine.getTaskService().setAssignee(params.getTaskId(), params.getUserId());
        //3.执行委派
        processEngine.getTaskService().delegateTask(params.getTaskId(), params.getDelegateUserId());

        String targetUser = "";
        WorkFlowUserDTO workFlowUserDTO = workFlowUserService.selectUserByUserId(params.getDelegateUserId());
        if (workFlowUserDTO != null) {
            targetUser = workFlowUserDTO.getNickName();
        }
        //1.添加审批意见
        addComment(currTask.getId(), currTask.getName(), currTask.getTaskDefinitionKey(), currTask.getName(),
                currTask.getProcessInstanceId(), CommentTypeEnum.WP, params.getMessage(),
                authService.getLoginUser().getNickName() + " => 代理 => " + currTask.getName() + "【" + targetUser + "】");//action=>记录给谁代理
        //更新流程实例状态
        updateProinstStatus(params.getProcessInstanceId(), SPZ.toString());
    }

    @Override
    public void claimTask(ClaimTaskDTO params) {
        TaskEntityImpl currTask = (TaskEntityImpl) processEngine.getTaskService()
                .createTaskQuery()
                .taskId(params.getTaskId())
                .singleResult();
        if (currTask == null) {
            throw new BizException("没有运行时的任务实例,请确认!");
        }

        if (!processInsInRun(currTask.getProcessInstanceId())) {
            throw new BizException("该流程不在运行中,请确认!");
        }

        //2.签收-自定义签收命令
        /*processEngine.getManagementService()
                .executeCommand(new MyClaimTaskCmd(params.getTaskId(), params.getUserCode()));*/
        //原生签收命令
        processEngine.getTaskService()
                .claim(params.getTaskId(), params.getUserId());

        //1.添加审批意见
        addComment(currTask.getId(), currTask.getName(), currTask.getTaskDefinitionKey(), currTask.getName(),
                currTask.getProcessInstanceId(), CommentTypeEnum.QS, params.getMessage(),
                authService.getLoginUser().getNickName() + " => 拾取任务 => " + currTask.getName());//action=>记录领取任务
        //更新流程实例状态
        updateProinstStatus(params.getProcessInstanceId(), SPZ.toString());

    }

    @Override
    public void unClaimTask(ClaimTaskDTO params) {
        TaskEntityImpl currTask = (TaskEntityImpl) processEngine
                .getTaskService()
                .createTaskQuery()
                .taskId(params.getTaskId())
                .singleResult();

        if (currTask == null) {
            throw new BizException("没有运行时的任务实例,请确认!");
        }

        if (!processInsInRun(currTask.getProcessInstanceId())) {
            throw new BizException("该流程不在运行中,请确认!");
        }

        //2.反签收
        //判断任务是否有候选人或候选组-避免无法认领任务
        if (isTaskHasCandidateUserOrCandidateGroup(params.getTaskId())) {
            processEngine.getTaskService().claim(params.getTaskId(), null);
                /*processEngine.getManagementService()
                        .executeCommand(new MyClaimTaskCmd(params.getTaskId(), null));*/
        } else {
            throw new BizException("由于没有候选人或候选组,会导致任务无法认领,请确认.");
        }
        //1.添加审批意见
        addComment(currTask.getId(), currTask.getName(), currTask.getTaskDefinitionKey(), currTask.getName(),
                currTask.getProcessInstanceId(), CommentTypeEnum.GH, params.getMessage(),
                authService.getLoginUser().getNickName() + " => 归还任务 => " + currTask.getName());//action=>记录取消领取

        //更新流程实例状态
        updateProinstStatus(params.getProcessInstanceId(), SPZ.toString());
    }


    private boolean isTaskHasCandidateUserOrCandidateGroup(String taskId) {
        List<IdentityLink> identityLinks = processEngine
                .getTaskService()
                .getIdentityLinksForTask(taskId);

        if (CollectionUtils.isNotEmpty(identityLinks)) {
            for (IdentityLink link : identityLinks) {
                if (IdentityLinkType.CANDIDATE.equals(link.getType())) {
                    return true;
                }
            }
        }
        return false;
    }

    @Override
    public void synergyTask(SynergyTaskDTO params) {
        TaskEntityImpl taskEntity = (TaskEntityImpl) processEngine.getTaskService()
                .createTaskQuery()
                .taskId(params.getTaskId())
                .singleResult();
        if (taskEntity == null) {
            throw new BizException("没有运行时的任务实例,请确认!");
        }

        if (!processInsInRun(taskEntity.getProcessInstanceId())) {
            throw new BizException("该流程不在运行中,请确认!");
        }

        String users = "";
        List<WorkFlowUserDTO> workFlowUserDTOS = workFlowUserService.selectUserByUserIds(params.getSynergyUserIds());
        if (CollectionUtils.isNotEmpty(workFlowUserDTOS)) {
            users = workFlowUserDTOS.stream()
                    .map(WorkFlowUserDTO::getNickName)
                    .collect(Collectors.joining(","));
        }

        //子任务不能处理协同
        String parentTaskId = taskEntity.getParentTaskId();
        if (StringUtils.isNotBlank(parentTaskId)) {
            throw new BizException("当前任务不能处理协同操作！");
        }

        //添加审批意见
        addComment(taskEntity.getId(), taskEntity.getName(), taskEntity.getTaskDefinitionKey(), taskEntity.getName(),
                taskEntity.getProcessInstanceId(), CommentTypeEnum.XT, params.getMessage(),
                authService.getLoginUser().getNickName() + " => 协同 => " + taskEntity.getName() + "【" + users + "】");//action=>记录协同谁


        //更新流程实例状态
        updateProinstStatus(params.getProcessInstanceId(), SPZ.toString());

        //设置协同标识
        taskEntity.setScopeType(SYNERGY);

        //协同子任务去重
        List<String> list = flowableExtensionMapper.querySubTaskByParentTaskIdAndScopeType(SYNERGY, taskEntity.getId());
        if (CollectionUtils.isNotEmpty(list)) {
            params.getSynergyUserIds().removeAll(list);
        }
        params.getSynergyUserIds().forEach(_userId -> {
            if (StringUtils.isNotBlank(_userId)) {
                this.createSynergyTask(taskEntity, taskEntity.getId(), _userId);
            }
        });


    }

    /**
     * 创建协同任务
     *
     * @param ptask    创建协同任务
     * @param assignee 协同任务的执行人
     * @return
     */
    private TaskEntity createSynergyTask(TaskEntity ptask, String ptaskId, String assignee) {
        TaskEntity task = null;
        if (ptask != null) {
            //1.生成子任务
            task = (TaskEntity) processEngine.getTaskService()
                    .newTask(Long.toString(snowIdUtils.nextId()));
            task.setCategory(ptask.getCategory());
            task.setDescription(ptask.getDescription());
            task.setTenantId(ptask.getTenantId());
            task.setAssignee(assignee);
            task.setScopeType(ptask.getScopeType());
            task.setName(ptask.getName());
            task.setParentTaskId(ptaskId);
            task.setProcessDefinitionId(ptask.getProcessDefinitionId());
            task.setProcessInstanceId(ptask.getProcessInstanceId());
            task.setTaskDefinitionKey(ptask.getTaskDefinitionKey());
            task.setTaskDefinitionId(ptask.getTaskDefinitionId());
            task.setPriority(ptask.getPriority());
            task.setCreateTime(new Date());
            processEngine.getTaskService()
                    .saveTask(task);
        }
        return task;
    }

    @Override
    public void beforeAddSignTask(AddSignTaskDTO params) {
        updateProcessInsStatus(params.getProcessInstanceId(), ProcessStatusEnum.JQ.toString());
        addSignTask(params, false);
    }

    @Override
    public void afterAddSignTask(AddSignTaskDTO params) {
        updateProcessInsStatus(params.getProcessInstanceId(), ProcessStatusEnum.JQ.toString());
        addSignTask(params, true);
    }

    private void addSignTask(AddSignTaskDTO addSignTaskDTO, Boolean flag) {
        TaskEntityImpl taskEntity = (TaskEntityImpl) processEngine.getTaskService()
                .createTaskQuery()
                .taskId(addSignTaskDTO.getTaskId()).singleResult();
        if (taskEntity == null) {
            throw new BizException("没有运行时的任务实例,请确认!");
        }

        if (!processInsInRun(taskEntity.getProcessInstanceId())) {
            throw new BizException("该流程不在运行中,请确认!");
        }

        String users = "";
        List<WorkFlowUserDTO> workFlowUserDTOS = workFlowUserService.selectUserByUserIds(addSignTaskDTO.getSignUserIds());
        if (CollectionUtils.isNotEmpty(workFlowUserDTOS)) {
            users = workFlowUserDTOS.stream()
                    .map(WorkFlowUserDTO::getNickName)
                    .collect(Collectors.joining(","));
        }
        //添加审批意见
        CommentTypeEnum type = flag ? CommentTypeEnum.HJQ : CommentTypeEnum.QJQ;
        addComment(taskEntity.getId(), taskEntity.getName(), taskEntity.getTaskDefinitionKey(), taskEntity.getName(),
                taskEntity.getProcessInstanceId(), type, addSignTaskDTO.getMessage(),
                authService.getLoginUser().getNickName() + " => 加签 => " + taskEntity.getName() + "【" + users + "】");//action=>记录加签给谁


        //1.1 把当前的节点设置为空
        //如果是加签再加签
        // String parentTaskId = taskEntity.getParentTaskId();

        taskEntity.setOwner(addSignTaskDTO.getUserId());
        taskEntity.setAssignee(null);
        taskEntity.setCountEnabled(true);
        if (flag) {
            taskEntity.setScopeType(AFTER_ADDSIGN);
        } else {
            taskEntity.setScopeType(BEFORE_ADDSIGN);
        }
        //1.2 设置任务为空执行者
        processEngine.getTaskService()
                .saveTask(taskEntity);

        //2.添加加签数据
        createSignSubTasks(addSignTaskDTO, taskEntity);


    }

    /**
     * 创建加签子任务
     *
     * @param addSignTaskDTO 加签参数
     * @param taskEntity     父任务
     */
    private void createSignSubTasks(AddSignTaskDTO addSignTaskDTO, TaskEntity taskEntity) {
        if (CollectionUtils.isNotEmpty(addSignTaskDTO.getSignUserIds())) {
            //1.创建被加签人的任务列表
            addSignTaskDTO.getSignUserIds().forEach(_userId -> {
                if (StringUtils.isNotBlank(_userId)) {
                    this.createSubTask(taskEntity, taskEntity.getId(), _userId);
                }
            });

            String parentTaskId = taskEntity.getParentTaskId();
            if (StringUtils.isBlank(parentTaskId)) {
                parentTaskId = taskEntity.getId();
            }
            String finalParentTaskId = parentTaskId;
            //2.创建加签人的任务并执行完毕
            Task task = createSubTask(taskEntity, finalParentTaskId, addSignTaskDTO.getUserId());
            processEngine.getTaskService().complete(task.getId());

           /* String taskId = taskEntity.getId();
            if (StringUtils.isBlank(taskEntity.getParentTaskId())) {
                //2.创建加签人的任务并执行完毕
                Task task = createSubTask(taskEntity, finalParentTaskId, addSignTaskDTO.getUserId());
                taskId = task.getId();
            }
            Task taskInfo = processEngine.getTaskService()
                    .createTaskQuery()
                    .taskId(taskId)
                    .singleResult();
            if (null != taskInfo) {
                processEngine.getTaskService().complete(taskId);
            }*/
            //如果是候选人，需要删除运行时候选表种的数据。
            long candidateCount = processEngine.getTaskService()
                    .createTaskQuery()
                    .taskId(parentTaskId)
                    .taskCandidateUser(addSignTaskDTO.getUserId()).count();
            if (candidateCount > 0) {
                processEngine.getTaskService()
                        .deleteCandidateUser(parentTaskId, addSignTaskDTO.getUserId());
            }
        }
    }

    @Override
    public List<FlowableNodeDTO> getBackNodesByProcessInstanceId(String processInstanceId, String taskId) {

        TaskEntity taskEntity = (TaskEntity) processEngine.getTaskService()
                .createTaskQuery()
                .taskId(taskId)
                .singleResult();
        //获取当前流程实例运行节点表中还没结束的usertask
        List<ActivityInstance> activityInstances = flowableExtensionMapper.queryActivityInstanceByType(processInstanceId, ELEMENT_TASK_USER);

        //获取当前流程实例运行节点表中还没结束的parallelGateway节点并去重
        String currActId = taskEntity.getTaskDefinitionKey();
        List<ActivityInstance> parallelGatewaies = flowableExtensionMapper.queryActivityInstanceByTypeAndRemoveDuplicates(processInstanceId, currActId, ELEMENT_GATEWAY_PARALLEL);
        //排序
        if (CollectionUtils.isNotEmpty(parallelGatewaies)) {
            activityInstances.addAll(parallelGatewaies);
            activityInstances.sort(Comparator.comparing(ActivityInstance::getEndTime));
        }
        //分组节点
        int count = 0;
        //存放并行网关任务
        Map<ActivityInstance, List<ActivityInstance>> parallelGatewayUserTasks = new HashMap<>();
        //用户任务
        List<ActivityInstance> userTasks = new ArrayList<>();
        //后期优化
        ActivityInstance currActivityInstance = null;
        for (ActivityInstance activityInstance : activityInstances) {
            if (ELEMENT_GATEWAY_PARALLEL.equals(activityInstance.getActivityType())) {
                count++;
                if (count % 2 != 0) {
                    List<ActivityInstance> datas = new ArrayList<>();
                    currActivityInstance = activityInstance;
                    parallelGatewayUserTasks.put(currActivityInstance, datas);
                }
            }
            if (ELEMENT_TASK_USER.equals(activityInstance.getActivityType())) {
                if (count % 2 == 0) {
                    //不是并行网关内任务
                    userTasks.add(activityInstance);
                } else {
                    if (parallelGatewayUserTasks.containsKey(currActivityInstance)) {
                        //添加并行网关下的用户任务
                        parallelGatewayUserTasks.get(currActivityInstance).add(activityInstance);
                    }
                }
            }
        }
        //组装历史任务办理人员名称
        List<HistoricTaskInstance> historicTaskInstances = processEngine.getHistoryService()
                .createHistoricTaskInstanceQuery()
                .processInstanceId(processInstanceId)
                .finished()
                .list();
        Map<String, List<HistoricTaskInstance>> taskInstanceMap = new HashMap<>();

        //历史任务办理人ID
        List<String> userIDs = new ArrayList<>();
        historicTaskInstances.forEach(historicTaskInstance -> {
            userIDs.add(historicTaskInstance.getAssignee());
            String taskDefinitionKey = historicTaskInstance.getTaskDefinitionKey();
            if (taskInstanceMap.containsKey(historicTaskInstance.getTaskDefinitionKey())) {
                taskInstanceMap.get(taskDefinitionKey).add(historicTaskInstance);
            } else {
                List<HistoricTaskInstance> tasks = new ArrayList<>();
                tasks.add(historicTaskInstance);
                taskInstanceMap.put(taskDefinitionKey, tasks);
            }
        });
        //组装usertask的数据 =>替换查询

        List<WorkFlowUserDTO> workFlowUserDTOS = workFlowUserService.selectUserByUserIds(userIDs);

   /*     List<User> userList = processEngine.getIdentityService()
                .createUserQuery()
                .userIds(userIDs)
                .list();*/

        //驳回节点集合
        List<FlowableNodeDTO> backNods = new ArrayList<>();

        //历史节点ID、办理人
        Map<String, String> activityIdUserNames = this.getApplyers(processInstanceId, workFlowUserDTOS, taskInstanceMap);
        if (CollectionUtils.isNotEmpty(userTasks)) {
            userTasks.forEach(activityInstance -> {
                FlowableNodeDTO node = new FlowableNodeDTO();
                node.setNodeId(activityInstance.getActivityId());
                node.setNodeName(activityInstance.getActivityName());
                node.setEndTime(activityInstance.getEndTime());
                node.setUserName(activityIdUserNames.get(activityInstance.getActivityId()));
                backNods.add(node);
            });
        }
        //组装会签节点数据
        if (MapUtils.isNotEmpty(taskInstanceMap)) {
            parallelGatewayUserTasks.forEach((activity, activities) -> {
                FlowableNodeDTO node = new FlowableNodeDTO();
                node.setNodeId(activity.getActivityId());
                node.setEndTime(activity.getEndTime());
                StringBuffer nodeNames = new StringBuffer("会签:");
                StringBuffer userNames = new StringBuffer("审批人员:");
                if (CollectionUtils.isNotEmpty(activities)) {
                    activities.forEach(activityInstance -> {
                        nodeNames.append(activityInstance.getActivityName()).append(",");
                        userNames.append(activityIdUserNames.get(activityInstance.getActivityId())).append(",");
                    });
                    node.setNodeName(nodeNames.toString());
                    node.setUserName(userNames.toString());
                    backNods.add(node);
                }
            });
        }
        //去重合并
        List<FlowableNodeDTO> datas = backNods.stream().collect(
                Collectors.collectingAndThen(Collectors.toCollection(() ->
                        new TreeSet<>(Comparator.comparing(nodeVo -> nodeVo.getNodeId()))), ArrayList::new));

        //排序
        datas.sort(Comparator.comparing(FlowableNodeDTO::getEndTime));
        return datas;
    }

    //活动节点ID及办理人名字集合
    private Map<String, String> getApplyers(String processInstanceId, List<WorkFlowUserDTO> userList, Map<String, List<HistoricTaskInstance>> taskInstanceMap) {

        //用户ID =>用户信息
        Map<String, WorkFlowUserDTO> userMap = userList.stream()
                .collect(Collectors.toMap(WorkFlowUserDTO::getUserId, workFlowUserDTO -> workFlowUserDTO));

        //流程实例
        ProcessInstance processInstance = processEngine.getRuntimeService()
                .createProcessInstanceQuery()
                .processInstanceId(processInstanceId)
                .singleResult();

        Map<String, String> applyMap = new HashMap<>();
        //遍历历史任务
        taskInstanceMap.forEach((activityId, taskInstances) -> {
            StringBuffer applyers = new StringBuffer();
            StringBuffer finalApplyers = applyers;

            taskInstances.forEach(taskInstance -> {
                if (!taskInstance.getName().equals(FLOW_SUBMITTER)) {
                    WorkFlowUserDTO user = userMap.get(taskInstance.getAssignee());
                    if (user != null) {
                        if (StringUtils.indexOf(finalApplyers.toString(), user.getNickName()) == -1) {
                            finalApplyers.append(user.getNickName()).append(",");
                        }
                    }
                } else {
                    //流程启动人
                    String startUserId = processInstance.getStartUserId();
                    WorkFlowUserDTO workFlowUserDTO = workFlowUserService.selectUserByUserId(startUserId);
                   /* User user = processEngine.getIdentityService()
                            .createUserQuery().userId(startUserId)
                            .singleResult();*/
                    if (workFlowUserDTO != null) {
                        finalApplyers.append(workFlowUserDTO.getNickName()).append(",");
                    }
                }
            });
            if (applyers.length() > 0) {
                //去掉末尾逗号
                applyers = applyers.deleteCharAt(applyers.length() - 1);
            }
            applyMap.put(activityId, applyers.toString());
        });
        return applyMap;
    }

    @Override
    public void backToStepTask(BackTaskDTO params) {

        TaskEntity taskEntity = (TaskEntity) processEngine.getTaskService()
                .createTaskQuery()
                .taskId(params.getTaskId())
                .singleResult();
        if (taskEntity == null) {
            throw new BizException("没有运行时的任务实例,请确认!");
        }

        if (!processInsInRun(taskEntity.getProcessInstanceId())) {
            throw new BizException("该流程不在运行中,请确认!");
        }


        //1.把当前的节点设置为空
        //2.设置审批人
        taskEntity.setAssignee(authService.getLoginUser().getUserid().toString());
        processEngine.getTaskService().saveTask(taskEntity);
        //4.处理提交人节点
        FlowNode distActivity = flowableBpmnModelService.findFlowNodeByActivityId(taskEntity.getProcessDefinitionId(), params.getDistFlowElementId());
        if (distActivity != null) {
            if (FLOW_SUBMITTER.equals(distActivity.getName())) {
                ProcessInstance processInstance = processEngine.getRuntimeService()
                        .createProcessInstanceQuery()
                        .processInstanceId(taskEntity.getProcessInstanceId())
                        .singleResult();
                processEngine.getRuntimeService()
                        .setVariable(params.getProcessInstanceId(), FLOW_SUBMITTER_VAR, processInstance.getStartUserId());
            }
        }
        //5.删除节点
        this.deleteActivity(params.getDistFlowElementId(), taskEntity.getProcessInstanceId());
        List<String> executionIds = new ArrayList<>();
        //6.判断节点是不是子流程内部的节点
        if (flowableBpmnModelService.checkActivitySubprocessByActivityId(taskEntity.getProcessDefinitionId(), params.getDistFlowElementId())
                && flowableBpmnModelService.checkActivitySubprocessByActivityId(taskEntity.getProcessDefinitionId(), taskEntity.getTaskDefinitionKey())) {
            //6.1 子流程内部驳回
            Execution executionTask = processEngine.getRuntimeService().createExecutionQuery().executionId(taskEntity.getExecutionId()).singleResult();
            String parentId = executionTask.getParentId();
            List<Execution> executions = processEngine.getRuntimeService().createExecutionQuery().parentId(parentId).list();
            executions.forEach(execution -> executionIds.add(execution.getId()));
            this.moveExecutionsToSingleActivityId(executionIds, params.getDistFlowElementId());
        } else {
            //6.2 普通驳回
            List<Execution> executions = processEngine.getRuntimeService().createExecutionQuery().parentId(taskEntity.getProcessInstanceId()).list();
            executions.forEach(execution -> executionIds.add(execution.getId()));
            this.moveExecutionsToSingleActivityId(executionIds, params.getDistFlowElementId());
        }

        //添加驳回意见
        String targetTask = "";
        if (distActivity != null) {
            targetTask = distActivity.getName();
        }
        addComment(taskEntity.getId(), taskEntity.getName(), taskEntity.getTaskDefinitionKey(), taskEntity.getName(),
                taskEntity.getProcessInstanceId(), CommentTypeEnum.BH, params.getMessage(),
                authService.getLoginUser().getNickName() + " => 驳回任务 => " + "【" + taskEntity.getName() + "=>" + targetTask + "】");//action=>记录从哪驳回到哪
        //更新流程实例状态
        updateProinstStatus(params.getProcessInstanceId(), SPZ.toString());
    }

    @Override
    public byte[] createImage(String processInstanceId) {
        //1.获取当前的流程实例
        ProcessInstance processInstance = processEngine.getRuntimeService()
                .createProcessInstanceQuery()
                .processInstanceId(processInstanceId).singleResult();
        String processDefinitionId = null;
        List<String> activeActivityIds = new ArrayList<>();
        List<String> highLightedFlows = new ArrayList<>();
        //2.获取所有的历史轨迹线对象
        List<HistoricActivityInstance> historicSquenceFlows = processEngine.getHistoryService()
                .createHistoricActivityInstanceQuery()
                .processInstanceId(processInstanceId)
                .activityType(BpmnXMLConstants.ELEMENT_SEQUENCE_FLOW)
                .list();
        historicSquenceFlows.forEach(historicActivityInstance -> highLightedFlows.add(historicActivityInstance.getActivityId()));
        //3. 获取流程定义id和高亮的节点id
        if (processInstance != null) {
            //3.1. 正在运行的流程实例
            processDefinitionId = processInstance.getProcessDefinitionId();
            activeActivityIds = processEngine.getRuntimeService()
                    .getActiveActivityIds(processInstanceId);
        } else {
            //3.2. 已经结束的流程实例
            HistoricProcessInstance historicProcessInstance = processEngine.getHistoryService()
                    .createHistoricProcessInstanceQuery()
                    .processInstanceId(processInstanceId)
                    .singleResult();
            processDefinitionId = historicProcessInstance.getProcessDefinitionId();
            //3.3. 获取结束节点列表
            List<HistoricActivityInstance> historicEnds = processEngine.getHistoryService()
                    .createHistoricActivityInstanceQuery()
                    .processInstanceId(processInstanceId)
                    .activityType(BpmnXMLConstants.ELEMENT_EVENT_END).list();
            List<String> finalActiveActivityIds = activeActivityIds;
            historicEnds.forEach(historicActivityInstance -> finalActiveActivityIds.add(historicActivityInstance.getActivityId()));
        }
        //4. 获取bpmnModel对象
        BpmnModel bpmnModel = flowableBpmnModelService.getBpmnModelByProcessDefId(processDefinitionId);
        //5. 生成图片流
        InputStream inputStream = flowProcessDiagramGenerator.generateDiagram(bpmnModel, activeActivityIds, highLightedFlows);
        //6. 转化成byte便于网络传输
        byte[] datas = IoUtil.readInputStream(inputStream, "image inputStream name");
        return datas;
    }


    @Override
    public void rollback(RollbackTaskDTO params) {
        /*addComment(params.getTaskId(), params.getProcessInstanceId(),
                CommentTypeEnum.CH.toString(), params.getMessage());*/
       /* TaskEntity taskEntity = (TaskEntity) processEngine.getTaskService()
                .createTaskQuery()
                .taskId(params.getTaskId())
                .singleResult();*/
        HistoricTaskInstance taskEntity = processEngine.getHistoryService()
                .createHistoricTaskInstanceQuery()
                .taskId(params.getTaskId())
                .singleResult();
        if (taskEntity == null) {
            throw new BizException("该任务无法回撤,请确认!");
        }

        if (!processInsInRun(taskEntity.getProcessInstanceId())) {
            throw new BizException("该流程不在运行中,请确认!");
        }

        addComment(taskEntity.getId(), taskEntity.getName(), taskEntity.getTaskDefinitionKey(), taskEntity.getName(),
                taskEntity.getProcessInstanceId(), CommentTypeEnum.CH, params.getMessage(),
                "任务回撤！");//action=>记录加签给谁
        //撤回记录=》校验
        processEngine.getManagementService().executeCommand(new RollbackCmd(params.getTaskId(), params.getUserId()));
        updateProcessInsStatus(params.getProcessInstanceId(), ProcessStatusEnum.CH.toString());
    }

    @Override
    public void updateState(Integer state, String processInstanceId) {
        // 激活
        if (state == PROCESSACTIVE) {
            processEngine.getRuntimeService()
                    .activateProcessInstanceById(processInstanceId);
        }
        // 挂起
        if (state == PROCESSSUSPEND) {
            processEngine.getRuntimeService()
                    .suspendProcessInstanceById(processInstanceId);
        }
    }

    @Override
    public void updateTaskCandidateGroup(UpdateCandidateTaskDTO params) {

        List<IdentityLink> identityLinks = processEngine.getTaskService().getIdentityLinksForTask(params.getTaskId());

        IdentityLink identityLink = identityLinks.stream()
                .filter(_identityLink -> IdentityLinkType.CANDIDATE.equalsIgnoreCase(_identityLink.getType()))
                .findAny()
                .orElse(null);

        //说明有候选信息
        if (identityLink != null) {
            flowableExtensionMapper.deleteCandidateGroupByTaskId(params.getTaskId());

            if (CollectionUtils.isNotEmpty(params.getCandidateGroupDTOS())) {
                params.getCandidateGroupDTOS().forEach(
                        _group -> {

                            String groupKey = workFlowGroupService.generatorGroupKey(_group.getAreaKey(), _group.getDeptKey(), _group.getRoleKey());


                            processEngine.getTaskService().addCandidateGroup(params.getTaskId(), groupKey);
                        }
                );

            }

        }


    }

    @Override
    public void addTaskCandidateGroup(UpdateCandidateTaskDTO params) {
        if (CollectionUtils.isNotEmpty(params.getCandidateGroupDTOS())) {
            params.getCandidateGroupDTOS().forEach(
                    _group -> {

                        String groupKey = workFlowGroupService.generatorGroupKey(_group.getAreaKey(), _group.getDeptKey(), _group.getRoleKey());

                        processEngine.getTaskService().addCandidateGroup(params.getTaskId(), groupKey);
                    }
            );

        }
    }


    public List<WorkFlowButton> findButtonsByTaskId(String taskId, ButtonTypeEnum buttonTypeEnum) {

        //待办
        if (StringUtils.isNotBlank(taskId) && (buttonTypeEnum == TODO)) {
            TaskQuery taskQuery = processEngine.getTaskService()
                    .createTaskQuery();
            taskQuery.taskId(taskId);
            Task task = taskQuery.singleResult();
            TaskEntityImpl taskEntity = (TaskEntityImpl) task;
            List<WorkFlowButton> buttonListFromModel = getButtonListFromModel(taskEntity.getProcessDefinitionId(), taskEntity.getTaskDefinitionKey());

        }
        //已办
        if (StringUtils.isNotBlank(taskId) && (buttonTypeEnum == ButtonTypeEnum.DONE)) {
            HistoricTaskInstance historicTaskInstance = processEngine.getHistoryService()
                    .createHistoricTaskInstanceQuery()
                    .taskId(taskId)
                    .singleResult();
            List<WorkFlowButton> buttonListFromModel = getButtonListFromModel(historicTaskInstance.getProcessDefinitionId(), historicTaskInstance.getTaskDefinitionKey());
        }

        //流程

        //临时测试=》后期配置在流程图中
        LambdaQueryWrapper<WorkFlowButton> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.eq(WorkFlowButton::getButtonTypeEnum, buttonTypeEnum);
        List<WorkFlowButton> buttonList = workFlowButtonService.list(lambdaQueryWrapper);
        return buttonList;

    }

    private void updateProcessInsStatus(String processInstanceId, String status) {
        //1.更新历史的流程实例的扩展信息
        WorkFlowExtendHisprocinst workFlowExtendHisprocinst = workFlowExtendHisprocinstService.findExtendHisprocinstByProcessInstanceId(processInstanceId);
        if (workFlowExtendHisprocinst != null && !ProcessStatusEnum.ZZ.toString().equals(workFlowExtendHisprocinst.getProcessStatus())) {
            //更新状态为办结
            LambdaUpdateWrapper<WorkFlowExtendHisprocinst> lambdaUpdateWrapper = new LambdaUpdateWrapper();
            lambdaUpdateWrapper.set(WorkFlowExtendHisprocinst::getProcessStatus, status)
                    .eq(WorkFlowExtendHisprocinst::getProcessInstanceId, processInstanceId);
            workFlowExtendHisprocinstService.update(lambdaUpdateWrapper);
        }
    }

    private boolean processInsInRun(String processInstanceId) {
        WorkFlowExtendHisprocinst workFlowExtendHisprocinst = workFlowExtendHisprocinstService.findExtendHisprocinstByProcessInstanceId(processInstanceId);
        if (workFlowExtendHisprocinst != null
                && !ProcessStatusEnum.ZZ.toString().equals(workFlowExtendHisprocinst.getProcessStatus())
                && !ProcessStatusEnum.BJ.toString().equals(workFlowExtendHisprocinst.getProcessStatus())
        ) {

            return true;
        }
        return false;
    }


    private TaskEntity createSubTask(TaskEntity ptask, String assignee) {
        return this.createSubTask(ptask, ptask.getId(), assignee);
    }

    /**
     * 创建子任务
     *
     * @param ptask    创建子任务
     * @param assignee 子任务的执行人
     * @return
     */
    private TaskEntity createSubTask(TaskEntity ptask, String ptaskId, String assignee) {
        TaskEntity task = null;
        if (ptask != null) {
            //1.生成子任务
            task = (TaskEntity) processEngine.getTaskService()
                    .newTask(Long.toString(snowIdUtils.nextId()));
            task.setCategory(ptask.getCategory());
            task.setDescription(ptask.getDescription());
            task.setTenantId(ptask.getTenantId());
            task.setAssignee(assignee);
            task.setName(ptask.getName());
            task.setParentTaskId(ptaskId);
            task.setProcessDefinitionId(ptask.getProcessDefinitionId());
            task.setProcessInstanceId(ptask.getProcessInstanceId());
            task.setTaskDefinitionKey(ptask.getTaskDefinitionKey());
            task.setTaskDefinitionId(ptask.getTaskDefinitionId());
            task.setPriority(ptask.getPriority());
            task.setCreateTime(new Date());
            processEngine.getTaskService()
                    .saveTask(task);
        }
        return task;
    }

    /**
     * 添加审批意见
     *
     * @param taskId       任务id任务名称流程实例id
     * @param processInsId 流程实例id
     * @param activityName 节点名字
     * @param type         审批类型
     * @param message      审批意见
     */

    private void addComment(String taskId, String taskName, String activityId, String activityName, String processInsId, CommentTypeEnum type, String message, String action) {
        //自定义审核操作表
        WorkFlowHiComment workFlowHiComment = new WorkFlowHiComment();
        workFlowHiComment.setCommentTypeEnum(type);
        workFlowHiComment.setProcessInsId(processInsId);
        workFlowHiComment.setTaskId(taskId);
        workFlowHiComment.setTaskName(taskName);
        workFlowHiComment.setActivityId(activityId);
        workFlowHiComment.setActivityName(activityName);
        workFlowHiComment.setMessage(message);
        workFlowHiComment.setAction(action);
        workFlowHiComment.setTime(new Date());
        workFlowHiComment.setUserId(authService.getLoginUser().getUserid().toString());
        workFlowHiComment.setUserName(authService.getLoginUser().getNickName());
        workFlowHiCommentService.save(workFlowHiComment);
    }

    /**
     * 更新流程实例状态
     *
     * @param processInstanceId 流程实例id
     * @param type              流程状态
     */
    private void updateProinstStatus(String processInstanceId, String type) {
        //1.更新历史的流程实例的扩展信息
        WorkFlowExtendHisprocinst workFlowExtendHisprocinst = workFlowExtendHisprocinstService.findExtendHisprocinstByProcessInstanceId(processInstanceId);
        if (workFlowExtendHisprocinst != null) {
            //更新状态为办结
            LambdaUpdateWrapper<WorkFlowExtendHisprocinst> lambdaUpdateWrapper = new LambdaUpdateWrapper();
            lambdaUpdateWrapper.set(WorkFlowExtendHisprocinst::getProcessStatus, type)
                    .eq(WorkFlowExtendHisprocinst::getProcessInstanceId, processInstanceId);
            workFlowExtendHisprocinstService.update(lambdaUpdateWrapper);
        }
    }

    /**
     * 执行跳转
     */
    private void moveExecutionsToSingleActivityId(List<String> executionIds, String activityId) {
        processEngine.getRuntimeService()
                .createChangeActivityStateBuilder()
                .moveExecutionsToSingleActivityId(executionIds, activityId)
                .changeState();
    }

    /**
     * 删除跳转的历史节点信息
     *
     * @param disActivityId     跳转的节点id
     * @param processInstanceId 流程实例id
     */
    protected void deleteActivity(String disActivityId, String processInstanceId) {
        List<ActivityInstance> disActivities = flowableExtensionMapper
                .queryActivityInstance(disActivityId, processInstanceId, null);

        //删除运行时和历史节点信息
        if (CollectionUtils.isNotEmpty(disActivities)) {
            ActivityInstance activityInstance = disActivities.get(0);
            List<ActivityInstance> datas = flowableExtensionMapper
                    .queryActivityInstance(disActivityId, processInstanceId, activityInstance.getEndTime());

            List<String> runActivityIds = new ArrayList<>();
            if (CollectionUtils.isNotEmpty(datas)) {
                datas.forEach(ai -> runActivityIds.add(ai.getId()));
                flowableExtensionMapper.deleteRunActinstsByIds(runActivityIds);
                flowableExtensionMapper.deleteHisActinstsByIds(runActivityIds);
            }
        }
    }

    /**
     * 获取流程模型配置的按钮信息
     *
     * @param processDefId 流程定义ID
     * @param taskDefKey   流程任务Key
     */
    private List<WorkFlowButton> getButtonListFromModel(String processDefId, String taskDefKey) {

        //获取bpmn模型对象
        BpmnModel bpmnModel = processEngine.getRepositoryService()
                .getBpmnModel(processDefId);

        //获取任务节点元素
        FlowElement flowElement = bpmnModel.getFlowElement(taskDefKey);

        List<WorkFlowButton> buttons = new ArrayList<>();
        //节点元素为空或者不是用户任务或启动任务=》直接返回空集合
        if (ObjectUtils.isEmpty(flowElement) || !(flowElement instanceof UserTask || flowElement instanceof StartEvent)) {
            return buttons;
        }

        //扩展属性=》修改成按钮配置
        Map<String, List<ExtensionElement>> map = flowElement.getExtensionElements();
        if (MapUtils.isEmpty(map)) {
            return buttons;
        }

        //解析bpmn中的按钮配置列表
        List<ExtensionElement> buttonElement = map.get(ELEMENT_BUTTON);
        if (!CollectionUtils.isEmpty(buttonElement)) {
            buttonElement.forEach(extensionElement -> {
                if (!ObjectUtils.isEmpty(extensionElement)) {
                    WorkFlowButton workFlowButton = new WorkFlowButton();
                    workFlowButton.setButtonName(extensionElement.getAttributeValue(null, "name"));
                    workFlowButton.setButtonCode(extensionElement.getAttributeValue(null, "code"));
                    workFlowButton.setButtonTypeEnum(getButtonTypeEnumByKey(extensionElement.getAttributeValue(null, "type")));
                    workFlowButton.setOrderNum(extensionElement.getAttributeValue(null, "orderNum"));
                    workFlowButton.setDesc(extensionElement.getAttributeValue(null, "desc"));
                    buttons.add(workFlowButton);
                }
            });
        }
        return buttons;

    }

}
