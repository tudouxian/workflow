package com.workflow.process.center.config.flowable.listener.event;

import lombok.extern.slf4j.Slf4j;
import org.flowable.common.engine.api.delegate.event.FlowableEngineEntityEvent;
import org.flowable.engine.ProcessEngine;
import org.flowable.engine.delegate.event.AbstractFlowableEngineEventListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


/**
*   @Author: 土豆仙
*   @Date: 2021/8/9 17:17
*   @Description:
 *     create：在任务创建且所有任务属性设置完成之后才触发。
 *     assignment：在任务被分配给某个班里人之后触发，它是在create事件触发前被触发。
 *     complete：在配置了监听器的任务完成时触发，也就是说运行期任务删除之前触发。
 *     delete：任务删除触发
*/
@Component
@Slf4j
public class CreateTaskListener extends AbstractFlowableEngineEventListener {

    @Autowired
    private ProcessEngine processEngine;

    @Override
    protected void taskCreated(FlowableEngineEntityEvent event) {
/*
        if (FlowableEngineEventType.TASK_CREATED.name().equals(event.getType().name())) {
            // 当前节点任务实体
            TaskEntity taskEntity = (TaskEntity) ((FlowableEntityEventImpl) event).getEntity();

            //获取节点

            //判断节点是否用户任务节点

            //获取节点自定义属性

            //根据属性设置执行人

           // processEngine.getTaskService().setAssignee(taskEntity.getId(),"");
        }*/



    }

    //可以根据当前完成节点设置下个节点任务执行人
    protected void taskCompleted(FlowableEngineEntityEvent event) {
        /*if (FlowableEngineEventType.TASK_COMPLETED.name().equals(event.getType().name())) {
            // 当前节点任务实体
            TaskEntity taskEntity = (TaskEntity) ((FlowableEntityEventImpl) event).getEntity();

            //获取节点

            //判断节点是否用户任务节点

            //获取节点自定义属性

            //根据属性设置执行人

            processEngine.getTaskService().setAssignee(taskEntity.getId(),"");
        }*/
    }
}
