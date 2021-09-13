package com.workflow.process.center.service.cmd.rollback.strategy;

import com.workflow.process.center.exception.BizException;
import com.workflow.process.center.service.cmd.rollback.RollbackParams;
import lombok.extern.slf4j.Slf4j;
import org.flowable.common.engine.impl.interceptor.CommandContext;
import org.flowable.engine.impl.bpmn.behavior.MultiInstanceActivityBehavior;
import org.flowable.engine.impl.bpmn.behavior.SequentialMultiInstanceBehavior;
import org.flowable.engine.impl.cfg.ProcessEngineConfigurationImpl;
import org.flowable.engine.impl.persistence.entity.ExecutionEntity;
import org.flowable.engine.impl.util.CommandContextUtil;
import org.flowable.task.api.Task;
import org.flowable.task.api.history.HistoricTaskInstance;
import org.flowable.task.service.impl.HistoricTaskInstanceQueryImpl;
import org.flowable.task.service.impl.persistence.entity.HistoricTaskInstanceEntity;
import org.flowable.task.service.impl.persistence.entity.TaskEntity;
import org.flowable.variable.api.history.HistoricVariableInstance;
import org.flowable.variable.service.impl.HistoricVariableInstanceQueryImpl;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static com.workflow.process.center.common.contant.CommonContant.*;

/**
*   @Author: 土豆仙
*   @Date: 2021/7/16 19:43
*   @Description: 回撤=>正在执行会签 ，兼容嵌入式子流程
*/
@Slf4j
public class ActiveMultiInstanceTaskRollbackOperateStrategy extends AbstractRollbackOperateStrategy{

    public ActiveMultiInstanceTaskRollbackOperateStrategy(RollbackParams rollbackParams) {
        super(rollbackParams);
    }

    boolean isSequential = false;

    /**
     * 会签任务 单个执行人 表达式
     */
    private String assigneeExpr = "assignee";

    /**
     * 会签任务 集合 表达式
     */
    private String assigneeListExpr = "assigneeList";

    @Override
    public void process(CommandContext commandContext, String assignee, Map<String, Object> variables) {

        this.commandContext = commandContext;
        this.assignee = assignee;
        this.variables = variables;

        // 串行会签
        if (rollbackParams.getCurrentTaskElement().getBehavior() instanceof SequentialMultiInstanceBehavior) {
            isSequential = true;
        } else if (rollbackParams.getCurrentTaskElement().getBehavior() instanceof MultiInstanceActivityBehavior) {
            isSequential = false;
        }

        log.info("创建实例");
        createExecution();
    }

    @Override
    public void setAssigneeExpr(String assigneeExpr, String assigneeListExpr) {
        this.assigneeExpr = assigneeExpr;
        this.assigneeListExpr = assigneeListExpr;
    }

    @Override
    public void createExecution() {

        HistoricTaskInstance hisTask = rollbackParams.getHisTask();
        ProcessEngineConfigurationImpl processEngineConfiguration = CommandContextUtil.getProcessEngineConfiguration(commandContext);

        List<Task> currentTaskList = CommandContextUtil.getTaskService(commandContext)
                .createTaskQuery(processEngineConfiguration.getCommandExecutor(),processEngineConfiguration)
                .processInstanceId(hisTask.getProcessInstanceId())
                .taskDefinitionKey(hisTask.getTaskDefinitionKey())
                .list();

        if (currentTaskList.isEmpty()) {
            String msg = "当前会签任务已经完成";
            throw new BizException(msg);
        }

        if (!isSequential) {
            log.info("处理并行会签");
            processMultiInstance();
        } else {
            log.info("处理串行会签");
            processSequentialInstance();
        }


    }

    /**
     * 处理串行会签
     * 串行特殊场景 : 下一个顺序执行人已完成任务，当前历史任务不可回退
     * a -> b -> c -> d
     * b 任务完成时， a 任务不可回退
     */
    private void processSequentialInstance() {

        HistoricTaskInstance hisTask = rollbackParams.getHisTask();
        // 确认是否具有下一线性完成任务
        existNextFinishedTask(hisTask);

        // 进行任务回退操作
        ExecutionEntity executionEntity = processCommon(hisTask);


        if (executionEntity.getId().equals(hisTask.getExecutionId())) {
            log.info("未生成过下一节点");

            // 移除正在执行任务
            List<TaskEntity> taskEntityList = CommandContextUtil.getTaskService(commandContext).findTasksByExecutionId(executionEntity.getId());
            taskEntityList.forEach(obj -> {
                log.info("移除正在当前任务记录 [ id = " + obj.getId() + " ] ");
                CommandContextUtil.getTaskService(commandContext).deleteTask(obj, true);
                HistoricTaskInstance historicTaskInstance = CommandContextUtil.getHistoricTaskService(commandContext).getHistoricTask(obj.getId());
                CommandContextUtil.getHistoricTaskService(commandContext).deleteHistoricTask((HistoricTaskInstanceEntity) historicTaskInstance);
            });

            // 配置任务执行人
            executionEntity.setVariable(assigneeExpr, assignee);
            // 计数器前置一位
            int loopCounter = (int) executionEntity.getVariable(LOOP_COUNTER);
            executionEntity.setVariable(LOOP_COUNTER, loopCounter - 1);
            // 将任务重新激活
            executionEntity.setActive(true);
            // 创建新任务
            CommandContextUtil.getAgenda(commandContext).planContinueProcessInCompensation(executionEntity);
        } else {
            log.info("已生成过下一任务节点,无法找到当前 execution");
            ProcessEngineConfigurationImpl processEngineConfiguration = CommandContextUtil.getProcessEngineConfiguration(commandContext);

            List<Task> taskList = CommandContextUtil.getTaskService(commandContext)
                    .createTaskQuery(processEngineConfiguration.getCommandExecutor(),processEngineConfiguration)
                    .processInstanceId(hisTask.getProcessInstanceId())
                    .taskDefinitionKey(hisTask.getTaskDefinitionKey())
                    .list();

            Task currentTask = taskList.get(0);

            Integer currentLoopCounter = (Integer) runtimeService.getVariableLocal(currentTask.getExecutionId(), LOOP_COUNTER);
            List<String> assigneeList = (List<String>) runtimeService.getVariableLocal(currentTask.getProcessInstanceId(), assigneeListExpr);

            if (StringUtils.isEmpty(hisTask.getAssignee())) {
                throw new BizException("没有找到历史任务执行人,无法进行 执行顺序判断");
            }

            int index = assigneeList.indexOf(hisTask.getAssignee());
            if (index == -1) {
                throw new BizException("执行人不存在于初始参数,无法进行 执行顺序判断");
            }

            if (index != currentLoopCounter - 1) {
                throw new BizException("任务执行人不是 当前执行人的前位 , 不合法回退");
            }
            // 持久化变量
            assigneeList.set(index, assignee);
            runtimeService.setVariableLocal(currentTask.getProcessInstanceId(), assigneeListExpr, assigneeList);

            // 修改变量
            ExecutionEntity newExecution = CommandContextUtil.getExecutionEntityManager(commandContext).findById(currentTask.getExecutionId());
            newExecution.setVariableLocal(LOOP_COUNTER, currentLoopCounter - 1);
            newExecution.setVariableLocal(assigneeExpr, assignee);

            // 创建新任务
            CommandContextUtil.getAgenda(commandContext).planContinueMultiInstanceOperation(newExecution, executionEntity, currentLoopCounter - 1);
            // 移除当前任务
            CommandContextUtil.getTaskService(commandContext).deleteTask((TaskEntity) currentTask, true);
            // 移除历史任务
            HistoricTaskInstance historicTaskInstance = CommandContextUtil.getHistoricTaskService(commandContext).getHistoricTask(currentTask.getId());
            CommandContextUtil.getHistoricTaskService(commandContext).deleteHistoricTask((HistoricTaskInstanceEntity) historicTaskInstance);
        }

        // 移除当前历史任务
        removeHisTask(hisTask);
    }

    public void existNextFinishedTask(HistoricTaskInstance hisTask) {

        List<HistoricTaskInstance> list = CommandContextUtil.getHistoricTaskService().findHistoricTaskInstancesByQueryCriteria(
                (HistoricTaskInstanceQueryImpl) new HistoricTaskInstanceQueryImpl()
                        .processInstanceId(hisTask.getProcessInstanceId())
                        .taskDefinitionKey(hisTask.getTaskDefinitionKey())
                        .finished()
                        .taskCompletedAfter(hisTask.getEndTime())
        );

        if (!list.isEmpty()) {
            String msg = "串行会签回滚，已经具有下一线性完成任务,无法进行任务回退";
            log.error(msg);
            throw new BizException(msg);
        }

    }


    /**
     * 处理并行会签
     */
    private void processMultiInstance() {
        HistoricTaskInstance hisTask = rollbackParams.getHisTask();

        // 通用操作部分
        ExecutionEntity executionEntity = processCommon(hisTask);

        // 未生成过下一节点
        if (executionEntity.getId().equals(hisTask.getExecutionId())) {
            log.info("未生成过下一节点");
            // 配置任务执行人
            executionEntity.setVariable(assigneeExpr, assignee);
            // 将任务重新激活
            executionEntity.setActive(true);
            // 创建新任务
            CommandContextUtil.getAgenda(commandContext).planContinueProcessInCompensation(executionEntity);
        } else {
            log.info("已生成过下一任务节点,无法找到当前 execution");

            List<HistoricVariableInstance> historicVariableInstanceList = CommandContextUtil.getHistoricVariableService().findHistoricVariableInstancesByQueryCriteria(
                    new HistoricVariableInstanceQueryImpl()
                            .processInstanceId(hisTask.getProcessInstanceId())
                            .executionId(hisTask.getExecutionId())
            );

            Map<String, Object> hisVarMap = historicVariableInstanceList.stream().collect(Collectors.toMap(HistoricVariableInstance::getVariableName, item -> item.getValue()));

            // 流程执行变量
            Integer loopCounter = (Integer) hisVarMap.get(LOOP_COUNTER);

            List<ExecutionEntity> executionEntities = CommandContextUtil.getExecutionEntityManager(commandContext)
                    .findChildExecutionsByParentExecutionId(executionEntity.getId());

            List<ExecutionEntity> linkExecutions = executionEntities.stream()
                    .filter(obj -> {
                        if (!obj.isActive()) {
                            Integer currentLoopCounter = (Integer) obj.getVariable(LOOP_COUNTER);
                            if (currentLoopCounter.equals(loopCounter)) {
                                return true;
                            }
                        }
                        return false;
                    }).collect(Collectors.toList());

            if (linkExecutions.isEmpty()) {
                throw new BizException("没有找到映射节点");
            }

            ExecutionEntity newExecution = linkExecutions.get(0);

            newExecution.setCurrentFlowElement(rollbackParams.getCurrentTaskElement());
            newExecution.setActive(true);
            newExecution.setVariables(hisVarMap);
            newExecution.setVariable(assigneeExpr, assignee);

            // 创建新任务
            CommandContextUtil.getAgenda(commandContext).planContinueMultiInstanceOperation(newExecution, executionEntity, loopCounter);
        }

        // 移除当前历史任务
        removeHisTask(hisTask);
    }


    /**
     * 通用处理逻辑
     *
     * @param hisTask
     * @return
     */
    private ExecutionEntity processCommon(HistoricTaskInstance hisTask) {


        ExecutionEntity executionEntity = CommandContextUtil
                .getExecutionEntityManager(commandContext).findById(hisTask.getExecutionId());

        if (null == executionEntity) {
            log.error("没有找到历史任务[ executionId = " + hisTask.getExecutionId() + " ]");

//            List<ExecutionEntity> executionEntityList = CommandContextUtil
//                    .getExecutionEntityManager(commandContext)
//                    .findExecutionsByParentExecutionAndActivityIds(hisTask.getProcessInstanceId(), Collections.singletonList(hisTask.getTaskDefinitionKey()));
            ProcessEngineConfigurationImpl processEngineConfiguration = CommandContextUtil.getProcessEngineConfiguration(commandContext);

            List<Task> taskEntityList = CommandContextUtil.getTaskService(commandContext)
                    .createTaskQuery(processEngineConfiguration.getCommandExecutor(),processEngineConfiguration)
                    .processInstanceId(hisTask.getProcessInstanceId())
                    .taskDefinitionKey(hisTask.getTaskDefinitionKey())
                    .list();


            executionEntity = CommandContextUtil.getExecutionEntityManager(commandContext).findById(taskEntityList.get(0).getExecutionId());
        }

        ExecutionEntity parentExecutionEntity = CommandContextUtil
                .getExecutionEntityManager(commandContext).findById(executionEntity.getParentId());

        /**
         *  将计数器 进行 前移
         */
        int nrOfActiveInstances = (int) parentExecutionEntity.getVariable(NR_OF_ACTIVE_INSTANCES);
        int nrOfCompletedInstances = (int) parentExecutionEntity.getVariable(NR_OF_COMPLETE_INSTANCES);

        runtimeService.setVariable(parentExecutionEntity.getId(), NR_OF_ACTIVE_INSTANCES, nrOfActiveInstances + 1);
        runtimeService.setVariable(parentExecutionEntity.getId(), NR_OF_COMPLETE_INSTANCES, nrOfCompletedInstances - 1);

        return parentExecutionEntity;
    }
}
