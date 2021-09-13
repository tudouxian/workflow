package com.workflow.process.center.service.cmd.rollback;

import com.workflow.process.center.service.cmd.rollback.strategy.*;
import lombok.extern.slf4j.Slf4j;
import org.flowable.bpmn.model.*;
import org.flowable.engine.RepositoryService;
import org.flowable.engine.TaskService;
import org.flowable.task.api.history.HistoricTaskInstance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

/**
*   @Author: 土豆仙
*   @Date: 2021/7/16 19:33
*   @Description: 策略工厂实现类
*/
@Component
@Slf4j
public class DefaultRollbackStrategyFactoryBean implements RollbackStrategyFactory{

    @Autowired
    private RepositoryService repositoryService;
    @Autowired
    private TaskService taskService;


    @Override
    public RollbackOperateStrategy createStrategy(HistoricTaskInstance hisTask) {
        BpmnModel bpmnModel = repositoryService.getBpmnModel(hisTask.getProcessDefinitionId());

        RollbackParams rollbackParams = new RollbackParams();

        rollbackParams.setHisTask(hisTask);
        // 获取当前任务的节点信息
        getThisUserTask(rollbackParams, bpmnModel, hisTask);
        // 获取下一节点信息
        getNextElementInfo(rollbackParams, bpmnModel);
        // 创建策略
        RollbackOperateStrategy strategy = createStrategyInstance(rollbackParams);

        return strategy;
    }

    @Override
    public boolean currentMultiInstanceTaskUnfinished(RollbackParams template) {
        if (template.getCurrentTaskElement().getLoopCharacteristics() == null) {
            log.info("当前任务节点不是会签节点");
            return false;
        }

        long count = taskService.createTaskQuery()
                .processInstanceId(template.getHisTask().getProcessInstanceId())
                .taskDefinitionKey(template.getHisTask().getTaskDefinitionKey())
                .count();
        if (count > 0) {
            log.info("具有未完成当前节点任务");
            return true;
        }

        return false;
    }

    /**
     * 生成策略
     *
     * @param rollbackParams
     * @return
     */
    private RollbackOperateStrategy createStrategyInstance(RollbackParams rollbackParams) {

        // 处理正在执行会签节点
        if (currentMultiInstanceTaskUnfinished(rollbackParams)) {
            log.info("-回退 正在执行会签 策略");
            return new ActiveMultiInstanceTaskRollbackOperateStrategy(rollbackParams);
        }

        // 默认节点处理策略
        if (rollbackParams.getCurrentTaskElement().getLoopCharacteristics() == null
                && rollbackParams.getGatewayMap().isEmpty()
                && !rollbackParams.getNextUserTaskList().isEmpty()) {
            log.info("-回退 普通任务 策略");
            return new NextDefaultUserTaskRollbackOperateStrategy(rollbackParams);
        }

        // 下一节点 嵌入式子流程
        if (rollbackParams.getCurrentTaskElement().getLoopCharacteristics() == null
                && rollbackParams.getGatewayMap().isEmpty()
                && !rollbackParams.getSubProcessMap().isEmpty()) {
            log.info("-回退 嵌入式子流程 策略");
            return new NextSubProcessRollbackOperateStrategy(rollbackParams);
        }

        // 下一节点 调用式子流程
        if (rollbackParams.getCurrentTaskElement().getLoopCharacteristics() == null
                && rollbackParams.getGatewayMap().isEmpty()
                && !rollbackParams.getCallActivityMap().isEmpty()) {
            log.info("-回退 调用式子流程 策略");
            return new NextCallActivityRollbackOperateStrategy(rollbackParams);
        }

        // 下一节点 网关,多级网关
        if (rollbackParams.getCurrentTaskElement().getLoopCharacteristics() == null
                && !rollbackParams.getGatewayMap().isEmpty()) {
            log.info("-回退 网关, 多级网关 策略");
            return new DefaultNextGatewayRollbackOperateStrategy(rollbackParams);
        }

        // 会签已完成
        if (rollbackParams.getCurrentTaskElement().getLoopCharacteristics() != null) {

            if ( rollbackParams.getGatewayMap().isEmpty()
                    && !rollbackParams.getNextUserTaskList().isEmpty()) {
                log.info("-回退 已完成会签,下一节点普通任务 策略");
                return new CompletedMultiInstanceTaskAndNextDefaultTaskRollbackOperateStrategy(rollbackParams);
            }

            return null;
        }


        return null;
    }

    /**
     * 获取下一节点任务
     *
     * @param rollbackParams
     * @param bpmnModel
     */
    private void getNextElementInfo(RollbackParams rollbackParams, BpmnModel bpmnModel) {

        if (null != rollbackParams.getCurrentSubProcess()) {
            log.info("当前任务存在于 SubProcess");
            getNextElementInfo(rollbackParams, rollbackParams.getCurrentSubProcess(), rollbackParams.getCurrentTaskElement().getOutgoingFlows());
            return;
        }
        log.info("当前任务存在于 bpmnModel");
        // 主线流程图
        getNextElementInfo(rollbackParams, bpmnModel.getMainProcess(), rollbackParams.getCurrentTaskElement().getOutgoingFlows());
    }

    /**
     * 获取下一节点网关任务
     *
     * @param rollbackParams
     * @param flowElementsContainer
     * @param outgoingFlows
     */
    private void getNextElementInfo(RollbackParams rollbackParams, FlowElementsContainer flowElementsContainer, List<SequenceFlow> outgoingFlows) {

        for (SequenceFlow flow : outgoingFlows) {

            rollbackParams.getNextFlowIdList().add(flow.getId());
            rollbackParams.getOutGoingMap().put(flow.getId(), flow);

            // 下一节点
            FlowElement flowElement = flowElementsContainer.getFlowElement(flow.getTargetRef());
            rollbackParams.getNextFlowIdList().add(flowElement.getId());

            if (flowElement instanceof UserTask) {
                log.info("下一节点：UserTask");
                rollbackParams.getNextUserTaskList().add((UserTask) flowElement);
            } else if (flowElement instanceof Gateway) {
                log.info("下一节点：Gateway");
                Gateway gateway = ((Gateway) flowElement);
                rollbackParams.getGatewayMap().put(gateway.getId(), gateway);
                getNextElementInfo(rollbackParams, flowElementsContainer, gateway.getOutgoingFlows());
            } else if (flowElement instanceof SubProcess) {
                log.info("下一节点：SubProcess");
                SubProcess subProcess = (SubProcess) flowElement;
                rollbackParams.getSubProcessMap().put(subProcess.getId(), subProcess);
            } else if (flowElement instanceof CallActivity) {
                log.info("下一节点：CallActivity");
                CallActivity callActivity = (CallActivity) flowElement;
                rollbackParams.getCallActivityMap().put(callActivity.getId(), callActivity);
            }
        }
    }



    /**
     * 获取当前任务
     *
     * @param rollbackParams
     * @param bpmnModel
     * @param hisTask
     */
    private void getThisUserTask(RollbackParams rollbackParams, BpmnModel bpmnModel, HistoricTaskInstance hisTask) {

        FlowElement flowElement = bpmnModel.getMainProcess().getFlowElement(hisTask.getTaskDefinitionKey());
        if (null != flowElement && flowElement instanceof UserTask) {
            log.info("获取回退任务节点");
            rollbackParams.setCurrentTaskElement((UserTask) flowElement);
            return;
        }

        for (FlowElement item : bpmnModel.getMainProcess().getFlowElements()) {
            if (item instanceof SubProcess) {
                flowElement = ((SubProcess) item).getFlowElement(hisTask.getTaskDefinitionKey());
                if (null != flowElement) {
                    log.info("当前节点存在于嵌入式子流程");
                    rollbackParams.setCurrentTaskElement((UserTask) flowElement);
                    rollbackParams.setCurrentSubProcess((SubProcess) item);
                    return;
                }
            }
        }

        log.error("没有获取回退任务节点");

        // TODO  嵌入子流程 场景
    }
}
