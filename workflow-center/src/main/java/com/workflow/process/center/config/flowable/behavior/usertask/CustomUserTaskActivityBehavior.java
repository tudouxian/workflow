package com.workflow.process.center.config.flowable.behavior.usertask;

import lombok.extern.slf4j.Slf4j;
import org.flowable.bpmn.model.UserTask;
import org.flowable.engine.delegate.DelegateExecution;
import org.flowable.engine.impl.bpmn.behavior.UserTaskActivityBehavior;

@Slf4j
public class CustomUserTaskActivityBehavior extends UserTaskActivityBehavior {
    public CustomUserTaskActivityBehavior(UserTask userTask) {
        super(userTask);
    }


    @Override
    public void execute(DelegateExecution execution) {
        log.info("这是自定义Behavior的输出：进入节点" + execution.getCurrentActivityId());
        super.execute(execution);
    }

    @Override
    public void trigger(DelegateExecution execution, String signalName, Object signalData) {
        log.info("这是自定义Behavior的输出：触发离开节点" + execution.getCurrentActivityId());
        super.trigger(execution, signalName, signalData);
    }
}
