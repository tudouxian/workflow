package com.workflow.process.center.service.cmd.rollback;

import com.workflow.common.utils.spring.SpringUtils;
import com.workflow.process.center.exception.BizException;
import lombok.extern.slf4j.Slf4j;
import org.flowable.common.engine.impl.interceptor.Command;
import org.flowable.common.engine.impl.interceptor.CommandContext;
import org.flowable.engine.HistoryService;
import org.flowable.engine.RuntimeService;
import org.flowable.engine.runtime.ProcessInstance;
import org.flowable.task.api.history.HistoricTaskInstance;

/**
*   @Author: 土豆仙
*   @Date: 2021/7/16 19:19
*   @Description: 撤回操作命令行实现
*/
@Slf4j
public class RollbackCmd implements Command<Object> {

    /**
     * 任务ID
     */
    private String taskId;

    /**
     * 当前操作用户ID
     */
    private String assignee;

    /**
     * 流程历史服务
     */
    private HistoryService historyService;

    /**
     * 流程运行时服务
     */
    private RuntimeService runtimeService;

    /**
     * 撤回操作工厂类
     */
    private RollbackStrategyFactory rollbackStrategyFactory;

    /**
     * 会签任务 单个执行人 表达式
     */
    private String assigneeExpr = "assignee";

    /**
     * 会签任务 集合 表达式
     */
    private String assigneeListExpr = "assigneeList";

    public RollbackCmd(String taskId, String assignee) {
        this.taskId = taskId;
        this.assignee = assignee;

        this.historyService = SpringUtils.getBean(HistoryService.class);
        this.runtimeService = SpringUtils.getBean(RuntimeService.class);
        this.rollbackStrategyFactory = SpringUtils.getBean(RollbackStrategyFactory.class);
    }


    @Override
    public Object execute(CommandContext commandContext) {
        HistoricTaskInstance hisTask = historyService.createHistoricTaskInstanceQuery().taskId(taskId).singleResult();

        if (null == hisTask.getEndTime()){
            String msg = "任务正在执行,不需要回退";
            log.error(msg);
            throw new BizException(msg);
        }

        ProcessInstance pi = runtimeService.createProcessInstanceQuery()
                .processInstanceId(hisTask.getProcessInstanceId())
                .singleResult();
        if (null == pi) {
            String msg = "该流程已经完成，无法进行任务回退。";
            log.error(msg);
            throw new BizException(msg);
        }

        RollbackOperateStrategy strategy = rollbackStrategyFactory.createStrategy(hisTask);

        // 配置任务执行表达式
        strategy.setAssigneeExpr(assigneeExpr, assigneeListExpr);
        // 处理
        strategy.process(commandContext, assignee);

        return null;
    }
}
