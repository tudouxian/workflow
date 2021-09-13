package com.workflow.process.center.service.impl;

import com.workflow.process.center.domain.mongo.MongoWorkFlowFormData;
import com.workflow.process.center.exception.BizException;
import com.workflow.process.center.service.WorkFlowFormDataService;
import lombok.extern.slf4j.Slf4j;
import org.flowable.engine.ProcessEngine;
import org.flowable.engine.form.StartFormData;
import org.flowable.engine.form.TaskFormData;
import org.flowable.task.api.history.HistoricTaskInstance;
import org.flowable.variable.api.history.HistoricVariableInstance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
*   @Author: 土豆仙
*   @Date: 2021/7/13 23:04
*   @Description: 自定义表单数据服务
*/
@Slf4j
@Service
public class WorkFlowFormDataServiceImpl implements WorkFlowFormDataService {

    @Autowired
    private ProcessEngine processEngine;

    @Override
    public MongoWorkFlowFormData getStartFormData(String processDefId) {
        StartFormData startFormData = processEngine.getFormService()
                .getStartFormData(processDefId);
        String formKey = startFormData.getFormKey();

        //根据formKey查询开始表单信息
        return null;
    }

    @Override
    public MongoWorkFlowFormData getTaskFormData(String taskId) {
        TaskFormData taskFormData = processEngine.getFormService().getTaskFormData(taskId);
        String formKey = taskFormData.getFormKey();

        //根据formKey查询当前任务表单信息
        return null;
    }

    @Override
    public MongoWorkFlowFormData getCompletedTaskFormData(String taskId) {
        HistoricTaskInstance historicTaskInstance = processEngine.getHistoryService()
                .createHistoricTaskInstanceQuery()
                .finished()
                .taskId(taskId)
                .singleResult();
        if (historicTaskInstance == null) {
            throw new BizException("任务ID查询不到对应完成的任务，请检查！");
        }

        //根据formKey查询当前任务表单信息-表单值信息
        String formKey = historicTaskInstance.getFormKey();

        //查询=》变量值=》表单值
        List<HistoricVariableInstance> variableInstances =
                processEngine.getHistoryService()
                        .createHistoricVariableInstanceQuery()
                        .taskId(taskId)
                        .list();


        return null;
    }

}
