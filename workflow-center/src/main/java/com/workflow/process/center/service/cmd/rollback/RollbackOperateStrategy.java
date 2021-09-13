package com.workflow.process.center.service.cmd.rollback;

import org.flowable.common.engine.impl.interceptor.CommandContext;

import java.util.Map;

/**
*   @Author: 土豆仙
*   @Date: 2021/7/16 19:29
*   @Description: 回滚操作策略
*/
public interface RollbackOperateStrategy {
    /**
     * 处理
     */
    void process(CommandContext commandContext, String assignee);

    /**
     * 处理
     */
    void process(CommandContext commandContext, String assignee, Map<String, Object> variables);


    /**
     *  配置处理标识
     * @param assigneeExpr
     * @param assigneeListExpr
     */
    void setAssigneeExpr(String assigneeExpr, String assigneeListExpr);

    /**
     *  配置任务处理人
     */
    void setAssignee();

    /**
     * 移除相关关联
     */
    void existNextFinishedTask();

    /**
     * 移除历史痕迹
     */
    void deleteHisActInstance();

    /**
     * 移除正在运行的任务
     */
    void deleteRuntimeTasks();

    /**
     * 创建任务
     */
    void createExecution();
}
