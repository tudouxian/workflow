package com.workflow.process.center.api;

import com.workflow.process.center.domain.dto.FlowableNodeDTO;
import com.workflow.process.center.domain.dto.task.*;

import java.util.List;

public interface TaskService {


    /**
     * 审批任务
     *
     * @param params 参数
     */
    void complete(CompleteTaskDTO params);

    /**
     * 流程实例终止
     *
     * @param params 参数
     */
    void stopProcessInstanceById(EndTaskDTO params);

    /**
     * 中止或者撤销
     *
     * @param params 参数
     */
    void revokeProcess(RevokeTaskDTO params);

    /**
     * 转办
     *
     * @param params 参数
     */
    void turnTask(TurnTaskDTO params);

    /**
     * 委派-A由于某些原因不能处理该任务，可以把任务委派给用户B代理，
     * 当B处理完成之后再次回到用户A这里，
     * 在这个过程中A是任务的所有者，B是该任务的办理人
     *
     * @param params 参数
     */
    void delegateTask(DelegateTaskDTO params);

    /**
     * 签收-领取任务
     *
     * @param params 参数
     */
    void claimTask(ClaimTaskDTO params);

    /**
     * 反签收-归还任务
     *
     * @param params 参数
     */
    void unClaimTask(ClaimTaskDTO params);

    /**
     * 协同
     *任务在A这里，A指定BCD协同处理，ABCD都能看到当前任务=》增加可指定BCD是否拥有提交权限
     * @param params 参数
     */
    void synergyTask(SynergyTaskDTO params);

    /**
     * 向前加签
     *任务在A这里，A这个时候需要BCD核对一下，等BCD核对之后又回到A这里
     * @param params 参数
     */
    void beforeAddSignTask(AddSignTaskDTO params);

    /**
     * 向后加签
     *任务在A这里，A这个时候需要BCD处理这个事情，处理完毕之后就不用管了，继续后面的审批环节
     * @param params 参数
     */
    void afterAddSignTask(AddSignTaskDTO params);

    /**
     * 驳回节点
     *
     * @param params 参数
     */
    void backToStepTask(BackTaskDTO params);

    /**
     * 获取可驳回节点列表
     *
     * @param processInstanceId 流程实例id
     */
    List<FlowableNodeDTO> getBackNodesByProcessInstanceId(String processInstanceId, String taskId);

    /**
     * 撤回任务
     *
     * @param params 参数
     */
    void rollback(RollbackTaskDTO params);

    /**
     * 流程实例挂起=》暂停
     *
     * @param state 参数
     *  @param state processInstanceId
     */
    void updateState(Integer state, String processInstanceId);
}
