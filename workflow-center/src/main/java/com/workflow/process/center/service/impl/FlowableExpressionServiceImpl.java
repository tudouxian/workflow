package com.workflow.process.center.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.workflow.process.center.exception.BizException;
import com.workflow.process.center.service.FlowableExpressionService;
import com.fasterxml.jackson.databind.node.ObjectNode;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.MapUtils;
import org.flowable.common.engine.api.delegate.Expression;
import org.flowable.common.engine.impl.de.odysseus.el.ExpressionFactoryImpl;
import org.flowable.common.engine.impl.de.odysseus.el.misc.TypeConverter;
import org.flowable.common.engine.impl.de.odysseus.el.util.SimpleContext;
import org.flowable.common.engine.impl.javax.el.ExpressionFactory;
import org.flowable.common.engine.impl.javax.el.PropertyNotFoundException;
import org.flowable.common.engine.impl.javax.el.ValueExpression;
import org.flowable.engine.ManagementService;
import org.flowable.engine.ProcessEngine;
import org.flowable.engine.impl.cfg.ProcessEngineConfigurationImpl;
import org.flowable.engine.impl.persistence.entity.ExecutionEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@Service
public class FlowableExpressionServiceImpl implements FlowableExpressionService {
    @Autowired
    protected ProcessEngineConfigurationImpl processEngineConfiguration;

    @Autowired
    private TypeConverter typeConverter;

    @Autowired
    private ProcessEngine processEngine;

    @Autowired
    private ManagementService managementService;

    @Override
    public String getStrValue(String processInstanceId, String assignee) {
        return getValue(processInstanceId, assignee, String.class);
    }

    @Override
    public <T> T getValue(String processInstanceId, String exp, Class<T> clazz) {
        Object value = this.getValue(processInstanceId, exp);
        return typeConverter.convert(value, clazz);
    }

    @Override
    public <T> T getValue(Map<String, Object> params, String exp, Class<T> clazz) {
        ExpressionFactory factory = new ExpressionFactoryImpl();
        SimpleContext context = new SimpleContext();
        if (MapUtils.isNotEmpty(params)) {
            params.forEach((k, v) -> {
                if (v instanceof ObjectNode) {
                    JSONObject jsonObject = JSONObject.parseObject(v.toString());
                    Map<String, Object> vs = new HashMap<>();
                    for (String objkey : jsonObject.keySet()) {
                        vs.put(objkey, jsonObject.get(objkey));
                    }
                    context.setVariable(k, factory.createValueExpression(vs, Map.class));
                } else {
                    context.setVariable(k, factory.createValueExpression(v, Object.class));
                }
            });
        }
        Object returnObj = null;
        try {
            ValueExpression e = factory.createValueExpression(context, exp, clazz);
            returnObj = e.getValue(context);
        } catch (PropertyNotFoundException e) {
            e.printStackTrace();
            throw new BizException("流程变量的属性找不到，请确认!");
        }
        return typeConverter.convert(returnObj, clazz);
    }

    @Override
    public Object getValue(String processInstanceId, String exp) {
        Expression expression = processEngineConfiguration.getExpressionManager().createExpression(exp);
        ExecutionEntity executionEntity = (ExecutionEntity) processEngine.getRuntimeService()
                .createProcessInstanceQuery()
                .processInstanceId(processInstanceId).includeProcessVariables()
                .singleResult();
        return managementService.executeCommand(commandContext -> expression.getValue(executionEntity));
    }
}
