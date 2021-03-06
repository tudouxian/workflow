package com.workflow.process.center.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.workflow.process.center.api.domain.WorkFlowUserDTO;
import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.common.enums.ProcessStatusEnum;
import com.workflow.process.center.common.enums.StartVariableEnum;
import com.workflow.process.center.domain.dto.*;
import com.workflow.process.center.domain.entity.WorkFlowExtendHisprocinst;
import com.workflow.process.center.domain.entity.WorkFlowHiComment;
import com.workflow.process.center.domain.entity.WorkFlowService;
import com.workflow.process.center.domain.vo.CommentInfoVO;
import com.workflow.process.center.domain.vo.CommentVO;
import com.workflow.process.center.exception.BizException;
import com.workflow.process.center.mapper.FlowableQueryMapper;
import com.workflow.process.center.service.*;
import com.workflow.process.center.utils.ElUtils;
import com.workflow.process.center.utils.SnowIdUtils;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.collections4.MapUtils;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;
import org.flowable.bpmn.model.BpmnModel;
import org.flowable.bpmn.model.StartEvent;
import org.flowable.bpmn.model.UserTask;
import org.flowable.engine.ProcessEngine;
import org.flowable.engine.history.HistoricProcessInstance;
import org.flowable.engine.migration.ProcessInstanceMigrationValidationResult;
import org.flowable.engine.repository.ProcessDefinition;
import org.flowable.engine.runtime.ProcessInstance;
import org.flowable.identitylink.api.IdentityLink;
import org.flowable.task.api.Task;
import org.flowable.task.api.history.HistoricTaskInstance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

import static com.workflow.process.center.common.enums.ProcessStatusEnum.getEnumMsgByType;
import static com.workflow.process.center.common.enums.entity.CommentTypeEnum.*;
import static com.workflow.process.center.utils.date.DateUtils.dateTime;
import static com.workflow.process.center.utils.date.DateUtils.getDuration;

/**
 * @Author: ?????????
 * @Date: 2021/6/27 22:23
 * @Description: ???????????????
 */
@Slf4j
@Service
@Transactional
public class FlowableWorkBenchServiceImpl implements FlowableWorkBenchService {

    @Autowired
    private AuthService authService;

    @Autowired
    private FlowableQueryMapper flowableQueryMapper;

    @Autowired
    private ProcessEngine processEngine;

    @Autowired
    private FlowableBpmnModelServiceImpl flowableBpmnModelService;

    @Autowired
    private WorkFlowUserService workFlowUserService;

    @Autowired
    private WorkFlowGroupService workFlowGroupService;

    @Autowired
    private SnowIdUtils snowIdUtils;

    @Autowired
    private WorkFlowExtendHisprocinstService workFlowExtendHisprocinstService;

    @Autowired
    private WorkFlowServiceService workFlowServiceService;

    @Autowired
    private WorkFlowHiCommentService workFlowHiCommentService;

    @Override
    public ResultBean<List<ProcessInstanceDTO>> findMyProcessinstances(ProcessInstanceQueryDTO processInstanceQueryDTO) {

        //????????????ID
        if (StringUtils.isNotEmpty(processInstanceQueryDTO.getServiceCode())) {
            LambdaQueryWrapper<WorkFlowService> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            lambdaQueryWrapper.eq(WorkFlowService::getServiceCode, processInstanceQueryDTO.getServiceCode());
            WorkFlowService  workFlowService = workFlowServiceService.getOne(lambdaQueryWrapper);
            processInstanceQueryDTO.setServiceId(workFlowService.getId().toString());
        }
        PageHelper.startPage(processInstanceQueryDTO.getPageIndex(), processInstanceQueryDTO.getPageSize(), true);
        List<ProcessInstanceDTO> processInstanceDTOS = flowableQueryMapper.findMyProcessinstances(processInstanceQueryDTO);
        //??????????????????-??????-??????????????????????????????
        processInstanceDTOS.forEach(_processInstanceVO -> {
            Date endTime = _processInstanceVO.getEndTime();
            if (endTime == null) {
                //????????????-?????????-???????????????
                List<Task> list = processEngine.getTaskService()
                        .createTaskQuery()
                        .processInstanceId(_processInstanceVO.getProcessInstanceId())
                        .list();

                //???????????????
                List<String> assigneesUserIds = new ArrayList<>();

                List<String> candidatesUserIds = new ArrayList<>();
                List<String> candidatesGroupKeys = new ArrayList<>();

                if (CollectionUtils.isNotEmpty(list)) {
                    list.forEach(task -> {
                        //???????????????
                        if (StringUtils.isNotBlank(task.getAssignee())) {
                            assigneesUserIds.add(task.getAssignee());
                        }
                        //?????????????????????
                        List<IdentityLink> identityLinksForTask = processEngine
                                .getTaskService()
                                .getIdentityLinksForTask(task.getId());
                        if (CollectionUtils.isNotEmpty(identityLinksForTask)) {
                            identityLinksForTask.forEach(identityLink -> {
                                String userId = identityLink.getUserId();
                                String roleKey = identityLink.getGroupId();
                                if (StringUtils.isNotBlank(userId)) {
                                    candidatesUserIds.add(userId);
                                }
                                if (StringUtils.isNotBlank(roleKey)) {
                                    candidatesGroupKeys.add(roleKey);
                                }
                            });

                        }

                    });

                    //1.???????????????????????????
                    if (CollectionUtils.isNotEmpty(assigneesUserIds)) {
                        List<WorkFlowUserDTO> workFlowUserDTOS = workFlowUserService.selectUserByUserIds(assigneesUserIds);
                        if (CollectionUtils.isNotEmpty(workFlowUserDTOS)) {
                            //2.???????????????????????????
                            List<AssigneeDTO> collectByUserIds = workFlowUserDTOS.stream()
                                    .map(_workFlowUserDTO -> {
                                        AssigneeDTO assigneeDTO = new AssigneeDTO();
                                        assigneeDTO.setName(_workFlowUserDTO.getNickName());
                                        assigneeDTO.setMobile(_workFlowUserDTO.getPhonenumber());
                                        assigneeDTO.setUserId(_workFlowUserDTO.getUserId());

                                        return assigneeDTO;
                                    }).collect(Collectors.toList());
                            _processInstanceVO.setCurrentAssignees(collectByUserIds);
                        }
                    }


                    //2.?????????????????????????????????
                    if (CollectionUtils.isNotEmpty(candidatesUserIds)) {
                        // 1.???????????????????????????
                        List<WorkFlowUserDTO> workFlowUserDTOSByIds = workFlowUserService.selectUserByUserIds(candidatesUserIds);
                        if (CollectionUtils.isNotEmpty(workFlowUserDTOSByIds)) {
                            List<AssigneeDTO> collect = workFlowUserDTOSByIds
                                    .stream()
                                    .map(_workFlowUserDTO -> {
                                        AssigneeDTO assigneeDTO = new AssigneeDTO();
                                        assigneeDTO.setName(_workFlowUserDTO.getNickName());
                                        assigneeDTO.setMobile(_workFlowUserDTO.getPhonenumber());
                                        assigneeDTO.setUserId(_workFlowUserDTO.getUserId());
                                        return assigneeDTO;
                                    }).collect(Collectors.toList());

                            _processInstanceVO.setCurrentCandidateUsers(collect);
                        }

                    }

                    //?????????
                    if (CollectionUtils.isNotEmpty(candidatesGroupKeys)) {
                        Map candidatesGroups = new HashMap();
                        candidatesGroupKeys
                                .stream()
                                .distinct()
                                .forEach(_candidatesGroupKey -> {
                                    //?????????????????????
                                    WorkFlowGroupUserDTO workFlowGroupUserDTO = workFlowGroupService.queryUsersByGroupKey(_candidatesGroupKey);
                                    if (workFlowGroupUserDTO != null) {
                                        List<AssigneeDTO> collect = workFlowGroupUserDTO.getWorkFlowUserDTOS()
                                                .stream()
                                                .map(_workFlowUserDTO -> {
                                                    AssigneeDTO assigneeDTO = new AssigneeDTO();
                                                    assigneeDTO.setName(_workFlowUserDTO.getNickName());
                                                    assigneeDTO.setMobile(_workFlowUserDTO.getPhonenumber());
                                                    assigneeDTO.setUserId(_workFlowUserDTO.getUserId());
                                                    return assigneeDTO;
                                                }).collect(Collectors.toList());
                                        candidatesGroups.put(workFlowGroupUserDTO.getGroupName(), collect);
                                    }
                                    _processInstanceVO.setCurrentCandidateGroups(candidatesGroups);

                                });
                    }

                }
                endTime = new Date();

            }

            //????????????
            Date startTime = _processInstanceVO.getStartTime();
            _processInstanceVO.setTotalTime(getDuration(endTime.getTime() - startTime.getTime()));
            //??????????????????
            _processInstanceVO.setProcessStatusName(getEnumMsgByType(_processInstanceVO.getProcessStatus()));

        });

        PageInfo<ProcessInstanceDTO> pageInfo = new PageInfo<>(processInstanceDTOS);
        return ResultBean.ofSuccess(processInstanceDTOS, pageInfo.getTotal(), pageInfo.getPageNum(), pageInfo.getPageSize());
    }

    @Override
    public ResultBean<List<WorkFlowUserDTO>> findToDoUsers() {

        List<String> userIds = flowableQueryMapper.findToDoUsers();

        List<WorkFlowUserDTO> workFlowUserDTOS = workFlowUserService.selectUserByUserIds(userIds);

        return ResultBean.ofSuccess(workFlowUserDTOS);
    }

    private List<TaskDTO> fillTaskVOInfo(List<TaskDTO> taskDTOS) {
        //?????? ???????????????????????????
        taskDTOS.forEach(_taskVO -> {
            //??????-????????????
            Date startTime = _taskVO.getTaskCreateTime();
            Date endTime = _taskVO.getProcessEndTime() != null ? _taskVO.getProcessEndTime() : new Date();
            _taskVO.setTaskStayHour(getDuration(endTime.getTime() - startTime.getTime()));
            //??????-????????????
            _taskVO.setTotalTime(getDuration(endTime.getTime() - _taskVO.getProcessStartTime().getTime()));
            //??????-????????????
            _taskVO.setProcessStatusName(getEnumMsgByType(_taskVO.getProcessStatus()));

            //??????-??????????????????
            if (StringUtils.isNotBlank(_taskVO.getAssignee())) {
                WorkFlowUserDTO workFlowUserDTOResultBean = workFlowUserService.selectUserByUserId(_taskVO.getAssignee());
                if (workFlowUserDTOResultBean != null) {
                    _taskVO.setAssigneeName(workFlowUserDTOResultBean.getNickName());
                }
            }

            //???????????????????????????
            if (StringUtils.isNotBlank(_taskVO.getStartUserId())) {
                WorkFlowUserDTO workFlowUserDTOResultBean = workFlowUserService.selectUserByUserId(_taskVO.getStartUserId());
                if (workFlowUserDTOResultBean != null) {
                    _taskVO.setStartUserName(workFlowUserDTOResultBean.getNickName());
                }
            }

        });

        return taskDTOS;
    }

    @Override
    public ResultBean<List<TaskDTO>> findMyToDoTasks(TaskQueryDTO taskQueryDTO) {
        if (StringUtils.isNotEmpty(taskQueryDTO.getServiceCode())) {
            LambdaQueryWrapper<WorkFlowService> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            lambdaQueryWrapper.eq(WorkFlowService::getServiceCode, taskQueryDTO.getServiceCode());
            WorkFlowService  workFlowService = workFlowServiceService.getOne(lambdaQueryWrapper);
            taskQueryDTO.setServiceId(workFlowService.getId().toString());
        }

        PageHelper.startPage(taskQueryDTO.getPageIndex(), taskQueryDTO.getPageSize(), true);
        List<TaskDTO> taskDTOS = flowableQueryMapper.findMyToDoTasks(taskQueryDTO);
        fillTaskVOInfo(taskDTOS);
        PageInfo<TaskDTO> pageInfo = new PageInfo<>(taskDTOS);
        return ResultBean.ofSuccess(taskDTOS, pageInfo.getTotal(), pageInfo.getPageNum(), pageInfo.getPageSize());

    }

    @Override
    public ResultBean<List<TaskDTO>> findAllDueDateTasks(TaskQueryDTO taskQueryDTO) {
        PageHelper.startPage(taskQueryDTO.getPageIndex(), taskQueryDTO.getPageSize(), true);
        List<TaskDTO> taskDTOS = flowableQueryMapper.findAllDueDateTasks(taskQueryDTO);
        fillTaskVOInfo(taskDTOS);
        PageInfo<TaskDTO> pageInfo = new PageInfo<>(taskDTOS);
        return ResultBean.ofSuccess(taskDTOS, pageInfo.getTotal(), pageInfo.getPageNum(), pageInfo.getPageSize());

    }

    //??????????????????????????????{assignee??????????????????candidate??????????????????owner???????????????????????????starter??????????????? ???participant???????????????}
    @Override
    public ResultBean<List<TaskDTO>> findMyToDoGroupTasks(TaskQueryDTO taskQueryDTO) {
        if (StringUtils.isNotEmpty(taskQueryDTO.getServiceCode())) {
            LambdaQueryWrapper<WorkFlowService> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            lambdaQueryWrapper.eq(WorkFlowService::getServiceCode, taskQueryDTO.getServiceCode());
            WorkFlowService  workFlowService = workFlowServiceService.getOne(lambdaQueryWrapper);
            taskQueryDTO.setServiceId(workFlowService.getId().toString());
        }

        PageHelper.startPage(taskQueryDTO.getPageIndex(), taskQueryDTO.getPageSize(), true);
        //?????????????????????-????????????
        //taskQueryDTO.setAssignee(authService.getLoginUser().getUserid().toString());


        List<TaskDTO> taskDTOS = flowableQueryMapper.findMyToDoGroupTasks(taskQueryDTO);
        fillTaskVOInfo(taskDTOS);
        PageInfo<TaskDTO> pageInfo = new PageInfo<>(taskDTOS);
        return ResultBean.ofSuccess(taskDTOS, pageInfo.getTotal(), pageInfo.getPageNum(), pageInfo.getPageSize());

    }

    @Override
    public ResultBean<List<WorkFlowUserDTO>> findDoneUsers() {
        List<String> userIds = flowableQueryMapper.findDoneUsers();

        List<WorkFlowUserDTO> workFlowUserDTOS = workFlowUserService.selectUserByUserIds(userIds);

        return ResultBean.ofSuccess(workFlowUserDTOS);
    }

    @Override
    public ResultBean<List<TaskDTO>> findMyDoneTasks(TaskQueryDTO taskQueryDTO) {
        if (StringUtils.isNotEmpty(taskQueryDTO.getServiceCode())) {
            LambdaQueryWrapper<WorkFlowService> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            lambdaQueryWrapper.eq(WorkFlowService::getServiceCode, taskQueryDTO.getServiceCode());
            WorkFlowService  workFlowService = workFlowServiceService.getOne(lambdaQueryWrapper);
            taskQueryDTO.setServiceId(workFlowService.getId().toString());
        }

        PageHelper.startPage(taskQueryDTO.getPageIndex(), taskQueryDTO.getPageSize(), true);
        List<TaskDTO> taskDTOS = flowableQueryMapper.findMyDoneTasks(taskQueryDTO);
        fillTaskVOInfo(taskDTOS);
        PageInfo<TaskDTO> pageInfo = new PageInfo<>(taskDTOS);
        return ResultBean.ofSuccess(taskDTOS, pageInfo.getTotal(), pageInfo.getPageNum(), pageInfo.getPageSize());

    }

    //????????????????????????????????????
    @Override
    public List<CommentInfoVO> getCommentInfosByProcessInstanceId(String processInstanceId) {

        HistoricProcessInstance historicProcessInstance = processEngine.getHistoryService()
                .createHistoricProcessInstanceQuery()
                .processInstanceId(processInstanceId)
                .singleResult();
        if (ObjectUtils.isEmpty(historicProcessInstance)) {
            throw new BizException("???????????????????????????");
        }

        //??????????????????
        WorkFlowHiComment workFlowHiComment = new WorkFlowHiComment();
        workFlowHiComment.setProcessInsId(processInstanceId);
        QueryWrapper<WorkFlowHiComment> hiCommentQueryWrapper = new QueryWrapper<>(workFlowHiComment);
        List<WorkFlowHiComment> list = workFlowHiCommentService.list(hiCommentQueryWrapper);

        if (CollectionUtils.isNotEmpty(list)) {
            List<CommentInfoVO> commentInfoVOS = list.stream()
                    .map(_workFlowHiComment -> {
                        CommentInfoVO commentInfoVO = null;
                        //??????  ??????  ??????
                        if (FQLC == _workFlowHiComment.getCommentTypeEnum()
                                || CX == _workFlowHiComment.getCommentTypeEnum()
                                || QZJS == _workFlowHiComment.getCommentTypeEnum()
                                || LCZZ == _workFlowHiComment.getCommentTypeEnum()
                                || BJ == _workFlowHiComment.getCommentTypeEnum()) {
                            commentInfoVO = new CommentInfoVO();
                            commentInfoVO.setTaskName(_workFlowHiComment.getCommentTypeEnum().getName());
                            commentInfoVO.setCreateTime(_workFlowHiComment.getTime());
                            commentInfoVO.setUserId(_workFlowHiComment.getUserId());

                            if (StringUtils.isNotBlank(commentInfoVO.getUserId())) {
                                WorkFlowUserDTO workFlowUserDTO = workFlowUserService.selectUserByUserId(commentInfoVO.getUserId());
                                if (workFlowUserDTO != null) {
                                    commentInfoVO.setUserName(workFlowUserDTO.getNickName());
                                    commentInfoVO.setDeptName(workFlowUserDTO.getDeptName());
                                }
                            }
                            return commentInfoVO;
                        }

                        if (StringUtils.isNotBlank(_workFlowHiComment.getTaskId())) {

                            HistoricTaskInstance historicTaskInstance = processEngine.getHistoryService()
                                    .createHistoricTaskInstanceQuery()
                                    .taskId(_workFlowHiComment.getTaskId())
                                    .singleResult();

                            if (historicTaskInstance != null) {

                                //????????????
                                CommentVO commentVO = new CommentVO();
                                commentVO.setUserId(_workFlowHiComment.getUserId());
                                //??????????????????
                                WorkFlowUserDTO workFlowUserDTOResultBean = workFlowUserService.selectUserByUserId(_workFlowHiComment.getUserId());
                                if (workFlowUserDTOResultBean != null) {
                                    commentVO.setUserName(workFlowUserDTOResultBean.getNickName());
                                }
                                commentVO.setType(_workFlowHiComment.getCommentTypeEnum());
                                commentVO.setTime(_workFlowHiComment.getTime());
                                commentVO.setAction(_workFlowHiComment.getAction());
                                commentVO.setFullMessage(_workFlowHiComment.getMessage());

                                //??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????ID?????????ID????????????ID || ????????????
                                commentInfoVO = new CommentInfoVO(historicTaskInstance, commentVO);

                                //???????????????????????????
                                if (StringUtils.isNotBlank(commentInfoVO.getUserId())) {
                                    WorkFlowUserDTO workFlowUserDTO = workFlowUserService.selectUserByUserId(commentInfoVO.getUserId());
                                    if (workFlowUserDTO != null) {
                                        commentInfoVO.setUserName(workFlowUserDTO.getNickName());
                                        commentInfoVO.setDeptName(workFlowUserDTO.getDeptName());
                                    }
                                }
                            } else {
                                //??????=?????????=?????????????????????????????????
                                commentInfoVO = new CommentInfoVO();
                                commentInfoVO.setTaskName(_workFlowHiComment.getTaskName());
                                commentInfoVO.setCreateTime(_workFlowHiComment.getTime());
                                commentInfoVO.setUserId(_workFlowHiComment.getUserId());
                                commentInfoVO.setUserName(_workFlowHiComment.getUserName());
                                //????????????
                                CommentVO commentVO = new CommentVO();
                                commentVO.setUserId(_workFlowHiComment.getUserId());
                                //??????????????????
                                WorkFlowUserDTO workFlowUserDTOResultBean = workFlowUserService.selectUserByUserId(_workFlowHiComment.getUserId());
                                if (workFlowUserDTOResultBean != null) {
                                    commentVO.setUserName(workFlowUserDTOResultBean.getNickName());
                                }
                                commentVO.setType(_workFlowHiComment.getCommentTypeEnum());
                                commentVO.setTime(_workFlowHiComment.getTime());
                                commentVO.setFullMessage(_workFlowHiComment.getMessage());
                                commentVO.setAction(_workFlowHiComment.getAction());
                                List<CommentVO> collect = Arrays.asList(commentVO);
                                commentInfoVO.setComments(collect);

                            }
                        }
                        return commentInfoVO;
                    }).sorted(Comparator.comparing(CommentInfoVO::getCreateTime))
                    .collect(Collectors.toList());

            return commentInfoVOS;
        }
        return null;
    }

    @Override
    public ProcessInstance startProcessInstanceByKey(StartProcessInstanceByKeyDTO params) {

        ProcessDefinition processDefinition = processEngine.getRepositoryService()
                .createProcessDefinitionQuery()
                .processDefinitionKey(params.getProcessDefinitionKey())
                .latestVersion()
                .singleResult();
        if (processDefinition != null && processDefinition.isSuspended()) {
            throw new BizException("?????????????????????,????????????????????????!");
        }

        // getStartVariables(params);
        checkProcessInstance(params);

        processEngine.getIdentityService().setAuthenticatedUserId(params.getCurrentUserId());
        ProcessInstance processInstance = processEngine.getRuntimeService()
                .createProcessInstanceBuilder()
                .processDefinitionKey(params.getProcessDefinitionKey().trim())
                .name(params.getFormName().trim())
                .businessKey(params.getBusinessKey().trim())
                .variables(params.getVariables())
                .tenantId(params.getTenantId().trim())
                .start();
        BpmnModel bpmnModel = flowableBpmnModelService.getBpmnModelByProcessDefId(processInstance.getProcessDefinitionId());
        StartEvent start = flowableBpmnModelService.findStartFlowElement(bpmnModel.getMainProcess());

        WorkFlowHiComment workFlowHiComment = new WorkFlowHiComment();
        workFlowHiComment.setCommentTypeEnum(FQLC);
        workFlowHiComment.setProcessInsId(processInstance.getProcessInstanceId());
        workFlowHiComment.setActivityId(start.getId());
        workFlowHiComment.setActivityName(start.getName());
        workFlowHiComment.setTime(new Date());
        workFlowHiComment.setUserId(authService.getLoginUser().getUserid().toString());
        workFlowHiComment.setUserName(authService.getLoginUser().getNickName());
        workFlowHiCommentService.save(workFlowHiComment);

        processEngine.getIdentityService()
                .setAuthenticatedUserId(null);
        return processInstance;
    }

    @Override
    public ProcessInstance startProcessService(StartProcessServiceDTO startProcessServiceDTO) {

        //????????????
        WorkFlowService workFlowService = null;
        if (StringUtils.isNotEmpty(startProcessServiceDTO.getServiceCode())) {
            LambdaQueryWrapper<WorkFlowService> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            lambdaQueryWrapper.eq(WorkFlowService::getServiceCode, startProcessServiceDTO.getServiceCode());
            workFlowService = workFlowServiceService.getOne(lambdaQueryWrapper);

        } else {
            workFlowService = workFlowServiceService.getById(startProcessServiceDTO.getServiceID());
        }


        if (workFlowService == null) {
            throw new BizException("??????????????????????????????");
        }

        ProcessDefinition processDefinition = processEngine.getRepositoryService()
                .createProcessDefinitionQuery()
                .processDefinitionId(workFlowService.getProcessDefId())
                .singleResult();

        if (Objects.nonNull(processDefinition) && processDefinition.isSuspended()) {
            throw new BizException("??????????????????,??????????????????");
        }


        //???????????? TODO

        //???????????????????????????
        checkProcessCondition(workFlowService.getProcessDefId(), startProcessServiceDTO.getVariables());

        // ?????????????????????Id????????????-??????ThreadLoacal???
        processEngine.getIdentityService()
                .setAuthenticatedUserId(startProcessServiceDTO.getUserId());
        //??????????????????-flowable=??? ????????????key????????????????????????ID
        /* ???Builder ??????????????????????????? ??? ?????? ??? Id ??????????????? ???????????????????????????!!????????? ??????????????? ??????????????? */
        ProcessInstance processInstance = processEngine
                .getRuntimeService()
                .createProcessInstanceBuilder()
                .tenantId(workFlowService.getTenantId())
                .businessKey(startProcessServiceDTO.getBusinessKey())
                .name(processDefinition.getName() + dateTime(new Date()))
                .processDefinitionId(workFlowService.getProcessDefId())
                .variables(startProcessServiceDTO.getVariables())
                .start();

        // ?????????????????????????????????????????????????????????-????????????
        /*Task task = processEngine.getTaskService()
                .createTaskQuery()
                .processInstanceId(processInstance.getProcessInstanceId())
                .singleResult();
        if (Objects.nonNull(task) && task.getName().equals("?????????")) {
            WorkFlowHiComment workFlowHiComment = new WorkFlowHiComment();
            workFlowHiComment.setCommentTypeEnum(CommentTypeEnum.XTZX);
            workFlowHiComment.setProcessInsId(task.getProcessInstanceId());
            workFlowHiComment.setTaskId(task.getId());
            workFlowHiComment.setTaskName(task.getName());
            workFlowHiComment.setActivityId(task.getTaskDefinitionKey());
            workFlowHiComment.setActivityName(task.getName());
            workFlowHiComment.setTime(new Date());
            workFlowHiComment.setUserId(loginInfoService.getLoginUser().getUserid().toString());
            workFlowHiComment.setUserName(loginInfoService.getLoginUser().getNickName());
            workFlowHiCommentService.save(workFlowHiComment);
            //?????????????????????
            processEngine.getTaskService()
                    .setAssignee(task.getId(), loginInfoService.getLoginUser().getUserid().toString());
            processEngine.getTaskService()
                    .complete(task.getId(), startProcessServiceDTO.getVariables());
        }*/
        //??????ThreadLoacal
        processEngine.getIdentityService()
                .setAuthenticatedUserId(null);

        //????????????????????????
        BpmnModel bpmnModel = flowableBpmnModelService.getBpmnModelByProcessDefId(processInstance.getProcessDefinitionId());
        StartEvent start = flowableBpmnModelService.findStartFlowElement(bpmnModel.getMainProcess());
        WorkFlowHiComment startComment = new WorkFlowHiComment();
        startComment.setCommentTypeEnum(FQLC);
        startComment.setProcessInsId(processInstance.getProcessInstanceId());
        startComment.setActivityId(start.getId());
        startComment.setActivityName(start.getName());
        startComment.setTime(new Date());
        startComment.setUserId(startProcessServiceDTO.getUserId());
        startComment.setUserName(startProcessServiceDTO.getUserName());
        workFlowHiCommentService.save(startComment);

        //??????????????????????????????
        //???????????????????????????-?????????????????????
        //??????????????????????????????????????????????????????
        WorkFlowExtendHisprocinst workFlowExtendHisprocinst = workFlowExtendHisprocinstService.findExtendHisprocinstByProcessInstanceId(processInstance.getProcessInstanceId());
        if (workFlowExtendHisprocinst == null || (workFlowExtendHisprocinst != null && !ProcessStatusEnum.BJ.toString().equals(workFlowExtendHisprocinst.getProcessStatus()))) {
            WorkFlowExtendHisprocinst extendHisprocinst = new WorkFlowExtendHisprocinst();
            extendHisprocinst.setProcessInstanceId(processInstance.getProcessInstanceId());
            extendHisprocinst.setBusinessKey(processInstance.getBusinessKey());
            extendHisprocinst.setServiceID(startProcessServiceDTO.getServiceID());
            extendHisprocinst.setModelKey(processInstance.getProcessDefinitionKey());
            extendHisprocinst.setProcessDefinitionId(processInstance.getProcessDefinitionId());
            extendHisprocinst.setTenantId(processInstance.getTenantId());
            extendHisprocinst.setProcessName(processDefinition.getName() + "???" + dateTime(processInstance.getStartTime()) + "???");
            extendHisprocinst.setProcessStatus(ProcessStatusEnum.SPZ.toString());
            workFlowExtendHisprocinstService.saveOrUpdate(extendHisprocinst);

        }

        return processInstance;
    }

    @Override
    public boolean migrationValidationProcessService(MigrationValidationProcessServiceDTO mVProcessServiceDTO) {

        ProcessInstanceMigrationValidationResult validationResult = processEngine.getProcessMigrationService()
                .createProcessInstanceMigrationBuilder()
                .migrateToProcessDefinition(mVProcessServiceDTO.getProcDefId())
                .validateMigration(mVProcessServiceDTO.getProcInsId());
        boolean isMigrationValid = validationResult.isMigrationValid();
        return isMigrationValid;
    }


    /**
     * ?????????????????????????????????
     *
     * @param processDefId ??????
     * @return
     */
    private void checkProcessCondition(String processDefId, Map<String, Object> variables) {
        List<UserTask> datas = flowableBpmnModelService.findUserTasksByProcessDefId(processDefId);

        //?????????????????????${assignee}?????????
        List<UserTask> userTasks = new ArrayList<>();
        if (CollectionUtils.isNotEmpty(datas)) {
            userTasks = datas.stream().filter(userTask ->
                    StringUtils.indexOf(userTask.getAssignee(), "${") != -1)
                    .collect(Collectors.toList());
        }
        List<String> elexps = userTasks.stream().map(userTask -> userTask.getAssignee())
                .collect(Collectors.toList());

        Map<String, String> keys = new HashMap<>();
        if (MapUtils.isNotEmpty(variables)) {
            variables.forEach((k, v) -> {
                if (v instanceof String) {
                    keys.put(k, k);
                } else if (v instanceof ObjectNode) {
                    ObjectNode node = (ObjectNode) v;
                    Iterator<String> nodeKeys = node.fieldNames();
                    while (nodeKeys.hasNext()) {
                        String nodeKey = nodeKeys.next();
                        //??????
                        String enumMsg = StartVariableEnum.getEnumMsgByCode(nodeKey);
                        String tempNodeKey = k + "." + nodeKey;
                        keys.put(tempNodeKey, enumMsg);
                    }
                }
            });
        }

        for (String assigneeEl : elexps) {
            if (StringUtils.isNotBlank(assigneeEl)) {
                String assignee = ElUtils.getOriginalValue(assigneeEl);
                if (!keys.containsKey(assignee)) {
                    String code = ElUtils.getSpotValue(assignee);
                    String enumMsg = StartVariableEnum.getEnumMsgByCode(code);
                    if (StringUtils.isNotBlank(enumMsg)) {
                        throw new BizException(enumMsg + "??????????????????????????????????????????!");
                    }
                    break;
                }
            }
        }
    }

    /**
     * ?????????????????????????????????
     *
     * @param params ??????
     * @return
     */
    private void checkProcessInstance(StartProcessInstanceByKeyDTO params) {
        ProcessDefinition lastProcessDefinition = processEngine.getRepositoryService()
                .createProcessDefinitionQuery()
                .latestVersion()
                .processDefinitionKey(StringUtils.trim(params.getProcessDefinitionKey()))
                .singleResult();
        if (lastProcessDefinition == null) {

            throw new BizException("???" + params.getProcessDefinitionKey() + "???????????????????????????");
        }
        checkProcessCondition(lastProcessDefinition.getId(), params.getVariables());
    }

  /*  private Map<String, Object> getStartVariables(StartProcessInstanceByKeyDTO params) {
        Map<String, Object> variables = null;
        if (params.getVariables() == null) {
            variables = new HashMap<>();
            params.setVariables(variables);
        } else {
            Map<String, Object> formMap = params.getVariables();
            if (!formMap.containsKey(StartVariableEnum.FORM.getCode())) {
                ObjectNode formNode = objectMapper.createObjectNode();
                Map<String, Object> listMap = new HashMap<>();
                if (MapUtils.isNotEmpty(formMap)) {
                    formMap.forEach((k, v) -> {
                        if (v instanceof java.util.List) {
                            String key = StartVariableEnum.FORM.getCode() + "_" + k;
                            listMap.put(key, v);
                        } else if (v instanceof java.lang.String) {
                            formNode.put(k, String.valueOf(v));
                        } else if (v instanceof Integer) {
                            formNode.put(k, Integer.valueOf(v + ""));
                        } else if (v instanceof Float) {
                            formNode.put(k, Float.valueOf(v + ""));
                        } else if (v instanceof Double) {
                            formNode.put(k, Double.valueOf(v + ""));
                        } else if (v instanceof Long) {
                            formNode.put(k, Long.valueOf(v + ""));
                        } else if (v instanceof BigDecimal) {
                            formNode.put(k, new BigDecimal(v + ""));
                        } else {
                            String s = String.valueOf(v);
                            if (s.startsWith("0")) {
                                formNode.put(k, s);
                            } else {
                                formNode.putPOJO(k, v);
                            }
                        }
                    });
                }
                formMap = new HashMap<>();
                params.setVariables(formMap);
                params.getVariables().put(StartVariableEnum.FORM.getCode(), formNode);
                if (MapUtils.isNotEmpty(listMap)) {
                    listMap.forEach((k, v) -> params.getVariables().put(k, v));
                }
            }

            if (StringUtils.isBlank(params.getDeptId())) {
                params.setDeptId(params.getDeptId());
            }
            variables = params.getVariables();
        }
        return variables;
    }*/
}
