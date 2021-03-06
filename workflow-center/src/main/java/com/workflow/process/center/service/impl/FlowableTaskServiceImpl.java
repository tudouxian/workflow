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
 * @Author: ?????????
 * @Date: 2021/6/28 15:15
 * @Description: flowable??????????????????
 */
@Slf4j
@Service
@Transactional
public class FlowableTaskServiceImpl implements FlowableTaskService {

    //????????????????????????

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
     * ????????????????????????
     *
     * @param processInstanceId ????????????id
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

        //1.???????????????????????????
        TaskEntity taskEntity = (TaskEntity) processEngine.getTaskService()
                .createTaskQuery()
                .taskId(params.getTaskId())
                .singleResult();
        if (taskEntity == null) {
            throw new BizException("?????????id????????????????????????");
        }

        if (!processInsInRun(taskEntity.getProcessInstanceId())) {
            throw new BizException("????????????????????????,?????????!");
        }

        String taskId = params.getTaskId();
        //??????????????????
        addComment(taskEntity.getId(), taskEntity.getName(), taskEntity.getTaskDefinitionKey(), taskEntity.getName(),
                taskEntity.getProcessInstanceId(), CommentTypeEnum.SP, params.getMessage(),
                authService.getLoginUser().getNickName() + " => ?????? => " + taskEntity.getName());
        //????????????????????????
        updateProinstStatus(params.getProcessInstanceId(), SPZ.toString());

        //2.????????????
        if (DelegationState.PENDING.equals(taskEntity.getDelegationState())) {
            //2.1??????????????????
            TaskEntity task = this.createSubTask(taskEntity, params.getUserId());
            processEngine.getTaskService()
                    .complete(task.getId());
            taskId = task.getId();
            //2.2????????????
            processEngine.getTaskService()
                    .resolveTask(params.getTaskId(), params.getVariables());
        } else {
            //3.1??????????????? -??????
            processEngine.getTaskService()
                    .setAssignee(params.getTaskId(), params.getUserId());

            //????????????????????????????????????-??????????????????????????????
            if (SYNERGY.equals(taskEntity.getScopeType()) && StringUtils.isEmpty(taskEntity.getParentTaskId())) {

                List<String> synergyTaskIds = flowableExtensionMapper.querySubTaskByParentTaskIdAndScopeType(SYNERGY, taskEntity.getId());
                //??????????????????
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

            //3.2????????????
            processEngine.getTaskService()
                    .complete(params.getTaskId(), params.getVariables());
            //4.?????????????????????
            String parentTaskId = taskEntity.getParentTaskId();
            if (StringUtils.isNotBlank(parentTaskId)) {
                int subTaskCount = flowableExtensionMapper.querySubTaskByParentTaskId(parentTaskId);
                //???????????????????????????
                if (subTaskCount == 0) {
                    Task task = processEngine.getTaskService()
                            .createTaskQuery()
                            .taskId(parentTaskId)
                            .singleResult();

                    //???????????????????????????
                    processEngine.getTaskService()
                            .resolveTask(parentTaskId);
                    if (AFTER_ADDSIGN.equals(task.getScopeType())) {
                        processEngine.getTaskService()
                                .complete(parentTaskId);
                    }
                }
            }
        }
        //TODO ??????mongodb??????????????????????????????
    }

    @Override
    public void stopProcessInstanceById(EndTaskDTO params) {
        ProcessInstance processInstance = processEngine.getRuntimeService()
                .createProcessInstanceQuery()
                .processInstanceId(params.getProcessInstanceId())
                .singleResult();
        if (processInstance == null) {
            throw new BizException("????????????????????????,?????????!");
        }

        //1?????????????????????
        //??????????????????
        addComment(null, null, null, null,
                params.getProcessInstanceId(), CommentTypeEnum.QZJS, params.getMessage(),
                authService.getLoginUser().getNickName() + " => ?????????????????? ");
        //????????????????????????
        updateProinstStatus(params.getProcessInstanceId(), ProcessStatusEnum.QZJS.toString());

        //2?????????????????????
        List<EndEvent> endNodes = flowableBpmnModelService.findEndFlowElement(processInstance.getProcessDefinitionId());
        String endId = endNodes.get(0).getId();
        String processInstanceId = params.getProcessInstanceId();
        //2???????????????
        List<Execution> executions = processEngine.getRuntimeService()
                .createExecutionQuery()
                .parentId(processInstanceId)
                .list();
        List<String> executionIds = new ArrayList<>();
        executions.forEach(execution -> executionIds.add(execution.getId()));
        //3????????????????????????
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
            throw new BizException("????????????????????????,?????????!");
        }

        //??????
        processEngine.getRuntimeService()
                .deleteProcessInstance(params.getProcessInstanceId(), params.getMessage());

        /*//2.???????????????
        processEngine.getRuntimeService()
                .setVariable(params.getProcessInstanceId(), FLOW_SUBMITTER_VAR, processInstance.getStartUserId());
        //3.????????????
        Activity disActivity = flowableBpmnModelService.findActivityByName(processInstance.getProcessDefinitionId(), FLOW_SUBMITTER);

        //????????????????????????????????????=??????????????????
        if (disActivity !=null){
            //4.????????????????????????????????????
            deleteActivity(disActivity.getId(), params.getProcessInstanceId());
            //5.????????????
            List<Execution> executions = processEngine.getRuntimeService()
                    .createExecutionQuery()
                    .parentId(params.getProcessInstanceId())
                    .list();
            List<String> executionIds = new ArrayList<>();
            executions.forEach(execution -> executionIds.add(execution.getId()));
            moveExecutionsToSingleActivityId(executionIds, disActivity.getId());
        }else {
            //??????
            processEngine.getRuntimeService()
                    .deleteProcessInstance(params.getProcessInstanceId(),params.getMessage());
        }*/

        //1.??????????????????=>
        addComment(null, null, null, null,
                params.getProcessInstanceId(), CommentTypeEnum.LCZZ, params.getMessage(),
                authService.getLoginUser().getNickName() + " => ?????????????????? => ");
        //????????????????????????
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
            throw new BizException("??????????????????????????????,?????????!");
        }

        if (!processInsInRun(currTask.getProcessInstanceId())) {
            throw new BizException("????????????????????????,?????????!");
        }
        //1.??????????????????
        TaskEntity task = createSubTask(currTask, params.getUserId());

        processEngine.getTaskService().complete(task.getId());
        //3.??????
        processEngine.getTaskService().setAssignee(params.getTaskId(), params.getTurnToUserId());
        processEngine.getTaskService().setOwner(params.getTaskId(), params.getUserId());


        String targetUser = "";
        WorkFlowUserDTO workFlowUserDTO = workFlowUserService.selectUserByUserId(params.getTurnToUserId());
        if (workFlowUserDTO != null) {
            targetUser = workFlowUserDTO.getNickName();
        }
        //2.??????????????????
        addComment(currTask.getId(), currTask.getName(), currTask.getTaskDefinitionKey(), currTask.getName(),
                currTask.getProcessInstanceId(), CommentTypeEnum.ZB, params.getMessage(),
                authService.getLoginUser().getNickName() + " => ?????? => " + currTask.getName() + "???" + targetUser + "???");//action=>????????????????????????
        //????????????????????????
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
            throw new BizException("??????????????????????????????,?????????!");
        }

        if (!processInsInRun(currTask.getProcessInstanceId())) {
            throw new BizException("????????????????????????,?????????!");
        }

        //2.????????????????????????????????????
        processEngine.getTaskService().setAssignee(params.getTaskId(), params.getUserId());
        //3.????????????
        processEngine.getTaskService().delegateTask(params.getTaskId(), params.getDelegateUserId());

        String targetUser = "";
        WorkFlowUserDTO workFlowUserDTO = workFlowUserService.selectUserByUserId(params.getDelegateUserId());
        if (workFlowUserDTO != null) {
            targetUser = workFlowUserDTO.getNickName();
        }
        //1.??????????????????
        addComment(currTask.getId(), currTask.getName(), currTask.getTaskDefinitionKey(), currTask.getName(),
                currTask.getProcessInstanceId(), CommentTypeEnum.WP, params.getMessage(),
                authService.getLoginUser().getNickName() + " => ?????? => " + currTask.getName() + "???" + targetUser + "???");//action=>??????????????????
        //????????????????????????
        updateProinstStatus(params.getProcessInstanceId(), SPZ.toString());
    }

    @Override
    public void claimTask(ClaimTaskDTO params) {
        TaskEntityImpl currTask = (TaskEntityImpl) processEngine.getTaskService()
                .createTaskQuery()
                .taskId(params.getTaskId())
                .singleResult();
        if (currTask == null) {
            throw new BizException("??????????????????????????????,?????????!");
        }

        if (!processInsInRun(currTask.getProcessInstanceId())) {
            throw new BizException("????????????????????????,?????????!");
        }

        //2.??????-?????????????????????
        /*processEngine.getManagementService()
                .executeCommand(new MyClaimTaskCmd(params.getTaskId(), params.getUserCode()));*/
        //??????????????????
        processEngine.getTaskService()
                .claim(params.getTaskId(), params.getUserId());

        //1.??????????????????
        addComment(currTask.getId(), currTask.getName(), currTask.getTaskDefinitionKey(), currTask.getName(),
                currTask.getProcessInstanceId(), CommentTypeEnum.QS, params.getMessage(),
                authService.getLoginUser().getNickName() + " => ???????????? => " + currTask.getName());//action=>??????????????????
        //????????????????????????
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
            throw new BizException("??????????????????????????????,?????????!");
        }

        if (!processInsInRun(currTask.getProcessInstanceId())) {
            throw new BizException("????????????????????????,?????????!");
        }

        //2.?????????
        //??????????????????????????????????????????-????????????????????????
        if (isTaskHasCandidateUserOrCandidateGroup(params.getTaskId())) {
            processEngine.getTaskService().claim(params.getTaskId(), null);
                /*processEngine.getManagementService()
                        .executeCommand(new MyClaimTaskCmd(params.getTaskId(), null));*/
        } else {
            throw new BizException("?????????????????????????????????,???????????????????????????,?????????.");
        }
        //1.??????????????????
        addComment(currTask.getId(), currTask.getName(), currTask.getTaskDefinitionKey(), currTask.getName(),
                currTask.getProcessInstanceId(), CommentTypeEnum.GH, params.getMessage(),
                authService.getLoginUser().getNickName() + " => ???????????? => " + currTask.getName());//action=>??????????????????

        //????????????????????????
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
            throw new BizException("??????????????????????????????,?????????!");
        }

        if (!processInsInRun(taskEntity.getProcessInstanceId())) {
            throw new BizException("????????????????????????,?????????!");
        }

        String users = "";
        List<WorkFlowUserDTO> workFlowUserDTOS = workFlowUserService.selectUserByUserIds(params.getSynergyUserIds());
        if (CollectionUtils.isNotEmpty(workFlowUserDTOS)) {
            users = workFlowUserDTOS.stream()
                    .map(WorkFlowUserDTO::getNickName)
                    .collect(Collectors.joining(","));
        }

        //???????????????????????????
        String parentTaskId = taskEntity.getParentTaskId();
        if (StringUtils.isNotBlank(parentTaskId)) {
            throw new BizException("???????????????????????????????????????");
        }

        //??????????????????
        addComment(taskEntity.getId(), taskEntity.getName(), taskEntity.getTaskDefinitionKey(), taskEntity.getName(),
                taskEntity.getProcessInstanceId(), CommentTypeEnum.XT, params.getMessage(),
                authService.getLoginUser().getNickName() + " => ?????? => " + taskEntity.getName() + "???" + users + "???");//action=>???????????????


        //????????????????????????
        updateProinstStatus(params.getProcessInstanceId(), SPZ.toString());

        //??????????????????
        taskEntity.setScopeType(SYNERGY);

        //?????????????????????
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
     * ??????????????????
     *
     * @param ptask    ??????????????????
     * @param assignee ????????????????????????
     * @return
     */
    private TaskEntity createSynergyTask(TaskEntity ptask, String ptaskId, String assignee) {
        TaskEntity task = null;
        if (ptask != null) {
            //1.???????????????
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
            throw new BizException("??????????????????????????????,?????????!");
        }

        if (!processInsInRun(taskEntity.getProcessInstanceId())) {
            throw new BizException("????????????????????????,?????????!");
        }

        String users = "";
        List<WorkFlowUserDTO> workFlowUserDTOS = workFlowUserService.selectUserByUserIds(addSignTaskDTO.getSignUserIds());
        if (CollectionUtils.isNotEmpty(workFlowUserDTOS)) {
            users = workFlowUserDTOS.stream()
                    .map(WorkFlowUserDTO::getNickName)
                    .collect(Collectors.joining(","));
        }
        //??????????????????
        CommentTypeEnum type = flag ? CommentTypeEnum.HJQ : CommentTypeEnum.QJQ;
        addComment(taskEntity.getId(), taskEntity.getName(), taskEntity.getTaskDefinitionKey(), taskEntity.getName(),
                taskEntity.getProcessInstanceId(), type, addSignTaskDTO.getMessage(),
                authService.getLoginUser().getNickName() + " => ?????? => " + taskEntity.getName() + "???" + users + "???");//action=>??????????????????


        //1.1 ??????????????????????????????
        //????????????????????????
        // String parentTaskId = taskEntity.getParentTaskId();

        taskEntity.setOwner(addSignTaskDTO.getUserId());
        taskEntity.setAssignee(null);
        taskEntity.setCountEnabled(true);
        if (flag) {
            taskEntity.setScopeType(AFTER_ADDSIGN);
        } else {
            taskEntity.setScopeType(BEFORE_ADDSIGN);
        }
        //1.2 ???????????????????????????
        processEngine.getTaskService()
                .saveTask(taskEntity);

        //2.??????????????????
        createSignSubTasks(addSignTaskDTO, taskEntity);


    }

    /**
     * ?????????????????????
     *
     * @param addSignTaskDTO ????????????
     * @param taskEntity     ?????????
     */
    private void createSignSubTasks(AddSignTaskDTO addSignTaskDTO, TaskEntity taskEntity) {
        if (CollectionUtils.isNotEmpty(addSignTaskDTO.getSignUserIds())) {
            //1.?????????????????????????????????
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
            //2.???????????????????????????????????????
            Task task = createSubTask(taskEntity, finalParentTaskId, addSignTaskDTO.getUserId());
            processEngine.getTaskService().complete(task.getId());

           /* String taskId = taskEntity.getId();
            if (StringUtils.isBlank(taskEntity.getParentTaskId())) {
                //2.???????????????????????????????????????
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
            //??????????????????????????????????????????????????????????????????
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
        //?????????????????????????????????????????????????????????usertask
        List<ActivityInstance> activityInstances = flowableExtensionMapper.queryActivityInstanceByType(processInstanceId, ELEMENT_TASK_USER);

        //?????????????????????????????????????????????????????????parallelGateway???????????????
        String currActId = taskEntity.getTaskDefinitionKey();
        List<ActivityInstance> parallelGatewaies = flowableExtensionMapper.queryActivityInstanceByTypeAndRemoveDuplicates(processInstanceId, currActId, ELEMENT_GATEWAY_PARALLEL);
        //??????
        if (CollectionUtils.isNotEmpty(parallelGatewaies)) {
            activityInstances.addAll(parallelGatewaies);
            activityInstances.sort(Comparator.comparing(ActivityInstance::getEndTime));
        }
        //????????????
        int count = 0;
        //????????????????????????
        Map<ActivityInstance, List<ActivityInstance>> parallelGatewayUserTasks = new HashMap<>();
        //????????????
        List<ActivityInstance> userTasks = new ArrayList<>();
        //????????????
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
                    //???????????????????????????
                    userTasks.add(activityInstance);
                } else {
                    if (parallelGatewayUserTasks.containsKey(currActivityInstance)) {
                        //????????????????????????????????????
                        parallelGatewayUserTasks.get(currActivityInstance).add(activityInstance);
                    }
                }
            }
        }
        //????????????????????????????????????
        List<HistoricTaskInstance> historicTaskInstances = processEngine.getHistoryService()
                .createHistoricTaskInstanceQuery()
                .processInstanceId(processInstanceId)
                .finished()
                .list();
        Map<String, List<HistoricTaskInstance>> taskInstanceMap = new HashMap<>();

        //?????????????????????ID
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
        //??????usertask????????? =>????????????

        List<WorkFlowUserDTO> workFlowUserDTOS = workFlowUserService.selectUserByUserIds(userIDs);

   /*     List<User> userList = processEngine.getIdentityService()
                .createUserQuery()
                .userIds(userIDs)
                .list();*/

        //??????????????????
        List<FlowableNodeDTO> backNods = new ArrayList<>();

        //????????????ID????????????
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
        //????????????????????????
        if (MapUtils.isNotEmpty(taskInstanceMap)) {
            parallelGatewayUserTasks.forEach((activity, activities) -> {
                FlowableNodeDTO node = new FlowableNodeDTO();
                node.setNodeId(activity.getActivityId());
                node.setEndTime(activity.getEndTime());
                StringBuffer nodeNames = new StringBuffer("??????:");
                StringBuffer userNames = new StringBuffer("????????????:");
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
        //????????????
        List<FlowableNodeDTO> datas = backNods.stream().collect(
                Collectors.collectingAndThen(Collectors.toCollection(() ->
                        new TreeSet<>(Comparator.comparing(nodeVo -> nodeVo.getNodeId()))), ArrayList::new));

        //??????
        datas.sort(Comparator.comparing(FlowableNodeDTO::getEndTime));
        return datas;
    }

    //????????????ID????????????????????????
    private Map<String, String> getApplyers(String processInstanceId, List<WorkFlowUserDTO> userList, Map<String, List<HistoricTaskInstance>> taskInstanceMap) {

        //??????ID =>????????????
        Map<String, WorkFlowUserDTO> userMap = userList.stream()
                .collect(Collectors.toMap(WorkFlowUserDTO::getUserId, workFlowUserDTO -> workFlowUserDTO));

        //????????????
        ProcessInstance processInstance = processEngine.getRuntimeService()
                .createProcessInstanceQuery()
                .processInstanceId(processInstanceId)
                .singleResult();

        Map<String, String> applyMap = new HashMap<>();
        //??????????????????
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
                    //???????????????
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
                //??????????????????
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
            throw new BizException("??????????????????????????????,?????????!");
        }

        if (!processInsInRun(taskEntity.getProcessInstanceId())) {
            throw new BizException("????????????????????????,?????????!");
        }


        //1.??????????????????????????????
        //2.???????????????
        taskEntity.setAssignee(authService.getLoginUser().getUserid().toString());
        processEngine.getTaskService().saveTask(taskEntity);
        //4.?????????????????????
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
        //5.????????????
        this.deleteActivity(params.getDistFlowElementId(), taskEntity.getProcessInstanceId());
        List<String> executionIds = new ArrayList<>();
        //6.?????????????????????????????????????????????
        if (flowableBpmnModelService.checkActivitySubprocessByActivityId(taskEntity.getProcessDefinitionId(), params.getDistFlowElementId())
                && flowableBpmnModelService.checkActivitySubprocessByActivityId(taskEntity.getProcessDefinitionId(), taskEntity.getTaskDefinitionKey())) {
            //6.1 ?????????????????????
            Execution executionTask = processEngine.getRuntimeService().createExecutionQuery().executionId(taskEntity.getExecutionId()).singleResult();
            String parentId = executionTask.getParentId();
            List<Execution> executions = processEngine.getRuntimeService().createExecutionQuery().parentId(parentId).list();
            executions.forEach(execution -> executionIds.add(execution.getId()));
            this.moveExecutionsToSingleActivityId(executionIds, params.getDistFlowElementId());
        } else {
            //6.2 ????????????
            List<Execution> executions = processEngine.getRuntimeService().createExecutionQuery().parentId(taskEntity.getProcessInstanceId()).list();
            executions.forEach(execution -> executionIds.add(execution.getId()));
            this.moveExecutionsToSingleActivityId(executionIds, params.getDistFlowElementId());
        }

        //??????????????????
        String targetTask = "";
        if (distActivity != null) {
            targetTask = distActivity.getName();
        }
        addComment(taskEntity.getId(), taskEntity.getName(), taskEntity.getTaskDefinitionKey(), taskEntity.getName(),
                taskEntity.getProcessInstanceId(), CommentTypeEnum.BH, params.getMessage(),
                authService.getLoginUser().getNickName() + " => ???????????? => " + "???" + taskEntity.getName() + "=>" + targetTask + "???");//action=>????????????????????????
        //????????????????????????
        updateProinstStatus(params.getProcessInstanceId(), SPZ.toString());
    }

    @Override
    public byte[] createImage(String processInstanceId) {
        //1.???????????????????????????
        ProcessInstance processInstance = processEngine.getRuntimeService()
                .createProcessInstanceQuery()
                .processInstanceId(processInstanceId).singleResult();
        String processDefinitionId = null;
        List<String> activeActivityIds = new ArrayList<>();
        List<String> highLightedFlows = new ArrayList<>();
        //2.????????????????????????????????????
        List<HistoricActivityInstance> historicSquenceFlows = processEngine.getHistoryService()
                .createHistoricActivityInstanceQuery()
                .processInstanceId(processInstanceId)
                .activityType(BpmnXMLConstants.ELEMENT_SEQUENCE_FLOW)
                .list();
        historicSquenceFlows.forEach(historicActivityInstance -> highLightedFlows.add(historicActivityInstance.getActivityId()));
        //3. ??????????????????id??????????????????id
        if (processInstance != null) {
            //3.1. ???????????????????????????
            processDefinitionId = processInstance.getProcessDefinitionId();
            activeActivityIds = processEngine.getRuntimeService()
                    .getActiveActivityIds(processInstanceId);
        } else {
            //3.2. ???????????????????????????
            HistoricProcessInstance historicProcessInstance = processEngine.getHistoryService()
                    .createHistoricProcessInstanceQuery()
                    .processInstanceId(processInstanceId)
                    .singleResult();
            processDefinitionId = historicProcessInstance.getProcessDefinitionId();
            //3.3. ????????????????????????
            List<HistoricActivityInstance> historicEnds = processEngine.getHistoryService()
                    .createHistoricActivityInstanceQuery()
                    .processInstanceId(processInstanceId)
                    .activityType(BpmnXMLConstants.ELEMENT_EVENT_END).list();
            List<String> finalActiveActivityIds = activeActivityIds;
            historicEnds.forEach(historicActivityInstance -> finalActiveActivityIds.add(historicActivityInstance.getActivityId()));
        }
        //4. ??????bpmnModel??????
        BpmnModel bpmnModel = flowableBpmnModelService.getBpmnModelByProcessDefId(processDefinitionId);
        //5. ???????????????
        InputStream inputStream = flowProcessDiagramGenerator.generateDiagram(bpmnModel, activeActivityIds, highLightedFlows);
        //6. ?????????byte??????????????????
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
            throw new BizException("?????????????????????,?????????!");
        }

        if (!processInsInRun(taskEntity.getProcessInstanceId())) {
            throw new BizException("????????????????????????,?????????!");
        }

        addComment(taskEntity.getId(), taskEntity.getName(), taskEntity.getTaskDefinitionKey(), taskEntity.getName(),
                taskEntity.getProcessInstanceId(), CommentTypeEnum.CH, params.getMessage(),
                "???????????????");//action=>??????????????????
        //????????????=?????????
        processEngine.getManagementService().executeCommand(new RollbackCmd(params.getTaskId(), params.getUserId()));
        updateProcessInsStatus(params.getProcessInstanceId(), ProcessStatusEnum.CH.toString());
    }

    @Override
    public void updateState(Integer state, String processInstanceId) {
        // ??????
        if (state == PROCESSACTIVE) {
            processEngine.getRuntimeService()
                    .activateProcessInstanceById(processInstanceId);
        }
        // ??????
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

        //?????????????????????
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

        //??????
        if (StringUtils.isNotBlank(taskId) && (buttonTypeEnum == TODO)) {
            TaskQuery taskQuery = processEngine.getTaskService()
                    .createTaskQuery();
            taskQuery.taskId(taskId);
            Task task = taskQuery.singleResult();
            TaskEntityImpl taskEntity = (TaskEntityImpl) task;
            List<WorkFlowButton> buttonListFromModel = getButtonListFromModel(taskEntity.getProcessDefinitionId(), taskEntity.getTaskDefinitionKey());

        }
        //??????
        if (StringUtils.isNotBlank(taskId) && (buttonTypeEnum == ButtonTypeEnum.DONE)) {
            HistoricTaskInstance historicTaskInstance = processEngine.getHistoryService()
                    .createHistoricTaskInstanceQuery()
                    .taskId(taskId)
                    .singleResult();
            List<WorkFlowButton> buttonListFromModel = getButtonListFromModel(historicTaskInstance.getProcessDefinitionId(), historicTaskInstance.getTaskDefinitionKey());
        }

        //??????

        //????????????=??????????????????????????????
        LambdaQueryWrapper<WorkFlowButton> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.eq(WorkFlowButton::getButtonTypeEnum, buttonTypeEnum);
        List<WorkFlowButton> buttonList = workFlowButtonService.list(lambdaQueryWrapper);
        return buttonList;

    }

    private void updateProcessInsStatus(String processInstanceId, String status) {
        //1.??????????????????????????????????????????
        WorkFlowExtendHisprocinst workFlowExtendHisprocinst = workFlowExtendHisprocinstService.findExtendHisprocinstByProcessInstanceId(processInstanceId);
        if (workFlowExtendHisprocinst != null && !ProcessStatusEnum.ZZ.toString().equals(workFlowExtendHisprocinst.getProcessStatus())) {
            //?????????????????????
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
     * ???????????????
     *
     * @param ptask    ???????????????
     * @param assignee ?????????????????????
     * @return
     */
    private TaskEntity createSubTask(TaskEntity ptask, String ptaskId, String assignee) {
        TaskEntity task = null;
        if (ptask != null) {
            //1.???????????????
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
     * ??????????????????
     *
     * @param taskId       ??????id????????????????????????id
     * @param processInsId ????????????id
     * @param activityName ????????????
     * @param type         ????????????
     * @param message      ????????????
     */

    private void addComment(String taskId, String taskName, String activityId, String activityName, String processInsId, CommentTypeEnum type, String message, String action) {
        //????????????????????????
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
     * ????????????????????????
     *
     * @param processInstanceId ????????????id
     * @param type              ????????????
     */
    private void updateProinstStatus(String processInstanceId, String type) {
        //1.??????????????????????????????????????????
        WorkFlowExtendHisprocinst workFlowExtendHisprocinst = workFlowExtendHisprocinstService.findExtendHisprocinstByProcessInstanceId(processInstanceId);
        if (workFlowExtendHisprocinst != null) {
            //?????????????????????
            LambdaUpdateWrapper<WorkFlowExtendHisprocinst> lambdaUpdateWrapper = new LambdaUpdateWrapper();
            lambdaUpdateWrapper.set(WorkFlowExtendHisprocinst::getProcessStatus, type)
                    .eq(WorkFlowExtendHisprocinst::getProcessInstanceId, processInstanceId);
            workFlowExtendHisprocinstService.update(lambdaUpdateWrapper);
        }
    }

    /**
     * ????????????
     */
    private void moveExecutionsToSingleActivityId(List<String> executionIds, String activityId) {
        processEngine.getRuntimeService()
                .createChangeActivityStateBuilder()
                .moveExecutionsToSingleActivityId(executionIds, activityId)
                .changeState();
    }

    /**
     * ?????????????????????????????????
     *
     * @param disActivityId     ???????????????id
     * @param processInstanceId ????????????id
     */
    protected void deleteActivity(String disActivityId, String processInstanceId) {
        List<ActivityInstance> disActivities = flowableExtensionMapper
                .queryActivityInstance(disActivityId, processInstanceId, null);

        //????????????????????????????????????
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
     * ???????????????????????????????????????
     *
     * @param processDefId ????????????ID
     * @param taskDefKey   ????????????Key
     */
    private List<WorkFlowButton> getButtonListFromModel(String processDefId, String taskDefKey) {

        //??????bpmn????????????
        BpmnModel bpmnModel = processEngine.getRepositoryService()
                .getBpmnModel(processDefId);

        //????????????????????????
        FlowElement flowElement = bpmnModel.getFlowElement(taskDefKey);

        List<WorkFlowButton> buttons = new ArrayList<>();
        //?????????????????????????????????????????????????????????=????????????????????????
        if (ObjectUtils.isEmpty(flowElement) || !(flowElement instanceof UserTask || flowElement instanceof StartEvent)) {
            return buttons;
        }

        //????????????=????????????????????????
        Map<String, List<ExtensionElement>> map = flowElement.getExtensionElements();
        if (MapUtils.isEmpty(map)) {
            return buttons;
        }

        //??????bpmn????????????????????????
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
