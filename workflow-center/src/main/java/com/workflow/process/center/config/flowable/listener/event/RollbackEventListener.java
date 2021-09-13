package com.workflow.process.center.config.flowable.listener.event;

import com.workflow.process.center.service.cmd.rollback.strategy.DefaultNextGatewayRollbackOperateStrategy;
import com.workflow.process.center.service.cmd.rollback.strategy.NextCallActivityRollbackOperateStrategy;
import com.workflow.process.center.service.cmd.rollback.strategy.NextDefaultUserTaskRollbackOperateStrategy;
import com.workflow.process.center.service.cmd.rollback.strategy.NextSubProcessRollbackOperateStrategy;
import lombok.extern.slf4j.Slf4j;
import org.flowable.common.engine.api.delegate.event.FlowableEngineEventType;
import org.flowable.common.engine.api.delegate.event.FlowableEvent;
import org.flowable.common.engine.api.delegate.event.FlowableEventListener;
import org.flowable.common.engine.impl.event.FlowableEntityEventImpl;
import org.flowable.engine.RuntimeService;
import org.flowable.engine.TaskService;
import org.flowable.task.service.impl.persistence.entity.TaskEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import static com.workflow.process.center.common.contant.CommonContant.ASSIGNEE_PREFIX_KEY;
import static com.workflow.process.center.common.contant.CommonContant.TASK_TYPE_PREFIX_KEY;

@Component
@Slf4j
public class RollbackEventListener implements FlowableEventListener {

    @Autowired
    private RuntimeService runtimeService;

    @Autowired
    private   TaskService taskService;

    @Override
    public void onEvent(FlowableEvent event) {

        if (FlowableEngineEventType.TASK_CREATED.name().equals(event.getType().name())) {
            TaskEntity taskEntity = (TaskEntity) ((FlowableEntityEventImpl) event).getEntity();


            String key = ASSIGNEE_PREFIX_KEY + taskEntity.getProcessInstanceId() + taskEntity.getTaskDefinitionKey();
            String type = TASK_TYPE_PREFIX_KEY + taskEntity.getProcessInstanceId() + taskEntity.getTaskDefinitionKey();

            Object assigneeValue = runtimeService.getVariable(taskEntity.getExecutionId(), key);
            Object assigneeType = runtimeService.getVariable(taskEntity.getExecutionId(), type);
            if (assigneeValue != null && assigneeType != null) {
                log.info("回滚任务处理");
                if (
                        NextDefaultUserTaskRollbackOperateStrategy.class.getSimpleName().equals(assigneeType)
                                || NextSubProcessRollbackOperateStrategy.class.getSimpleName().equals(assigneeType)
                                || NextCallActivityRollbackOperateStrategy.class.getSimpleName().equals(assigneeType)
                                || DefaultNextGatewayRollbackOperateStrategy.class.getSimpleName().equals(assigneeType)
                ) {
                    log.info("设置普通任务执行人");
                    taskService.setAssignee(taskEntity.getId(), (String) assigneeValue);
                }
            }
        }
    }



    @Override
    public boolean isFailOnException() {
        return false;
    }


    //事务控制
    @Override
    public boolean isFireOnTransactionLifecycleEvent() {
        return false;
    }

    @Override
    public String getOnTransaction() {
        return null;
    }
}
