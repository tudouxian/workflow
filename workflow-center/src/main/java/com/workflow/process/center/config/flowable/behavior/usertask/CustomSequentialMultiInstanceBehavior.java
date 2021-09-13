package com.workflow.process.center.config.flowable.behavior.usertask;

import org.flowable.bpmn.model.Activity;
import org.flowable.engine.impl.bpmn.behavior.AbstractBpmnActivityBehavior;
import org.flowable.engine.impl.bpmn.behavior.SequentialMultiInstanceBehavior;

public class CustomSequentialMultiInstanceBehavior extends SequentialMultiInstanceBehavior {
    public CustomSequentialMultiInstanceBehavior(Activity activity, AbstractBpmnActivityBehavior innerActivityBehavior) {
        super(activity, innerActivityBehavior);
    }
}
