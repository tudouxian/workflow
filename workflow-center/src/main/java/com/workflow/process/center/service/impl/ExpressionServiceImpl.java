package com.workflow.process.center.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.workflow.process.center.exception.BizException;
import com.workflow.process.center.service.ExpressionService;
import com.fasterxml.jackson.databind.node.ObjectNode;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.MapUtils;
import org.flowable.common.engine.api.delegate.Expression;
import org.flowable.common.engine.impl.de.odysseus.el.ExpressionFactoryImpl;
import org.flowable.common.engine.impl.de.odysseus.el.misc.TypeConverter;
import org.flowable.common.engine.impl.de.odysseus.el.util.SimpleContext;
import org.flowable.common.engine.impl.el.ExpressionManager;
import org.flowable.common.engine.impl.javax.el.ExpressionFactory;
import org.flowable.common.engine.impl.javax.el.PropertyNotFoundException;
import org.flowable.common.engine.impl.javax.el.ValueExpression;
import org.flowable.engine.ManagementService;
import org.flowable.engine.RuntimeService;
import org.flowable.engine.impl.cfg.ProcessEngineConfigurationImpl;
import org.flowable.engine.impl.persistence.entity.ExecutionEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Slf4j
public class ExpressionServiceImpl  implements ExpressionService {

    @Autowired
    protected ProcessEngineConfigurationImpl processEngineConfiguration;
    @Autowired
    private RuntimeService runtimeService;
    @Autowired
    private TypeConverter typeConverter;
    @Autowired
    private ManagementService managementService;


    @Override
    public Object getValue(String processInstanceId, String exp) {
        Expression expression = processEngineConfiguration.getExpressionManager().createExpression(exp);
        ExecutionEntity executionEntity = (ExecutionEntity) runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).includeProcessVariables().singleResult();
        return managementService.executeCommand(commandContext -> expression.getValue(executionEntity));
    }

    @Override
    public <T> T getValue(String processInstanceId, String exp, Class<T> clazz) {
        Object value = this.getValue(processInstanceId, exp);
        return typeConverter.convert(value, clazz);
    }

    @Override
    public String getStrValue(String processInstanceId, String exp) {
        return getValue(processInstanceId, exp, String.class);
    }

    /**
     * 批量获取表达式的值
     *
     * @param processInstanceId 流程实例id
     * @param exps              表达式列表
     * @return
     */
    public Map<String, String> getStrValues(String processInstanceId, List<String> exps) {
        ExpressionManager expressionManager = processEngineConfiguration.getExpressionManager();
        ExecutionEntity executionEntity = (ExecutionEntity) runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).includeProcessVariables().singleResult();
        Map<String, String> datas = new HashMap<>();
        exps.forEach(exp -> {
            Expression expression = expressionManager.createExpression(exp);
            Object value = managementService.executeCommand(commandContext -> expression.getValue(executionEntity));
            String convert = typeConverter.convert(value, String.class);
            datas.put(exp, convert);
        });
        return datas;
    }

    /**
     * 原生的解析表达式
     *
     * @param params 变量的值
     * @param exp    表达式
     * @param clazz  映射出来的值
     * @return
     */
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
            log.error("流程变量的属性找不到，请确认!", e);
            throw new BizException("流程变量的属性找不到，请确认!");
        }
        return typeConverter.convert(returnObj, clazz);
    }

    public String getStrValue(Map<String, Object> params, String exp) {
        String value = "";
        try {
            value = getValue(params, exp, String.class);
        } catch (PropertyNotFoundException e) {
        }
        return value;
    }

    public Boolean getBooleanValue(Map<String, Object> params, String exp, boolean flag) {
        Boolean value = false;
        try {
            value = getValue(params, exp, Boolean.class);
        } catch (PropertyNotFoundException e) {
            if (flag) {
                value = true;
            }
        }
        return value;
    }
}
