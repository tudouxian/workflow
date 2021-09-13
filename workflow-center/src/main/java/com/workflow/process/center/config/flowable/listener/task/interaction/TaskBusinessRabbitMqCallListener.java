package com.workflow.process.center.config.flowable.listener.task.interaction;

import lombok.extern.slf4j.Slf4j;
import org.flowable.engine.ProcessEngine;
import org.flowable.engine.delegate.TaskListener;
import org.flowable.task.service.delegate.DelegateTask;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component(value = "taskBusinessRabbitMqCallListener")
@Slf4j
public class TaskBusinessRabbitMqCallListener implements TaskListener {

    @Autowired
    private ProcessEngine processEngine;

    @Override
    public void notify(DelegateTask delegateTask) {
    }
}
