package com.workflow.process.center.config.flowable.listener.task.idm;

import org.flowable.task.service.delegate.DelegateTask;

public interface IdmCommonTaskListenerService {

    void setLastNodeAssignee(DelegateTask delegateTask);
}
