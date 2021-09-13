package com.workflow.process.center.controller;

import com.workflow.process.center.annotation.DistributedLock;
import com.workflow.process.center.api.domain.WorkFlowUserDTO;
import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.domain.dto.*;
import com.workflow.process.center.domain.vo.CommentInfoVO;
import com.workflow.process.center.service.AuthService;
import com.workflow.process.center.service.FlowableWorkBenchService;
import com.workflow.process.center.utils.SnowIdUtils;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.flowable.engine.runtime.ProcessInstance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

/**
 * @Author: 土豆仙
 * @Date: 2021/6/27 19:37
 * @Description: flowable工作台
 */
@Api(tags = "流程中心工作台(管理员视角)")
@RestController
@RequestMapping("/flowable/management")
public class FlowableWorkManagementController {

    @Autowired
    private FlowableWorkBenchService flowableWorkBenchService;

    @Autowired
    private AuthService authService;

    @Autowired
    private SnowIdUtils snowIdUtils;


    @ApiOperation(value = "查询所有发起的流程", notes = "查询所有发起的流程列表")
    @ApiImplicitParam(name = "processInstanceQueryDTO", value = "分页查询参数", required = true, dataType = "ProcessInstanceQueryDTO")
    @PostMapping("/findAllProcessinstances")
    public ResultBean<List<ProcessInstanceDTO>> findMyProcessinstances(@RequestBody @Valid ProcessInstanceQueryDTO processInstanceQueryDTO) {

        ResultBean<List<ProcessInstanceDTO>> resultBean = flowableWorkBenchService.findMyProcessinstances(processInstanceQueryDTO);
        return resultBean;
    }

    @ApiOperation(value = "查询待办人列表-枚举", notes = "查询待办人列表-枚举")
    @GetMapping("/findToDoUsers")
    public ResultBean<List<WorkFlowUserDTO>> findToDoUsers() {
        ResultBean<List<WorkFlowUserDTO>> resultBean = flowableWorkBenchService.findToDoUsers();
        return resultBean;
    }

    @ApiOperation(value = "查询所有待办任务-个人任务", notes = "查询所有待办任务-个人任务列表")
    @ApiImplicitParam(name = "taskQueryDTO", value = "分页查询参数", required = true, dataType = "TaskQueryDTO")
    @PostMapping("/findAllToDoTasks")
    public ResultBean<List<TaskDTO>> findAllToDoTasks(@RequestBody TaskQueryDTO taskQueryDTO) {

        ResultBean<List<TaskDTO>> resultBean = flowableWorkBenchService.findMyToDoTasks(taskQueryDTO);

        return resultBean;
    }

    @ApiOperation(value = "查询所有待办任务-组任务", notes = "查询所有待办任务-组任务列表")
    @ApiImplicitParam(name = "taskQueryDTO", value = "分页查询参数", required = true, dataType = "TaskQueryDTO")
    @PostMapping("/findAllToDoGroupTasks")
    public ResultBean<List<TaskDTO>> findAllToDoGroupTasks(@RequestBody TaskQueryDTO taskQueryDTO) {
        ResultBean<List<TaskDTO>> resultBean = flowableWorkBenchService.findMyToDoGroupTasks(taskQueryDTO);

        return resultBean;
    }

    @ApiOperation(value = "查询已办人列表-枚举", notes = "查询已办人列表-枚举")
    @GetMapping("/findDoneUsers")
    public ResultBean<List<WorkFlowUserDTO>> findDoneUsers() {
        ResultBean<List<WorkFlowUserDTO>> resultBean = flowableWorkBenchService.findDoneUsers();
        return resultBean;
    }

    @ApiOperation(value = "查询所有已办任务", notes = "查询所有已办任务列表")
    @ApiImplicitParam(name = "taskQueryDTO", value = "分页查询参数", required = true, dataType = "TaskQueryDTO")
    @PostMapping("/findAllDoneTasks")
    public ResultBean<List<TaskDTO>> findMyDoneTasks(@RequestBody TaskQueryDTO taskQueryDTO) {

        ResultBean<List<TaskDTO>> resultBean = flowableWorkBenchService.findMyDoneTasks(taskQueryDTO);
        return resultBean;
    }

    @ApiOperation(value = "查询所有限时任务", notes = "查询所有限时任务列表")
    @ApiImplicitParam(name = "taskQueryDTO", value = "分页查询参数", required = true, dataType = "TaskQueryDTO")
    @PostMapping("/findAllDueDateTasks")
    public ResultBean<List<TaskDTO>> findAllDueDateTasks(@RequestBody TaskQueryDTO taskQueryDTO) {

        ResultBean<List<TaskDTO>> resultBean = flowableWorkBenchService.findAllDueDateTasks(taskQueryDTO);
        return resultBean;
    }


    @ApiOperation(value = "查询当前流程的审批记录", notes = "查询当前流程的审批记录列表")
    @ApiImplicitParam(name = "processInstanceId", value = "流程实例id", required = true, dataType = "String")
    @GetMapping("/getCommentInfosByProcessInstanceId")
    public ResultBean<List<CommentInfoVO>> getCommentInfosByProcessInstanceId(@RequestParam(value = "processInstanceId", required = true) String processInstanceId) {
        List<CommentInfoVO> commentInfoList = flowableWorkBenchService.getCommentInfosByProcessInstanceId(processInstanceId);
        return ResultBean.ofSuccess(commentInfoList);
    }


    @DistributedLock(releaseTime = 2)
    @ApiOperation(value = "根据流程定义id启动流程实例", notes = "启动流程")
    @ApiImplicitParam(name = "startProcessServiceDTO", value = "启动流程", required = true, dataType = "StartProcessServiceDTO")
    @PostMapping(value = "/startProcessService", produces = "application/json")
    public ResultBean startProcessService(@RequestBody @Valid StartProcessServiceDTO startProcessServiceDTO) {

        startProcessServiceDTO.setUserId(authService.getLoginUser().getUserid().toString());
        startProcessServiceDTO.setUserName(authService.getLoginUser().getNickName());
        startProcessServiceDTO.setBusinessKey(String.valueOf(snowIdUtils.nextId()));
        ProcessInstance processInstance = flowableWorkBenchService.startProcessService(startProcessServiceDTO);
        return ResultBean.ofSuccess(processInstance.getProcessDefinitionId());
    }

    @ApiOperation(value = "判断服务运行实例是否可以升级到新的流程定义", notes = "升级服务")
    @ApiImplicitParam(name = "migrationValidationProcessServiceDTO", value = "启动流程", required = true, dataType = "MigrationValidationProcessServiceDTO")
    @PostMapping(value = "/migrationValidationProcessService", produces = "application/json")
    public ResultBean migrationValidationProcessService(@RequestBody @Valid MigrationValidationProcessServiceDTO migrationValidationProcessServiceDTO) {
        boolean isMigrationValid = flowableWorkBenchService.migrationValidationProcessService(migrationValidationProcessServiceDTO);
        return ResultBean.ofSuccess(isMigrationValid);
    }

}
