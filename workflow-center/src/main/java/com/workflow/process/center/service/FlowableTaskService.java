package com.workflow.process.center.service;

import com.workflow.process.center.common.enums.entity.ButtonTypeEnum;
import com.workflow.process.center.domain.dto.task.*;
import com.workflow.process.center.domain.entity.WorkFlowButton;
import com.workflow.process.center.domain.dto.FlowableNodeDTO;

import java.util.List;

public interface FlowableTaskService {

    void complete(CompleteTaskDTO params);

    void stopProcessInstanceById(EndTaskDTO params);

    void revokeProcess(RevokeTaskDTO params);

    void turnTask(TurnTaskDTO params);

    void delegateTask(DelegateTaskDTO params);

    void claimTask(ClaimTaskDTO params);

    void unClaimTask(ClaimTaskDTO params);

    void synergyTask(SynergyTaskDTO params);

    void beforeAddSignTask(AddSignTaskDTO params);

    void afterAddSignTask(AddSignTaskDTO params);

    List<WorkFlowButton> findButtonsByTaskId(String taskId, ButtonTypeEnum buttonTypeEnum);

    List<FlowableNodeDTO> getBackNodesByProcessInstanceId(String processInstanceId, String taskId);

    void backToStepTask(BackTaskDTO params);

    byte[] createImage(String processInstanceId);

    void rollback(RollbackTaskDTO params);

    void updateState(Integer state, String processInstanceId);

    void updateTaskCandidateGroup(UpdateCandidateTaskDTO params);

    void addTaskCandidateGroup(UpdateCandidateTaskDTO params);
}
