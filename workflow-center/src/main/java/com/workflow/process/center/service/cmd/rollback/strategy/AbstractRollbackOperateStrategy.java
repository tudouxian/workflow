package com.workflow.process.center.service.cmd.rollback.strategy;

import com.workflow.common.utils.spring.SpringUtils;
import com.workflow.process.center.exception.BizException;
import com.workflow.process.center.mapper.FlowableExtensionMapper;
import com.workflow.process.center.service.cmd.rollback.RollbackOperateStrategy;
import com.workflow.process.center.service.cmd.rollback.RollbackParams;
import lombok.extern.slf4j.Slf4j;
import org.flowable.common.engine.impl.interceptor.CommandContext;
import org.flowable.engine.RuntimeService;
import org.flowable.engine.impl.ActivityInstanceQueryImpl;
import org.flowable.engine.impl.persistence.entity.ExecutionEntity;
import org.flowable.engine.impl.util.CommandContextUtil;
import org.flowable.engine.runtime.ActivityInstance;
import org.flowable.task.api.history.HistoricTaskInstance;
import org.flowable.task.service.impl.HistoricTaskInstanceQueryImpl;
import org.flowable.task.service.impl.persistence.entity.HistoricTaskInstanceEntity;
import org.flowable.task.service.impl.persistence.entity.TaskEntity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.workflow.process.center.common.contant.CommonContant.ASSIGNEE_PREFIX_KEY;

/**
 * @Author: 土豆仙
 * @Date: 2021/7/16 19:45
 * @Description: 回撤操作抽象类
 */
@Slf4j
public abstract class AbstractRollbackOperateStrategy implements RollbackOperateStrategy {

    //命令上下文
    protected CommandContext commandContext;

    //运行时服务
    protected RuntimeService runtimeService;

    //回退参数
    protected RollbackParams rollbackParams;

    //任务办理人ID
    protected String assignee;

    //参数
    protected Map<String, Object> variables;

    //扩展
    protected FlowableExtensionMapper flowableExtensionMapper;

    public AbstractRollbackOperateStrategy(RollbackParams rollbackParams) {
        this.rollbackParams = rollbackParams;
        this.flowableExtensionMapper = SpringUtils.getBean(FlowableExtensionMapper.class);
        this.runtimeService = SpringUtils.getBean(RuntimeService.class);
    }

    @Override
    public void process(CommandContext commandContext, String assignee) {
        process(commandContext, assignee, new HashMap<>());
    }

    @Override
    public void process(CommandContext commandContext, String assignee, Map<String, Object> variables) {

        this.commandContext = commandContext;
        this.assignee = assignee;
        this.variables = variables;

        log.info("处理 existNextFinishedTask");
        existNextFinishedTask();
        log.info("配置任务执行人 setAssignee");
        setAssignee();
        log.info("处理 createExecution");
        createExecution();
        log.info("处理 deleteRuntimeTasks");
        deleteRuntimeTasks();
        log.info("处理 deleteHisActInstance");
        deleteHisActInstance();
    }

    /**
     * 获取 当前执行 execution
     *
     * @return
     */
    protected ExecutionEntity getExecutionEntity() {

        ExecutionEntity executionEntity = CommandContextUtil.getExecutionEntityManager(commandContext)
                .findById(rollbackParams.getHisTask().getExecutionId());

        if (null == executionEntity) {

            log.info("没找到回退任务的 execution,从同级任务处获取");
            List<ExecutionEntity> executionEntityList = CommandContextUtil
                    .getExecutionEntityManager(commandContext)
                    .findExecutionsByParentExecutionAndActivityIds(rollbackParams.getHisTask().getProcessInstanceId(), rollbackParams.getNextFlowIdList());
            if (executionEntityList.isEmpty()) {
                throw new BizException("没有找到临近节点");
            }
            executionEntity = executionEntityList.get(0);
        }

        return executionEntity;
    }

    protected void removeHisTask(HistoricTaskInstance hisTask) {
        // 移除历史任务列表
        log.info("移除历史任务 [ id = " + hisTask.getId() + " ]");
        CommandContextUtil.getHistoricTaskService().deleteHistoricTask((HistoricTaskInstanceEntity) hisTask);
    }

    /**
     * 移除 ru_ 相关数据
     *
     * @param obj
     */
    protected void removeRuntimeTaskOperate(TaskEntity obj) {
        log.debug("移除 IdentityLink: " + obj.getId());
        CommandContextUtil.getIdentityLinkService(commandContext).deleteIdentityLinksByTaskId(obj.getId());
        log.debug("移除 Variable: " + obj.getId());
        CommandContextUtil.getVariableService(commandContext).deleteVariablesByExecutionId(obj.getExecutionId());
        log.debug("移除 Task: " + obj.getId());
        CommandContextUtil.getTaskService(commandContext).deleteTasksByExecutionId(obj.getExecutionId());
        log.debug("移除 execution: " + obj.getExecutionId());
        CommandContextUtil.getExecutionEntityManager(commandContext).delete(obj.getExecutionId());
    }


    protected void createExecution(ExecutionEntity newExecution) {
        newExecution.setActive(true);
        // 测试设置变量
        newExecution.setVariablesLocal(variables);
        newExecution.setCurrentFlowElement(rollbackParams.getCurrentTaskElement());

        // 创建新任务
        log.debug("创建新任务");
        CommandContextUtil.getAgenda(commandContext).planContinueProcessInCompensation(newExecution);
    }

    @Override
    public void existNextFinishedTask() {
        HistoricTaskInstance hisTask = rollbackParams.getHisTask();

        List<HistoricTaskInstance> hisTaskList = CommandContextUtil.getHistoricTaskService().findHistoricTaskInstancesByQueryCriteria(
                (HistoricTaskInstanceQueryImpl) new HistoricTaskInstanceQueryImpl()
                        .processInstanceId(hisTask.getProcessInstanceId())
                        .taskCompletedAfter(hisTask.getEndTime())
        );

        if (!hisTaskList.isEmpty()) {
            hisTaskList.forEach(obj -> {
                if (rollbackParams.getNextFlowIdList().contains(obj.getTaskDefinitionKey())) {
                    String msg = "存在已完成下一节点任务";
                    throw new BizException(msg);
                }
            });
        }
    }

    @Override
    public void deleteHisActInstance() {

        List<ActivityInstance> activityInstanceEntityList = CommandContextUtil.getActivityInstanceEntityManager(commandContext)
                .findActivityInstancesByQueryCriteria(
                        new ActivityInstanceQueryImpl()
                                .processInstanceId(rollbackParams.getHisTask().getProcessInstanceId())
                );


        List<String> ids = new ArrayList<>();
        activityInstanceEntityList.forEach(obj -> {
            // 时间大于 任务创建时间 之后线条
            if (obj.getStartTime().getTime() > rollbackParams.getHisTask().getCreateTime().getTime()
                    && rollbackParams.getNextFlowIdList().contains(obj.getActivityId())) {
                ids.add(obj.getId());
            }
            // 当前任务的连线 ID
            if (rollbackParams.getHisTask().getTaskDefinitionKey().equals(obj.getActivityId())
                    && obj.getEndTime().getTime() > rollbackParams.getHisTask().getCreateTime().getTime()
            ) {
                ids.add(obj.getId());
            }
        });

        // 移除当前任务连线
//        LOGGER.debug("移除当前任务连线");
//        ids.forEach(obj -> CommandContextUtil.getActivityInstanceEntityManager(commandContext).delete(obj));
        // 移除历史任务连线
        // 历史任务删除失败，改用自己写mapper 完成删除功能
//        ids.forEach(obj -> CommandContextUtil.getHistoricActivityInstanceEntityManager(commandContext).delete(obj));
        log.debug("移除历史任务连线");
        ids.forEach(id -> flowableExtensionMapper.deleteHistoryActivityInstance(id));

    }

    @Override
    public void deleteRuntimeTasks() {
        HistoricTaskInstance hisTask = rollbackParams.getHisTask();

        List<TaskEntity> taskEntityList = CommandContextUtil.getTaskService(commandContext).findTasksByProcessInstanceId(hisTask.getProcessInstanceId());
        taskEntityList.forEach(obj -> {
            if (rollbackParams.getNextFlowIdList().contains(obj.getTaskDefinitionKey())) {
                log.info("移除正在执行的下一节点任务");
                // 移除任务
                removeRuntimeTaskOperate(obj);
            }
        });


        // 移除历史任务信息
        List<HistoricTaskInstanceEntity> historicTaskInstanceList = CommandContextUtil.getHistoricTaskService(commandContext)
                .findHistoricTasksByProcessInstanceId(hisTask.getProcessInstanceId());
        historicTaskInstanceList.forEach(obj -> {
            if (rollbackParams.getNextFlowIdList().contains(obj.getTaskDefinitionKey())) {
                CommandContextUtil.getHistoricTaskService(commandContext).deleteHistoricTask(obj);
            }
        });
    }

    @Override
    public void setAssignee() {
        HistoricTaskInstance hisTask = rollbackParams.getHisTask();
        String key = ASSIGNEE_PREFIX_KEY + hisTask.getProcessInstanceId() + hisTask.getTaskDefinitionKey();
        variables.put(key, assignee);
    }

    @Override
    public void setAssigneeExpr(String assigneeExpr, String assigneeListExpr) {
        // to override
    }

}
