package com.workflow.process.center.service;

import org.flowable.bpmn.model.*;
import org.flowable.bpmn.model.Process;

import java.util.List;

public interface FlowableBpmnModelService {

    /**
     * 获取模型
     *
     * @param processDefinitionId 流程定义id
     * @return
     */
    BpmnModel getBpmnModelByProcessDefId(String processDefinitionId);

    /**
     * 获取节点
     *@param bpmnModel 流程定义id
     * @param activityId 活动节点id
     * @return
     */
    Activity findActivityByBpmnModelAndId(BpmnModel bpmnModel, String activityId);

    /**
     * 获取节点
     *
     * @param activityId 节点id
     * @param bpmnModel  model
     * @return
     */
    FlowElement getFlowElementByActivityIdAndProcessDefinitionId(String activityId, BpmnModel bpmnModel);

    /**
     * 获取节点
     *
     * @param activityId          节点id
     * @param processDefinitionId 流程定义id
     * @return
     */
    FlowElement getFlowElementByActivityIdAndProcessDefinitionId(String activityId, String processDefinitionId);



    /**
     * 获取自定义单个属性值
     *
     * @param activityId          节点id
     * @param processDefinitionId 流程定义id
     * @param customPropertyName  属性名
     * @return
     */
    String getSingleCustomProperty(String activityId, String processDefinitionId, String customPropertyName);

    /**
     * 获取自定义单个属性值
     *
     * @param activityId         节点id
     * @param bpmnModel          模型
     * @param customPropertyName 属性名
     * @return
     */
    String getSingleCustomProperty(String activityId, BpmnModel bpmnModel, String customPropertyName);

    /**
     * 获取自定义属性值
     *
     * @param activityId          节点id
     * @param processDefinitionId 流程定义id
     * @param customPropertyName  属性名
     * @return
     */
    List<ExtensionElement> getCustomProperty(String activityId, String processDefinitionId, String customPropertyName);

    /**
     * 获取自定义属性值
     *
     * @param activityId         节点id
     * @param bpmnModel          模型
     * @param customPropertyName 属性名
     * @return
     */
    List<ExtensionElement> getCustomProperty(String activityId, BpmnModel bpmnModel, String customPropertyName);



    /**
     * 获取节点的坐标
     *
     * @param bpmnModel  bpmnModel
     * @param activityId 节点id
     * @return
     */
    GraphicInfo getGraphicInfo(BpmnModel bpmnModel, String activityId);

    /**
     * 获取UserTask 列表
     *
     * @param bpmnModel 流程bpmn
     * @return
     */
    List<UserTask> findUserTasksByBpmnModel(BpmnModel bpmnModel);

    /**
     * 获取UserTask 列表
     *
     * @param processDefId 流程定义id
     * @return
     */
    List<UserTask> findUserTasksByProcessDefId(String processDefId);

    /**
     * 获取end节点
     *
     * @param processDefinitionId 流程定义id
     * @return FlowElement
     */
    List<EndEvent> findEndFlowElement(String processDefinitionId);

    /**
     * 通过名称获取节点
     *
     * @param processDefinitionId 流程定义id
     * @param name         节点名称
     * @return
     */
    Activity findActivityByName(String processDefinitionId, String name);

    /**
     * 查找节点
     * @param processDefinitionId 流程定义id
     * @param activityId 节点id
     * @return
     */
    FlowNode findFlowNodeByActivityId(String processDefinitionId, String activityId);

    /**
     * 判断节点是不是子流程的节点
     * @param processDefId 流程定义id
     * @param activityId 节点id
     * @return
     */
    boolean checkActivitySubprocessByActivityId(String processDefId, String activityId);

    /**
     * 获取开始节点
     *
     * @param process 流程
     * @return FlowElement
     */
    StartEvent findStartFlowElement(Process process);
}
