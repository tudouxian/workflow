package com.workflow.process.center.service;

import com.workflow.process.center.domain.mongo.MongoWorkFlowFormData;

import java.util.Map;

public interface WorkFlowFormDataService {

    MongoWorkFlowFormData getStartFormData(String processDefId);

    MongoWorkFlowFormData getTaskFormData(String taskId);

    MongoWorkFlowFormData getCompletedTaskFormData(String taskId);

}
