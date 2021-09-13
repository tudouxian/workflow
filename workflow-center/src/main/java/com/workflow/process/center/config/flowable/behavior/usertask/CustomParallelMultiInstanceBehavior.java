package com.workflow.process.center.config.flowable.behavior.usertask;

import org.flowable.bpmn.model.Activity;
import org.flowable.engine.impl.bpmn.behavior.AbstractBpmnActivityBehavior;
import org.flowable.engine.impl.bpmn.behavior.ParallelMultiInstanceBehavior;

public class CustomParallelMultiInstanceBehavior extends ParallelMultiInstanceBehavior {
    public CustomParallelMultiInstanceBehavior(Activity activity, AbstractBpmnActivityBehavior originalActivityBehavior) {
        super(activity, originalActivityBehavior);
    }
}
