package com.workflow.process.center.service;

import java.util.Map;

public interface BussinessService {

    Map<String, Object> findByProcessInstanceId(String processInstanceId);
}
