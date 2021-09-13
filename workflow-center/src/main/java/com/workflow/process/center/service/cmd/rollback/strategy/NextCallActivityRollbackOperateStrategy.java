package com.workflow.process.center.service.cmd.rollback.strategy;

import com.workflow.process.center.exception.BizException;
import com.workflow.process.center.service.cmd.rollback.RollbackParams;
import lombok.extern.slf4j.Slf4j;
import org.flowable.bpmn.model.CallActivity;
import org.flowable.engine.impl.cfg.ProcessEngineConfigurationImpl;
import org.flowable.engine.impl.persistence.entity.ExecutionEntity;
import org.flowable.engine.impl.util.CommandContextUtil;
import org.flowable.task.api.Task;
import org.flowable.task.api.history.HistoricTaskInstance;
import org.flowable.task.service.impl.HistoricTaskInstanceQueryImpl;
import org.flowable.task.service.impl.persistence.entity.HistoricTaskInstanceEntity;
import org.flowable.task.service.impl.persistence.entity.TaskEntity;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import static com.workflow.process.center.common.contant.CommonContant.TASK_TYPE_PREFIX_KEY;

/**
*   @Author: 土豆仙
*   @Date: 2021/7/16 21:39
*   @Description: 回撤=》调用子流程
*/
@Slf4j
public class NextCallActivityRollbackOperateStrategy extends AbstractRollbackOperateStrategy{

    /**
     * 下一节点 callActivity
     */
    private CallActivity callActivity;

    private List<ExecutionEntity> callActivityExecutionList;

    private ExecutionEntity callActivityProcess;

    public NextCallActivityRollbackOperateStrategy(RollbackParams rollbackParams) {
        super(rollbackParams);
    }

    @Override
    public void existNextFinishedTask() {

        HistoricTaskInstance hisTask = rollbackParams.getHisTask();

        Map<String, CallActivity> callActivityMap = rollbackParams.getCallActivityMap();
        String key = callActivityMap.keySet().iterator().next();
        this.callActivity = callActivityMap.get(key);

        // 下一节点callActivity的 flowId
        callActivityExecutionList = CommandContextUtil.getExecutionEntityManager(commandContext)
                .findExecutionsByParentExecutionAndActivityIds(hisTask.getProcessInstanceId(), Collections.singletonList(callActivity.getId()));

        // callActivity 在 父级流程的 executionId = 子流程的 processInstanceId
        ExecutionEntity executionEntity = callActivityExecutionList.get(0);

        // 子流程
        callActivityProcess = CommandContextUtil.getExecutionEntityManager(commandContext)
                .findSubProcessInstanceBySuperExecutionId(executionEntity.getId());

        List<HistoricTaskInstance> hisTaskList = CommandContextUtil.getHistoricTaskService(commandContext)
                .findHistoricTaskInstancesByQueryCriteria(
                        (HistoricTaskInstanceQueryImpl) new HistoricTaskInstanceQueryImpl()
                                .finished()
                                .processInstanceId(callActivityProcess.getId())
                );

        if (!hisTaskList.isEmpty()) {
            throw new BizException("子流程已经具有完成的任务,流程无法回退");
        }
    }

    @Override
    public void setAssignee() {
        // 进行任务执行人配置,之后使用全局监听出发更新
        super.setAssignee();
        String type = TASK_TYPE_PREFIX_KEY + rollbackParams.getHisTask().getProcessInstanceId() + rollbackParams.getHisTask().getTaskDefinitionKey();
        variables.put(type, NextCallActivityRollbackOperateStrategy.class.getSimpleName());
    }

    @Override
    public void createExecution() {
        HistoricTaskInstance hisTask = rollbackParams.getHisTask();
        ExecutionEntity executionEntity = CommandContextUtil.getExecutionEntityManager(commandContext)
                .findById(hisTask.getExecutionId());

        if (null == executionEntity) {
            log.info("没有找到execution");
            executionEntity = callActivityExecutionList.get(0);
        }

        ExecutionEntity newExecution = CommandContextUtil.getExecutionEntityManager(commandContext)
                .createChildExecution(executionEntity.getParent());

        // 创建新任务
        createExecution(newExecution);
        // 移除历史任务
        removeHisTask(hisTask);
    }

    @Override
    public void deleteRuntimeTasks() {

        ExecutionEntity parentExecution = callActivityExecutionList.get(0);


        // 清理子流程
        cleanCallActivityProcessInstance(callActivityProcess);
        // 清理主流程记录
        CommandContextUtil.getExecutionEntityManager(commandContext)
                .delete(parentExecution);

    }

    /**
     * // 无效操作
     * CommandContextUtil.getExecutionEntityManager(commandContext)
     * .deleteProcessInstance(callActivityProcess.getId(), "进行流程撤回", false);
     * 清理 调用子流程 相关数据
     *
     * @param processInstance
     */
    private void cleanCallActivityProcessInstance(ExecutionEntity processInstance) {

        ProcessEngineConfigurationImpl processEngineConfiguration = CommandContextUtil.getProcessEngineConfiguration(commandContext);
        // 移除正在运行任务信息
        List<Task> list = CommandContextUtil.getTaskService(commandContext)
                .createTaskQuery(processEngineConfiguration.getCommandExecutor(),processEngineConfiguration)
                .processInstanceId(processInstance.getId())
                .list();
        list.forEach(obj->removeRuntimeTaskOperate((TaskEntity) obj));

        // 移除历史任务信息
        List<HistoricTaskInstanceEntity> historicTaskInstanceList = CommandContextUtil.getHistoricTaskService(commandContext)
                .findHistoricTasksByProcessInstanceId(processInstance.getId());
        historicTaskInstanceList.forEach(obj->CommandContextUtil.getHistoricTaskService(commandContext).deleteHistoricTask(obj));

        // 移除 子流程实例
        CommandContextUtil.getIdentityLinkService(commandContext).deleteIdentityLinksByProcessInstanceId(processInstance.getId());
        CommandContextUtil.getVariableService(commandContext).deleteVariablesByExecutionId(processInstance.getId());
        CommandContextUtil.getExecutionEntityManager(commandContext).delete(processInstance.getId());
    }

}
