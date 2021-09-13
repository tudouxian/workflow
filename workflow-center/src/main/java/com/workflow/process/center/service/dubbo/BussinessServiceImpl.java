package com.workflow.process.center.service.dubbo;

import com.workflow.process.center.service.BussinessService;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

@Component
public class BussinessServiceImpl implements BussinessService {
    @Override
    public Map<String, Object> findByProcessInstanceId(String processInstanceId) {
        HashMap<String, Object> map = new HashMap<>();
        map.put("days", 3);
        return map;
    }
}
