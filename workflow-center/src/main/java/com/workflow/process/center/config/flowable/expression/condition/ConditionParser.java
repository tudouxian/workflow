package com.workflow.process.center.config.flowable.expression.condition;

import com.workflow.process.center.service.BussinessService;
import lombok.extern.slf4j.Slf4j;
import org.flowable.common.engine.impl.el.VariableContainerWrapper;
import org.flowable.engine.ManagementService;
import org.flowable.engine.delegate.DelegateExecution;
import org.flowable.engine.impl.cfg.ProcessEngineConfigurationImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Map;

/**
*   @Author: 土豆仙
*   @Date: 2021/7/28 21:17
*   @Description: 自定义表达式解析器解析自定义表单变量
 *   <![CDATA[${conditionParser.parser("${condition != hetao}",execution)}]]>
*/
@Component
@Slf4j
public class ConditionParser {

    @Autowired
    private ManagementService managementService;

    @Autowired
    private ProcessEngineConfigurationImpl processEngineConfiguration;

    @Autowired
    private BussinessService bussinessService;


    /**
     * @param expression 表达式
     * @param execution 内置变量
     * @return
     */
    public Boolean parser(String expression, DelegateExecution execution){
        log.info("条件表达式：【{}】  流程实例ID：【{}】",expression,execution.getProcessInstanceId());
        //获取实例关联表单数据
        Map<String,Object> data = bussinessService.findByProcessInstanceId(execution.getProcessInstanceId());
        //集合流程变量
        data.putAll(execution.getVariables());
        //获取表达式结果
        Object value = processEngineConfiguration.getExpressionManager()
                .createExpression(expression)
                .getValue(new VariableContainerWrapper(data));
        log.info("条件表达式结果：【{}】",value);
        return Boolean.parseBoolean(String.valueOf(value));
    }

}
