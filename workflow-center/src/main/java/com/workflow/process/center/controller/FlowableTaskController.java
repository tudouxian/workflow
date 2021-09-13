package com.workflow.process.center.controller;

import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.common.enums.entity.ButtonTypeEnum;
import com.workflow.process.center.domain.dto.task.*;
import com.workflow.process.center.domain.entity.WorkFlowButton;
import com.workflow.process.center.domain.dto.FlowableNodeDTO;
import com.workflow.process.center.exception.BizException;
import com.workflow.process.center.service.AuthService;
import com.workflow.process.center.service.FlowableTaskService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.IOException;
import java.util.List;

/**
 * @Author: 土豆仙
 * @Date: 2021/6/28 15:20
 * @Description: 任务相关操作
 */
@Api(tags = "任务相关操作")
@RestController
@RequestMapping("/flowable/task")
public class FlowableTaskController {

    @Autowired
    private FlowableTaskService flowableTaskService;

    @Autowired
    private AuthService authService;


    /**
     * 流程实例终止
     *
     * @param params 参数
     * @return
     */
    @ApiOperation("流程实例终止-强制结束")
    @PostMapping(value = "/stopProcess")
    public ResultBean<String> stopProcess(@RequestBody @Validated EndTaskDTO params) {
        params.setUserId(authService.getLoginUser().getUserid().toString());
        flowableTaskService.stopProcessInstanceById(params);
        return ResultBean.ofSuccess("终止成功！");
    }

    /**
     * 中止或者撤销
     *
     * @param params 参数
     * @return
     */
    @ApiOperation("中止或者撤销")
    @PostMapping(value = "/revokeProcess")
    public ResultBean<String> revokeProcess(@RequestBody @Validated RevokeTaskDTO params) {
        params.setUserId(authService.getLoginUser().getUserid().toString());
        flowableTaskService.revokeProcess(params);
        return ResultBean.ofSuccess("撤销成功！");
    }

    /**
     * 流程实例挂起=》暂停
     *
     * @param state 参数
     *  @param state processInstanceId
     * @return
     */
    @ApiOperation(value = "激活或挂起流程实例")
    @GetMapping(value = "/updateState")
    public ResultBean updateState(@ApiParam(value = "1:激活,2:挂起", required = true) @RequestParam Integer state,
                                  @ApiParam(value = "流程实例ID", required = true) @RequestParam String processInstanceId) {
        flowableTaskService.updateState(state,processInstanceId);
        return ResultBean.ofSuccess();
    }

    /**
     * 签收-领取任务
     *
     * @param params 参数
     * @return
     */
    @ApiOperation("签收任务")
    @PostMapping(value = "/claimTask")
    public ResultBean<String> claimTask(@RequestBody @Valid ClaimTaskDTO params) {
        params.setUserId(authService.getLoginUser().getUserid().toString());
        flowableTaskService.claimTask(params);
        return ResultBean.ofSuccess("签收任务成功！");
    }

    /**
     * 反签收-归还任务
     *
     * @param params 参数
     * @return
     */
    @ApiOperation("反签收任务-归还任务")
    @PostMapping(value = "/unClaimTask")
    public ResultBean<String> unClaimTask(@RequestBody @Validated ClaimTaskDTO params) {
        params.setUserId(authService.getLoginUser().getUserid().toString());
        flowableTaskService.unClaimTask(params);
        return ResultBean.ofSuccess("归还任务成功！");
    }

    /**
     * 委派-A由于某些原因不能处理该任务，可以把任务委派给用户B代理，
     * 当B处理完成之后再次回到用户A这里，
     * 在这个过程中A是任务的所有者，B是该任务的办理人
     *
     * @param params 参数
     * @return
     */
    @ApiOperation("委派任务")
    @PostMapping(value = "/delegateTask")
    public ResultBean<String> delegateTask(@RequestBody @Valid DelegateTaskDTO params) {
        params.setUserId(authService.getLoginUser().getUserid().toString());
        flowableTaskService.delegateTask(params);

        return ResultBean.ofSuccess("委派成功！");
    }

    /**
     * 本来是候选组A 修改为候选组B----可用于组转办
     * @param params 参数
     * @return
     */
    @ApiOperation("修改候选组")
    @PostMapping(value = "/updateTaskCandidateGroup")
    public ResultBean<String> updateTaskCandidateGroup(@RequestBody @Valid UpdateCandidateTaskDTO params) {
        params.setUserId(authService.getLoginUser().getUserid().toString());
        flowableTaskService.updateTaskCandidateGroup(params);
        return ResultBean.ofSuccess("修改候选组成功！");
    }

    /**
     * 本来是候选组A 修改为候选组B----可用于组协同
     * @param params 参数
     * @return
     */
    @ApiOperation("新增候选组")
    @PostMapping(value = "/addTaskCandidateGroup")
    public ResultBean<String> addTaskCandidateGroup(@RequestBody @Valid UpdateCandidateTaskDTO params) {
        params.setUserId(authService.getLoginUser().getUserid().toString());
        flowableTaskService.addTaskCandidateGroup(params);
        return ResultBean.ofSuccess("修改候选组成功！");
    }

    /**
     * 审批任务
     *
     * @param params 参数
     * @return
     */
    @ApiOperation(value = "审批任务")
    @PostMapping(value = "/complete")
    public ResultBean<String> complete(@RequestBody @Validated CompleteTaskDTO params) {

        params.setUserId(authService.getLoginUser().getUserid().toString());
        flowableTaskService.complete(params);

        return ResultBean.ofSuccess("审批完成！");
    }

    /**
     * 撤回任务
     *
     * @param params 参数
     * @return
     */
    @ApiOperation(value = "撤回任务")
    @PostMapping(value = "/rollback")
    public ResultBean<String> rollback(@RequestBody @Validated RollbackTaskDTO params) {

        params.setUserId(authService.getLoginUser().getUserid().toString());
        flowableTaskService.rollback(params);

        return ResultBean.ofSuccess("撤回任务成功！");
    }

    /**
     * 转办
     *
     * @param params 参数
     * @return
     */
    @ApiOperation("转办任务")
    @PostMapping(value = "/turnTask")
    public ResultBean<String> turnTask(@RequestBody @Validated TurnTaskDTO params) {

        params.setUserId(authService.getLoginUser().getUserid().toString());
        flowableTaskService.turnTask(params);
        return ResultBean.ofSuccess("转办任务成功！");
    }

    /**
     * 协同
     *任务在A这里，A指定BCD协同处理，ABCD都能看到当前任务=》增加可指定BCD是否拥有提交权限
     * @param params 参数
     * @return
     */
    @ApiOperation("协同")
    @PostMapping(value = "/synergyTask")
    public ResultBean<String> synergy(@RequestBody @Validated SynergyTaskDTO params) {

        params.setUserId(authService.getLoginUser().getUserid().toString());
        flowableTaskService.synergyTask(params);

        return ResultBean.ofSuccess("协同处理成功！");
    }


    /**
     * 向前加签
     *任务在A这里，A这个时候需要BCD核对一下，等BCD核对之后又回到A这里
     * @param params 参数
     * @return
     */
    @ApiOperation("向前加签")
    @PostMapping(value = "/beforeAddSignTask")
    public ResultBean<String> beforeAddSignTask(@RequestBody @Validated AddSignTaskDTO params) {

        params.setUserId(authService.getLoginUser().getUserid().toString());
        flowableTaskService.beforeAddSignTask(params);

        return ResultBean.ofSuccess("向前加签成功！");
    }

    /**
     * 向后加签
     *任务在A这里，A这个时候需要BCD处理这个事情，处理完毕之后就不用管了，继续后面的审批环节
     * @param params 参数
     * @return
     */
    @ApiOperation("向后加签")
    @PostMapping(value = "/afterAddSignTask")
    public ResultBean<String> afterAddSignTask(@RequestBody @Validated AddSignTaskDTO params) {

        params.setUserId(authService.getLoginUser().getUserid().toString());
        flowableTaskService.afterAddSignTask(params);

        return ResultBean.ofSuccess("向后加签成功！");
    }


    //指定驳回

    /**
     * 获取可驳回节点列表
     *
     * @param processInstanceId 流程实例id
     * @return
     */
    @ApiOperation("获取可驳回节点列表")
    @GetMapping(value = "/getBackNodesByProcessInstanceId/{processInstanceId}/{taskId}")
    public ResultBean<List<FlowableNodeDTO>> getBackNodesByProcessInstanceId(@PathVariable String processInstanceId, @PathVariable String taskId) {
        List<FlowableNodeDTO> datas = flowableTaskService.getBackNodesByProcessInstanceId(processInstanceId, taskId);
        return ResultBean.ofSuccess(datas);

    }

    /**
     * 驳回节点
     *
     * @param params 参数
     * @return
     */
    @ApiOperation("驳回节点")
    @PostMapping(value = "/doBackStep")
    public ResultBean<String> doBackStep(@RequestBody @Validated BackTaskDTO params) {
        params.setUserId(authService.getLoginUser().getUserid().toString());
        flowableTaskService.backToStepTask(params);
        return ResultBean.ofSuccess("驳回节点成功！");
    }

    /**
     * @param taskId 任务ID
     * @return 该任务对应审核按钮列表
     */
    @ApiOperation("根据任务ID查询审核按钮列表")
    @GetMapping("/findButtonsByTaskId")
    public ResultBean<List<WorkFlowButton>> findButtonsByTaskId(@RequestParam(value = "taskId", required = false)  String taskId,
                                                                @RequestParam(value = "buttonTypeEnum", required = true) ButtonTypeEnum buttonTypeEnum) {
        List<WorkFlowButton> buttonsByTaskId = flowableTaskService.findButtonsByTaskId(taskId,buttonTypeEnum);
        return ResultBean.ofSuccess(buttonsByTaskId);
    }


    @ApiOperation("获取流程图图片-跟踪-后期用在流程实例跟踪上")
    @GetMapping(value = "/image/{processInstanceId}")
    public void image(@PathVariable String processInstanceId, HttpServletResponse response) {
        byte[] b = flowableTaskService.createImage(processInstanceId);
        response.setHeader("Content-type", "text/xml;charset=UTF-8");
        try {
            response.getOutputStream().write(b);
        } catch (IOException e) {
            e.printStackTrace();
            throw new BizException("获取流程图图片");
        }

    }


}
