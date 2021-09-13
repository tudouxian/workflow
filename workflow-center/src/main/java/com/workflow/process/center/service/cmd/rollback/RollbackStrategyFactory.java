package com.workflow.process.center.service.cmd.rollback;

import org.flowable.task.api.history.HistoricTaskInstance;

/**
*   @Author: 土豆仙
*   @Date: 2021/7/16 19:25
*   @Description: 回撤工厂类-考虑流程当前运行状态不同，撤回逻辑不同=》使用策略+模板模式
*/
public interface RollbackStrategyFactory {
    /**
     *  创建回滚策略
     * @param hisTask
     * @return
     */
    RollbackOperateStrategy createStrategy(HistoricTaskInstance hisTask);

    /**
     *  当前任务未完成判定
     * @param template
     * @return
     */
    boolean currentMultiInstanceTaskUnfinished(RollbackParams template);
}
