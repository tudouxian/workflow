package com.workflow.process.center.service.cmd.rollback.strategy;

import com.workflow.process.center.service.cmd.rollback.RollbackParams;
import org.flowable.engine.impl.persistence.entity.ExecutionEntity;
import org.flowable.engine.impl.util.CommandContextUtil;
import org.flowable.task.api.history.HistoricTaskInstance;

import static com.workflow.process.center.common.contant.CommonContant.TASK_TYPE_PREFIX_KEY;

/**
*   @Author: 土豆仙
*   @Date: 2021/7/16 21:32
*   @Description: 回撤=》普通节点 ，兼容嵌入式子流程
*/
public class NextDefaultUserTaskRollbackOperateStrategy extends AbstractRollbackOperateStrategy{
    public NextDefaultUserTaskRollbackOperateStrategy(RollbackParams rollbackParams) {
        super(rollbackParams);
    }

    @Override
    public void createExecution() {
        HistoricTaskInstance hisTask = rollbackParams.getHisTask();

        // 获取正在执行 execution
        ExecutionEntity executionEntity = getExecutionEntity();

        ExecutionEntity newExecution = CommandContextUtil.getExecutionEntityManager(commandContext).createChildExecution(executionEntity.getParent());
        // 创建新任务
        createExecution(newExecution);
        // 移除历史任务
        removeHisTask(hisTask);
    }

    @Override
    public void setAssignee() {
        // 进行任务执行人配置,之后使用全局监听出发更新
        super.setAssignee();
        String type = TASK_TYPE_PREFIX_KEY + rollbackParams.getHisTask().getProcessInstanceId() + rollbackParams.getHisTask().getTaskDefinitionKey();
        variables.put(type, NextDefaultUserTaskRollbackOperateStrategy.class.getSimpleName());
    }

}
