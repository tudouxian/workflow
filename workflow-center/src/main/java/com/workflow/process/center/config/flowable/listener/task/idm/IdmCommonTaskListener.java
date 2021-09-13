package com.workflow.process.center.config.flowable.listener.task.idm;

import org.apache.commons.collections4.CollectionUtils;
import org.flowable.engine.ProcessEngine;
import org.flowable.task.api.history.HistoricTaskInstance;
import org.flowable.task.service.delegate.DelegateTask;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component("idmCommonTaskListener")
public class IdmCommonTaskListener implements IdmCommonTaskListenerService {

    @Autowired
    private ProcessEngine processEngine;

    //设置为最后一个任务完成人=》设置当前任务执行人
    public void setLastNodeAssignee(DelegateTask delegateTask) {

        List<HistoricTaskInstance> list = processEngine.getHistoryService()
                .createHistoricTaskInstanceQuery()
                .processInstanceId(delegateTask.getProcessInstanceId())
                .orderByHistoricTaskInstanceEndTime()
                .desc()
                .list();

        if (CollectionUtils.isNotEmpty(list)) {
            String userNo = list.get(0).getAssignee();
            delegateTask.setAssignee(userNo);
        }

    }
}
