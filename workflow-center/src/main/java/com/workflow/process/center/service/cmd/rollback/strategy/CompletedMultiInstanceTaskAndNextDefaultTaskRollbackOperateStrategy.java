package com.workflow.process.center.service.cmd.rollback.strategy;

import com.workflow.process.center.exception.BizException;
import com.workflow.process.center.service.cmd.rollback.RollbackParams;
import lombok.extern.slf4j.Slf4j;
import org.flowable.engine.impl.bpmn.behavior.SequentialMultiInstanceBehavior;
import org.flowable.engine.impl.persistence.entity.ExecutionEntity;
import org.flowable.engine.impl.util.CommandContextUtil;
import org.flowable.variable.api.history.HistoricVariableInstance;
import org.flowable.variable.service.impl.HistoricVariableInstanceQueryImpl;
import org.flowable.variable.service.impl.persistence.entity.VariableInstanceEntity;

import java.util.*;
import java.util.stream.Collectors;

import static com.workflow.process.center.common.contant.CommonContant.*;

/**
 *   @Author: 土豆仙
 *   @Date: 2021/7/16 22:09
 *   @Description: 回撤=》已完成会签 ， 下一节点是普通节点
 */
@Slf4j
public class CompletedMultiInstanceTaskAndNextDefaultTaskRollbackOperateStrategy  extends AbstractRollbackOperateStrategy{

    private boolean isSequence = false;

    /**
     * 会签任务 单个执行人 表达式
     */
    private String assigneeExpr = "assignee";

    /**
     * 会签任务 集合 表达式
     */
    private String assigneeListExpr = "assigneeList";


    public CompletedMultiInstanceTaskAndNextDefaultTaskRollbackOperateStrategy(RollbackParams rollbackParams) {
        super(rollbackParams);
    }

    @Override
    public void createExecution() {

        if (rollbackParams.getCurrentTaskElement().getBehavior() instanceof SequentialMultiInstanceBehavior) {
            isSequence = true;
        }

        // 获取 execution
        ExecutionEntity executionEntity = getExecutionEntity();
        //流程实例和变量名
        List<VariableInstanceEntity> variables = CommandContextUtil.getVariableService(commandContext)
                .findVariableInstancesByExecutionId(executionEntity.getProcessInstanceId());
        Optional<VariableInstanceEntity> first = variables.stream().filter(variableInstanceEntity -> variableInstanceEntity.getName().equals(assigneeListExpr)).findFirst();
        VariableInstanceEntity obj = first.isPresent()?first.get():null;


        if (obj == null || !(obj.getValue() instanceof Collection)) {
            throw new BizException("没有可用会签参数:" + assigneeListExpr);
        }
        // 会签执行人变量
        Collection assignees = (Collection) obj.getValue();

        List<HistoricVariableInstance> historicVariableInstances = CommandContextUtil.getHistoricVariableService()
                .findHistoricVariableInstancesByQueryCriteria(
                        new HistoricVariableInstanceQueryImpl()
                                .executionId(rollbackParams.getHisTask().getExecutionId())
                );

        if (historicVariableInstances.isEmpty()) {
            throw new BizException("没有可用会签任务参数");
        }

        // 历史变量
        Map<String, Object> hisVarMap = historicVariableInstances.stream().collect(Collectors.toMap(HistoricVariableInstance::getVariableName, item -> item.getValue()));

        if (hisVarMap.containsKey(assigneeExpr) && hisVarMap.containsKey(LOOP_COUNTER)) {
            log.info("变量有效");
        } else {
            throw new BizException("缺少会签任务变量");
        }

        /**
         *  串行 最终的 loopCounter assignee 都会是最后一个人
         */
        if (isSequence) {

            List<String> assigneeList = (List<String>) runtimeService.getVariableLocal(rollbackParams.getHisTask().getProcessInstanceId(), assigneeListExpr);
            if (!assigneeList.get(assigneeList.size() - 1).equals(rollbackParams.getHisTask().getAssignee())) {
                String msg = "不是串行最后一个节点，无法进行回退 ";
                throw new BizException(msg);
            }
            // 替换任务执行变量
            assigneeList.set(assigneeList.size() - 1, assignee);
            runtimeService.setVariableLocal(rollbackParams.getHisTask().getProcessInstanceId(), assigneeListExpr, assigneeList);
        }

        // 流程执行变量
        Integer loopCounter = (Integer) hisVarMap.get(LOOP_COUNTER);

        // 会签主任务
        ExecutionEntity parentExecution = CommandContextUtil.getExecutionEntityManager(commandContext)
                .createChildExecution(executionEntity.getParent());

        parentExecution.setCurrentFlowElement(rollbackParams.getCurrentTaskElement());
        parentExecution.setActive(false);
        // 配置 会签 root execution
        parentExecution.setMultiInstanceRoot(true);

        // 配置主 execution 变量
        Map<String, Object> parentVarMap = new HashMap<>();
        parentVarMap.put(NR_OF_ACTIVE_INSTANCES, 1);
        parentVarMap.put(NR_OF_COMPLETE_INSTANCES, assignees.size() - 1);
        parentVarMap.put(NR_OF_INSTANCE, assignees.size());
        parentExecution.setVariablesLocal(parentVarMap);

        if (isSequence) {
            log.info("创建 串行 会签任务");
            createSequenceMultiInstance(parentExecution, assignees);
        } else {
            log.info("创建 并行 会签任务");
            createParallelMultiInstance(parentExecution, assignees, loopCounter);

        }

        removeHisTask(rollbackParams.getHisTask());
    }

    private void createSequenceMultiInstance(ExecutionEntity parentExecution, Collection assignees) {

        ExecutionEntity newExecution = CommandContextUtil.getExecutionEntityManager(commandContext)
                .createChildExecution(parentExecution);

        Map<String, Object> varMap = new HashMap<>();
        varMap.put(assigneeExpr, assignee);
        varMap.put(LOOP_COUNTER, assignees.size() - 1);
        newExecution.setCurrentFlowElement(rollbackParams.getCurrentTaskElement());

        newExecution.setVariablesLocal(varMap);
        newExecution.setActive(true);
        CommandContextUtil.getAgenda(commandContext).planContinueMultiInstanceOperation(newExecution, parentExecution, assignees.size() - 1);

    }

    /**
     * 创建并行会签任务
     *
     * @param parentExecution
     * @param loopCounter
     */
    private void createParallelMultiInstance(ExecutionEntity parentExecution, Collection assignees, Integer loopCounter) {

        for (int i = 0; i < assignees.size(); i++) {
            if (i != loopCounter) {
                Map<String, Object> varMap = new HashMap<>();
                varMap.put(LOOP_COUNTER, i);
                varMap.put(assigneeExpr, "已完成任务");

//                // 创建 新执行任务
                ExecutionEntity newExecution = newExecution = CommandContextUtil.getExecutionEntityManager(commandContext)
                        .createChildExecution(parentExecution);
                newExecution.setCurrentFlowElement(rollbackParams.getCurrentTaskElement());
                newExecution.setActive(false);

                newExecution.setVariablesLocal(varMap);

//
//                CommandContextUtil.getExecutionEntityManager(commandContext)
//                        .update(newExecution);
            } else {
                ExecutionEntity newExecution = CommandContextUtil.getExecutionEntityManager(commandContext)
                        .createChildExecution(parentExecution);
                newExecution.setCurrentFlowElement(rollbackParams.getCurrentTaskElement());

                Map<String, Object> varMap = new HashMap<>();

                varMap.put(assigneeExpr, assignee);
                varMap.put(LOOP_COUNTER, i);

                newExecution.setVariablesLocal(varMap);
                newExecution.setActive(true);

                CommandContextUtil.getAgenda(commandContext).planContinueMultiInstanceOperation(newExecution, parentExecution, loopCounter);
            }
        }


    }

}
