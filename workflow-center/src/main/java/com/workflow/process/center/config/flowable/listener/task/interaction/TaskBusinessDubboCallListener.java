package com.workflow.process.center.config.flowable.listener.task.interaction;

import lombok.extern.slf4j.Slf4j;
import org.flowable.common.engine.impl.el.FixedValue;
import org.flowable.engine.ProcessEngine;
import org.flowable.engine.delegate.TaskListener;
import org.flowable.engine.runtime.ProcessInstance;
import org.flowable.task.service.delegate.DelegateTask;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

@Component(value = "taskBusinessDubboCallListener")
@Slf4j
public class TaskBusinessDubboCallListener implements TaskListener {

    /**
     * dubbo的类名
     */
    private FixedValue clazzName;
    /**
     * 方法名
     */
    private FixedValue method;
    /**
     * 版本号
     */
    private FixedValue version;
    /**
     * 参数 多个的话用分号隔开 实例 userCode:00004737;status:1
     */
    private FixedValue params;

    @Autowired
    private ProcessEngine processEngine;

    @Override
    public void notify(DelegateTask delegateTask) {
        String processInstanceId = delegateTask.getProcessInstanceId();
        //执行回调
        this.callBack(processInstanceId,
                clazzName.getExpressionText(),
                method.getExpressionText(),
                version.getExpressionText(),
                params.getExpressionText());
    }

    public void callBack(String pocessInstanceId, String clazzName, String method,
                         String version, String params) {
        String paramsJson = null;
        try {
            Map<String, Object> paramMap = new HashMap<String, Object>();
            ProcessInstance processInstance = processEngine.getRuntimeService()
                    .createProcessInstanceQuery()
                    .processInstanceId(pocessInstanceId)
                    .singleResult();
            paramMap.put("businessKey", processInstance.getBusinessKey());

            log.info("开始调用业务系统接口" + clazzName + ",业务参数:" + paramsJson);
            //restTemplate.postForObject(restUrl, paramsJson, String.class);
        } catch (Exception e) {
            log.error("调用业务系统的方法失败", e);
        }
    }
}
