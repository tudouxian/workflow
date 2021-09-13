package com.workflow.process.center.service.impl;

import com.workflow.process.center.config.flowable.cache.CustomDeploymentCache;
import com.workflow.process.center.service.FlowableBpmnModelService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.collections4.MapUtils;
import org.apache.commons.lang3.StringUtils;
import org.flowable.bpmn.model.*;
import org.flowable.bpmn.model.Process;
import org.flowable.engine.ProcessEngine;
import org.flowable.engine.impl.persistence.deploy.ProcessDefinitionCacheEntry;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
public class FlowableBpmnModelServiceImpl implements FlowableBpmnModelService {

    @Autowired
    private CustomDeploymentCache customDeploymentCache;

    @Autowired
    private ProcessEngine processEngine;

    @Override
    public BpmnModel getBpmnModelByProcessDefId(String processDefinitionId) {
        BpmnModel bpmnModel = null;
        if (customDeploymentCache.contains(processDefinitionId)) {
            ProcessDefinitionCacheEntry processDefinitionCacheEntry = customDeploymentCache.get(processDefinitionId);
            if (processDefinitionCacheEntry != null) {
                bpmnModel = processDefinitionCacheEntry.getBpmnModel();
            }
        } else {
            bpmnModel = processEngine.getRepositoryService()
                    .getBpmnModel(processDefinitionId);
        }
        return bpmnModel;
    }

    @Override
    public Activity findActivityByBpmnModelAndId(BpmnModel bpmnModel, String activityId) {
        Activity activity = null;
        Process process = bpmnModel.getMainProcess();
        Collection<FlowElement> list = process.getFlowElements();
        for (FlowElement f : list) {
            if (StringUtils.isNotBlank(activityId)) {
                if (activityId.equals(f.getId())) {
                    activity = (Activity) f;
                    break;
                }
            }
        }
        return activity;
    }

    @Override
    public String getSingleCustomProperty(String activityId, BpmnModel bpmnModel, String customPropertyName) {
        List<ExtensionElement> customProperty = this.getCustomProperty(activityId, bpmnModel, customPropertyName);
        return getSingleCustomPropertyValue(customProperty);
    }

    @Override
    public List<ExtensionElement> getCustomProperty(String activityId, String processDefinitionId, String customPropertyName) {
        FlowElement flowElement = this.getFlowElementByActivityIdAndProcessDefinitionId(activityId, processDefinitionId);
        return getExtensionElements(flowElement, customPropertyName);
    }

    private String getSingleCustomPropertyValue(List<ExtensionElement> customProperty) {
        String value = null;
        if (CollectionUtils.isNotEmpty(customProperty)) {
            ExtensionElement extensionElement = customProperty.get(0);
            if (extensionElement != null) {
                value = extensionElement.getElementText();
            }
        }
        return value;
    }

    @Override
    public List<ExtensionElement> getCustomProperty(String activityId, BpmnModel bpmnModel, String customPropertyName) {
        FlowElement flowElement = this.getFlowElementByActivityIdAndProcessDefinitionId(activityId, bpmnModel);
        return getExtensionElements(flowElement, customPropertyName);
    }

    @Override
    public GraphicInfo getGraphicInfo(BpmnModel bpmnModel, String activityId) {
        return bpmnModel.getGraphicInfo(activityId);
    }

    @Override
    public List<UserTask> findUserTasksByBpmnModel(BpmnModel bpmnModel) {
        List<UserTask> datas = new ArrayList<>();
        List<Process> processes = bpmnModel.getProcesses();
        processes.forEach(process -> {
            List<UserTask> userTasks = process.findFlowElementsOfType(UserTask.class);
            datas.addAll(userTasks);
        });
        return datas;
    }

    @Override
    public List<UserTask> findUserTasksByProcessDefId(String processDefId) {
        BpmnModel bpmnModel = this.getBpmnModelByProcessDefId(processDefId);
        return findUserTasksByBpmnModel(bpmnModel);
    }

    @Override
    public List<EndEvent> findEndFlowElement(String processDefinitionId) {
        BpmnModel bpmnModel = this.getBpmnModelByProcessDefId(processDefinitionId);
        if (bpmnModel != null) {
            Process process = bpmnModel.getMainProcess();
            return process.findFlowElementsOfType(EndEvent.class);
        } else {
            return null;
        }
    }

    @Override
    public Activity findActivityByName(String processDefinitionId, String name) {
        Activity activity = null;
        BpmnModel bpmnModel = this.getBpmnModelByProcessDefId(processDefinitionId);
        Process process = bpmnModel.getMainProcess();
        Collection<FlowElement> list = process.getFlowElements();
        for (FlowElement f : list) {
            if (StringUtils.isNotBlank(name)) {
                if (name.equals(f.getName())) {
                    activity = (Activity) f;
                    break;
                }
            }
        }
        return activity;
    }

    @Override
    public FlowNode findFlowNodeByActivityId(String processDefinitionId, String activityId) {
        FlowNode activity = null;
        BpmnModel bpmnModel = this.getBpmnModelByProcessDefId(processDefinitionId);
        List<Process> processes = bpmnModel.getProcesses();
        for (Process process : processes){
            FlowElement flowElement = process.getFlowElementMap().get(activityId);
            if (flowElement != null) {
                activity = (FlowNode) flowElement;
                break;
            }
        }
        return activity;
    }

    @Override
    public boolean checkActivitySubprocessByActivityId(String processDefId, String activityId) {

        List<FlowNode> activities = findFlowNodesByActivityId(processDefId,activityId);
        return CollectionUtils.isNotEmpty(activities);
    }

    @Override
    public StartEvent findStartFlowElement(Process process) {
        List<StartEvent> startEvents = process.findFlowElementsOfType(StartEvent.class);
        if (CollectionUtils.isNotEmpty(startEvents)) {
            return startEvents.get(0);
        }
        return null;
    }

    private List<FlowNode> findFlowNodesByActivityId(String processDefId, String activityId) {
        List<FlowNode> activities = new ArrayList<>();
        BpmnModel bpmnModel = this.getBpmnModelByProcessDefId(processDefId);
        List<Process> processes = bpmnModel.getProcesses();
        for (Process process : processes) {
            FlowElement flowElement = process.getFlowElement(activityId);
            if (flowElement != null) {
                FlowNode flowNode = (FlowNode) flowElement;
                activities.add(flowNode);
            }
        }
        return activities;
    }


    private List<ExtensionElement> getExtensionElements(FlowElement flowElement, String customPropertyName) {
        if (flowElement != null && flowElement instanceof UserTask) {
            UserTask userTask = (UserTask) flowElement;
            Map<String, List<ExtensionElement>> extensionElements = userTask.getExtensionElements();
            if (MapUtils.isNotEmpty(extensionElements)) {
                List<ExtensionElement> values = extensionElements.get(customPropertyName);
                if (CollectionUtils.isNotEmpty(values)) {
                    return values;
                }
            }
        }
        return null;
    }

    /**
     * 获取节点
     *
     * @param activityId          节点id
     * @param processDefinitionId 流程定义id
     * @return
     */
    @Override
    public FlowElement getFlowElementByActivityIdAndProcessDefinitionId(String activityId, String processDefinitionId) {
        BpmnModel bpmnModel = this.getBpmnModelByProcessDefId(processDefinitionId);
        return getFlowElementByActivityIdAndProcessDefinitionId(activityId, bpmnModel);
    }

    @Override
    public String getSingleCustomProperty(String activityId, String processDefinitionId, String customPropertyName) {
        List<ExtensionElement> customProperty = this.getCustomProperty(activityId, processDefinitionId, customPropertyName);
        return getSingleCustomPropertyValue(customProperty);
    }

    @Override
    public FlowElement getFlowElementByActivityIdAndProcessDefinitionId(String activityId, BpmnModel bpmnModel) {
        if (bpmnModel != null) {
            List<Process> processes = bpmnModel.getProcesses();
            if (CollectionUtils.isNotEmpty(processes)) {
                for (Process process : processes) {
                    FlowElement flowElement = process.getFlowElement(activityId);
                    if (flowElement != null) {
                        return flowElement;
                    }
                }
            }
        }

        return null;
    }
}
