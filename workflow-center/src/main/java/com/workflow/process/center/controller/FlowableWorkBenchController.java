package com.workflow.process.center.controller;

import com.workflow.process.center.annotation.DistributedLock;
import com.workflow.process.center.api.domain.WorkFlowUserDTO;
import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.domain.dto.*;
import com.workflow.process.center.domain.vo.CommentInfoVO;
import com.workflow.process.center.service.AuthService;
import com.workflow.process.center.service.FlowableWorkBenchService;
import com.workflow.process.center.service.WorkFlowGroupService;
import com.workflow.process.center.utils.SnowIdUtils;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.flowable.engine.runtime.ProcessInstance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.Set;

/**
 * @Author: 土豆仙
 * @Date: 2021/6/27 19:37
 * @Description: flowable工作台
 */
@Api(tags = "流程中心工作台")
@RestController
@RequestMapping("/flowable/workBench")
public class FlowableWorkBenchController {

    @Autowired
    private FlowableWorkBenchService flowableWorkBenchService;

    @Autowired
    private AuthService authService;

    @Autowired
    private SnowIdUtils snowIdUtils;

    @Autowired
    private WorkFlowGroupService workFlowGroupService;

    /**
     * 通过对接的应用(租户)的标识和秘钥获取token
     * 对接的应用的标识和秘钥
     *
     * @return
     */
    //TODO 待设计租户交互方式
    @ApiOperation(value = "查询我发起的流程", notes = "查询我发起的流程列表")
    @ApiImplicitParam(name = "processInstanceQueryDTO", value = "分页查询参数", required = true, dataType = "ProcessInstanceQueryDTO")
    @PostMapping("/findMyProcessinstances")
    public ResultBean<List<ProcessInstanceDTO>> findMyProcessinstances(@RequestBody @Valid ProcessInstanceQueryDTO processInstanceQueryDTO) {
        //注入当前用户=》查询当前登录用户
        processInstanceQueryDTO.setUserId(authService.getLoginUser().getUserid().toString());

        ResultBean<List<ProcessInstanceDTO>> resultBean = flowableWorkBenchService.findMyProcessinstances(processInstanceQueryDTO);
        return resultBean;
    }

    @ApiOperation(value = "查询待办人列表-枚举", notes = "查询待办人列表-枚举")
    @GetMapping("/findToDoUsers")
    public ResultBean<List<WorkFlowUserDTO>> findToDoUsers() {
        ResultBean<List<WorkFlowUserDTO>> resultBean = flowableWorkBenchService.findToDoUsers();
        return resultBean;
    }

    @ApiOperation(value = "查询我的待办任务-个人任务", notes = "查询我的待办任务-个人任务列表")
    @ApiImplicitParam(name = "taskQueryDTO", value = "分页查询参数", required = true, dataType = "TaskQueryDTO")
    @PostMapping("/findMyToDoTasks")
    public ResultBean<List<TaskDTO>> findMyToDoTasks(@RequestBody TaskQueryDTO taskQueryDTO) {

        //默认当前登录用户
        taskQueryDTO.setAssignee(authService.getLoginUser().getUserid().toString());

        ResultBean<List<TaskDTO>> resultBean = flowableWorkBenchService.findMyToDoTasks(taskQueryDTO);

        return resultBean;
    }

    @ApiOperation(value = "查询我的待办任务-组任务", notes = "查询我的待办任务-组任务列表")
    @ApiImplicitParam(name = "taskQueryDTO", value = "分页查询参数", required = true, dataType = "TaskQueryDTO")
    @PostMapping("/findMyToDoGroupTasks")
    public ResultBean<List<TaskDTO>> findMyToDoGroupTasks(@RequestBody TaskQueryDTO taskQueryDTO) {
        //默认当前登录用户
        taskQueryDTO.setAssignee(authService.getLoginUser().getUserid().toString());
        //区域  a
        Set<String> areaKeys = authService.getLoginUser().getAreaKeys();
        //部门  a_d
        Set<String> deptKeys = authService.getLoginUser().getDeptKeys();
        //角色  a_d_r
        Set<String> roles = authService.getLoginUser().getRoles();

        Set<String> areaDeptRoleGroups = workFlowGroupService.generatorGroupKeys(areaKeys, deptKeys, roles);
        taskQueryDTO.setGroups(areaDeptRoleGroups);
        ResultBean<List<TaskDTO>> resultBean = flowableWorkBenchService.findMyToDoGroupTasks(taskQueryDTO);

        return resultBean;
    }

    @ApiOperation(value = "查询已办人列表-枚举", notes = "查询已办人列表-枚举")
    @GetMapping("/findDoneUsers")
    public ResultBean<List<WorkFlowUserDTO>> findDoneUsers() {
        ResultBean<List<WorkFlowUserDTO>> resultBean = flowableWorkBenchService.findDoneUsers();
        return resultBean;
    }

    @ApiOperation(value = "查询我的已办任务", notes = "查询我的已办任务列表")
    @ApiImplicitParam(name = "taskQueryDTO", value = "分页查询参数", required = true, dataType = "TaskQueryDTO")
    @PostMapping("/findMyDoneTasks")
    public ResultBean<List<TaskDTO>> findMyDoneTasks(@RequestBody TaskQueryDTO taskQueryDTO) {
        //默认当前登录用户
        taskQueryDTO.setUserId(authService.getLoginUser().getUserid().toString());

        ResultBean<List<TaskDTO>> resultBean = flowableWorkBenchService.findMyDoneTasks(taskQueryDTO);
        return resultBean;
    }


    //TODO 审批记录考虑需不要自建表查询
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


  /*  @DistributedLock(releaseTime = 2)
    @ApiOperation(value = "根据流程key启动流程实例-会启动流程定义最新版本", notes = "启动流程")
    @ApiImplicitParam(name = "startProcessInstanceDTO", value = "启动流程", required = true, dataType = "StartProcessInstanceDTO")
    @PostMapping(value = "/startProcessInstanceByKey", produces = "application/json")
    public ResultBean<String> startProcessInstanceByKey(@RequestBody @Valid StartProcessInstanceByKeyDTO startProcessInstanceDTO) {

        ProcessInstance processInstance = flowableWorkBenchService.startProcessInstanceByKey(startProcessInstanceDTO);
        return ResultBean.ofSuccess(processInstance.getProcessDefinitionId());
    }*/
}
