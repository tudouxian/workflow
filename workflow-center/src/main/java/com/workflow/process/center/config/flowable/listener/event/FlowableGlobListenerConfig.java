package com.workflow.process.center.config.flowable.listener.event;

import com.workflow.process.center.config.flowable.listener.event.CreateTaskListener;
import com.workflow.process.center.config.flowable.listener.event.ProcistCompletedListener;
import com.workflow.process.center.config.flowable.listener.event.RollbackEventListener;
import org.flowable.common.engine.api.delegate.event.FlowableEngineEventType;
import org.flowable.common.engine.api.delegate.event.FlowableEventDispatcher;
import org.flowable.spring.SpringProcessEngineConfiguration;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.event.ContextRefreshedEvent;

/**
*   @Author: 土豆仙
*   @Date: 2021/7/12 15:34
*   @Description: flowable全局事件配置
*/
@Configuration
public class FlowableGlobListenerConfig   implements ApplicationListener<ContextRefreshedEvent> {
    @Autowired
    private SpringProcessEngineConfiguration configuration;

    //流程实例事件
    @Autowired
    private ProcistCompletedListener procistCompletedListener;

    @Autowired
    private RollbackEventListener rollbackEventListener;

    @Autowired
    private CreateTaskListener createTaskListener;

    @Override
    public void onApplicationEvent(ContextRefreshedEvent contextRefreshedEvent) {
        FlowableEventDispatcher dispatcher = configuration.getEventDispatcher();
        //添加流程实例创建全局监听
       // dispatcher.addEventListener(procistStartListener, FlowableEngineEventType.PROCESS_STARTED);
        //添加流程实例结束全局监听
        dispatcher.addEventListener(procistCompletedListener, FlowableEngineEventType.PROCESS_COMPLETED);

        //任务创建监听器
        dispatcher.addEventListener(rollbackEventListener, FlowableEngineEventType.TASK_CREATED);

        dispatcher.addEventListener(createTaskListener, FlowableEngineEventType.TASK_CREATED);

        dispatcher.addEventListener(createTaskListener, FlowableEngineEventType.TASK_COMPLETED);


    }
}
