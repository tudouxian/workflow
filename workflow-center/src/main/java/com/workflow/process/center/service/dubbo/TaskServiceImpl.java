package com.workflow.process.center.service.dubbo;

import com.workflow.process.center.api.TaskService;
import com.workflow.process.center.domain.dto.FlowableNodeDTO;
import com.workflow.process.center.domain.dto.task.*;
import com.workflow.process.center.service.FlowableTaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

//@DubboService
@Component
public class TaskServiceImpl implements TaskService {

    @Autowired
    private FlowableTaskService flowableTaskService;


    @Override
    public void complete(CompleteTaskDTO completeTaskDTO) {
        flowableTaskService.complete(completeTaskDTO);
    }

    @Override
    public void stopProcessInstanceById(EndTaskDTO endTaskDTO) {

        flowableTaskService.stopProcessInstanceById(endTaskDTO);
    }

    @Override
    public void revokeProcess(RevokeTaskDTO revokeTaskDTO) {

        flowableTaskService.revokeProcess(revokeTaskDTO);
    }

    @Override
    public void turnTask(TurnTaskDTO turnTaskDTO) {
        flowableTaskService.turnTask(turnTaskDTO);
    }

    @Override
    public void delegateTask(DelegateTaskDTO delegateTaskDTO) {
        flowableTaskService.delegateTask(delegateTaskDTO);
    }

    @Override
    public void claimTask(ClaimTaskDTO claimTaskDTO) {

        flowableTaskService.claimTask(claimTaskDTO);
    }

    @Override
    public void unClaimTask(ClaimTaskDTO claimTaskDTO) {

        flowableTaskService.unClaimTask(claimTaskDTO);
    }

    @Override
    public void synergyTask(SynergyTaskDTO synergyTaskDTO) {
        flowableTaskService.synergyTask(synergyTaskDTO);
    }

    @Override
    public void beforeAddSignTask(AddSignTaskDTO addSignTaskDTO) {

        flowableTaskService.beforeAddSignTask(addSignTaskDTO);
    }

    @Override
    public void afterAddSignTask(AddSignTaskDTO addSignTaskDTO) {
        flowableTaskService.afterAddSignTask(addSignTaskDTO);
    }

    @Override
    public void backToStepTask(BackTaskDTO backTaskDTO) {

        flowableTaskService.backToStepTask(backTaskDTO);
    }

    @Override
    public List<FlowableNodeDTO> getBackNodesByProcessInstanceId(String processInstanceId, String taskId) {

        List<FlowableNodeDTO> backNodesByProcessInstanceId = flowableTaskService.getBackNodesByProcessInstanceId(processInstanceId, taskId);

        return backNodesByProcessInstanceId;
    }

    @Override
    public void rollback(RollbackTaskDTO rollbackTaskDTO) {

        flowableTaskService.rollback(rollbackTaskDTO);
    }

    @Override
    public void updateState(Integer state, String processInstanceId) {

        flowableTaskService.updateState(state, processInstanceId);
    }
}
