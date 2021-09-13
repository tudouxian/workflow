package com.workflow.process.center.config.flowable.listener.task.idm;

import com.workflow.process.center.api.domain.WorkFlowAreaDTO;
import com.workflow.process.center.api.domain.WorkFlowDeptDTO;
import com.workflow.process.center.api.domain.WorkFlowUserDTO;
import com.workflow.process.center.exception.BizException;
import com.workflow.process.center.service.WorkFlowAreaService;
import com.workflow.process.center.service.WorkFlowDeptService;
import com.workflow.process.center.service.WorkFlowGroupService;
import com.workflow.process.center.service.WorkFlowUserService;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.flowable.bpmn.constants.BpmnXMLConstants;
import org.flowable.common.engine.api.delegate.Expression;
import org.flowable.common.engine.impl.el.FixedValue;
import org.flowable.engine.ProcessEngine;
import org.flowable.engine.delegate.TaskListener;
import org.flowable.task.api.history.HistoricTaskInstance;
import org.flowable.task.service.delegate.DelegateTask;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * @Author: 土豆仙
 * @Date: 2021/8/23 16:10
 * @Description: 默认系统监听器实现、设置发起人|指定节点上级（根据配置取级数）部门|区域
 */
@Component("idmAssignGroupByTaskListener")
public class IdmAssignGroupByTaskListener implements TaskListener {

    private static final String STARTUSER = "1";

    private static final String SPECIFIEDNODE = "2";

    private static final String DEPT = "dept";

    private static final String AREA = "area";

    @Autowired
    private ProcessEngine processEngine;

    @Autowired
    private WorkFlowUserService workFlowUserService;

    @Autowired
    private WorkFlowDeptService workFlowDeptService;

    @Autowired
    private WorkFlowAreaService workFlowAreaService;

    @Autowired
    private WorkFlowGroupService workFlowGroupService;


    //1.根据发起人  2.根据上个节点执行人
    private FixedValue assginType;

    //部门|区域  =>dept | area
    private Expression groupType;

    //具体节点
    private Expression specifiedNode;

    //传递方向 up|down
    private FixedValue direct;

    //传递步距
    private FixedValue stepSize;

    //传递异常|传递顶层、底层后处理策略
    private FixedValue strategy;


    @Override
    public void notify(DelegateTask delegateTask) {

        String assginTypeValue = (String) assginType.getValue(delegateTask);

        String groupTypeValue = (String) groupType.getValue(delegateTask);

        String directValue = (String) direct.getValue(delegateTask);

        Integer stepSizeValue = Integer.parseInt((String) stepSize.getValue(delegateTask));


        //根据启动用户推断执行组
        if (STARTUSER.equals(assginTypeValue)) {
            // 在这里执行自定义身份查询
            String userId = (String) delegateTask.getVariable(BpmnXMLConstants.ATTRIBUTE_EVENT_START_INITIATOR);
            if (StringUtils.isBlank(userId)) {
                throw new BizException("未配置开始节点执行人！");
            }
            //查询
            String groupKey = queryGroup(userId, groupTypeValue, directValue, stepSizeValue);

            //设置执行组
            delegateTask.addCandidateGroup(groupKey);

            //根据指定节点推断执行组
        } else if (SPECIFIEDNODE.equals(assginTypeValue)) {
            //获取指定节点Key
            String specifiedNodeValue = (String) specifiedNode.getValue(delegateTask);
            //流程实例ID
            String processInstanceId = delegateTask.getProcessInstanceId();

            List<HistoricTaskInstance> list = processEngine.getHistoryService().createHistoricTaskInstanceQuery()
                    .processInstanceId(processInstanceId)
                    .taskDefinitionKey(specifiedNodeValue)
                    .orderByHistoricTaskInstanceEndTime()
                    .desc()
                    .list();

            if (CollectionUtils.isNotEmpty(list)) {
                throw new BizException("监听器配置参数有误！参数中该节点无历史任务记录！");
            }
            //查询
            String groupKey = queryGroup(list.get(0).getAssignee(), groupTypeValue, directValue, stepSizeValue);

            //设置执行组
            delegateTask.addCandidateGroup(groupKey);
        } else {
            throw new BizException("监听器配置参数有误！无该配置类型！");
        }


        // 然后调用如下命令：
        //delegateTask.setAssignee("kermit");
        //delegateTask.addCandidateUser("fozzie");
        //delegateTask.addCandidateGroup("management");
    }

    private String queryGroup(String orginUserId, String groupType, String direct, Integer stepSize) {
        WorkFlowUserDTO workFlowUserDTO = workFlowUserService.selectUserByUserId(orginUserId);
        if (workFlowUserDTO != null) {
            //根据当前用户信息推断配置用户组
            if (DEPT.equals(groupType)) {
                WorkFlowDeptDTO workFlowDeptDTO = workFlowDeptService.queryUpDept(workFlowUserDTO.getDeptId(), stepSize);
                //TODO 除了指定部门或区域 要不要继承执行人的其他条件（角色、区域）
                String groupKey = workFlowGroupService.generatorGroupKey(null, workFlowDeptDTO.getDeptKey(), null);
                return groupKey;
            } else if (AREA.equals(groupType)) {
                WorkFlowAreaDTO workFlowAreaDTO = workFlowAreaService.queryUpArea(workFlowUserDTO.getAreaId(), stepSize);
                //TODO 除了指定部门或区域 要不要继承执行人的其他条件（角色、区域）
                String groupKey = workFlowGroupService.generatorGroupKey(workFlowAreaDTO.getAreaKey(), null, null);
                return groupKey;
            } else {
                throw new BizException("参数设置有误！不适配的类型参数！");
            }

        } else {
            throw new BizException("请检查用户服务是否可用或者流程监听器参数设置有误！");
        }

    }
}
