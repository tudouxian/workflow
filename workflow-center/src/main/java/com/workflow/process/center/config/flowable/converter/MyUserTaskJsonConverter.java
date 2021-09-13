package com.workflow.process.center.config.flowable.converter;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.apache.commons.lang3.StringUtils;
import org.flowable.bpmn.model.*;
import org.flowable.editor.language.json.converter.BaseBpmnJsonConverter;
import org.flowable.editor.language.json.converter.BpmnJsonConverterContext;
import org.flowable.editor.language.json.converter.UserTaskJsonConverter;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author: 土豆仙
 * @Date: 2021/6/27 0:33
 * @Description: 扩展任务节点属性解析器 =》TODO
 */
public class MyUserTaskJsonConverter extends UserTaskJsonConverter {

    //表单数据
    private static final String FORM_DATA = "formData";
    //配置方式=》固定值|身份存储
    private static final String ASSIGNEE_TYPE = "assigneeType";
    //配置方式=》身份存储|存储名字
    private static final String ASSIGNEE_NAME = "assigneeName";
    //配置方式=》身份存储|分配流程发起人（特殊变量）
    private static final String ALLOCATION_TYPE = "allocationType";
    //回显执行人
    private static final String IDM_ASSIGNEE = "idmAssignee";
    //回显候选执行组
    private static final String IDM_CANDIDATE_GROUPS = "idmCandidateGroups";
    //回显候选执行用户
    private static final String IDM_CANDIDATE_USERS = "idmCandidateUsers";
    //是否可编辑
    private static final String IS_EDITDATA = "isEditdata";
    //节点类型
    private static final String NODE_TYPE = "nodeType";


    static void customFillTypes(Map<String, Class<? extends BaseBpmnJsonConverter>> convertersToBpmnMap, Map<Class<? extends BaseElement>, Class<? extends BaseBpmnJsonConverter>> convertersToJsonMap) {
        fillJsonTypes(convertersToBpmnMap);
        fillBpmnTypes(convertersToJsonMap);
    }

    public static void fillJsonTypes(Map<String, Class<? extends BaseBpmnJsonConverter>> convertersToBpmnMap) {
        convertersToBpmnMap.put(STENCIL_TASK_USER, MyUserTaskJsonConverter.class);
    }

    public static void fillBpmnTypes(Map<Class<? extends BaseElement>, Class<? extends BaseBpmnJsonConverter>> convertersToJsonMap) {
        convertersToJsonMap.put(UserTask.class, MyUserTaskJsonConverter.class);
    }

    @Override
    protected void convertElementToJson(ObjectNode propertiesNode, BaseElement baseElement, BpmnJsonConverterContext converterContext) {
        super.convertElementToJson(propertiesNode, baseElement, converterContext);
        if (baseElement instanceof UserTask) {
            final String[] text = new String[6];
            baseElement.getExtensionElements().forEach((s, elements) -> elements.forEach(extensionElement -> {
                if (FORM_DATA.equals(extensionElement.getName())) {
                    String formData = extensionElement.getElementText();
                    if (StringUtils.isNotBlank(formData)) {
                        propertiesNode.put(FORM_DATA, formData);
                    }
                }
                if (ASSIGNEE_TYPE.equals(extensionElement.getName())) {
                    String assigneeType = extensionElement.getElementText();
                    if (StringUtils.isNotBlank(assigneeType)) {
                        propertiesNode.put(ASSIGNEE_TYPE, assigneeType);
                    }
                }
                if (ALLOCATION_TYPE.equals(extensionElement.getName())) {
                    String idmCandidateGroups = extensionElement.getElementText();
                    if (StringUtils.isNotBlank(idmCandidateGroups)) {
                        propertiesNode.put(ALLOCATION_TYPE, idmCandidateGroups);
                    }
                }
                if (ASSIGNEE_NAME.equals(extensionElement.getName())) {
                    String idmCandidateGroups = extensionElement.getElementText();
                    if (StringUtils.isNotBlank(idmCandidateGroups)) {
                        propertiesNode.put(ASSIGNEE_NAME, idmCandidateGroups);
                    }
                }
                if (IDM_ASSIGNEE.equals(extensionElement.getName())) {
                    String idmAssignee = extensionElement.getElementText();
                    if (StringUtils.isNotBlank(idmAssignee)) {
                        propertiesNode.put(IDM_ASSIGNEE, idmAssignee);
                    }
                }
                if (IDM_CANDIDATE_GROUPS.equals(extensionElement.getName())) {
                    String idmCandidateGroups = extensionElement.getElementText();
                    if (StringUtils.isNotBlank(idmCandidateGroups)) {
                        propertiesNode.put(IDM_CANDIDATE_GROUPS, idmCandidateGroups);
                    }
                }
                if (IDM_CANDIDATE_USERS.equals(extensionElement.getName())) {
                    String idmCandidateUsers = extensionElement.getElementText();
                    if (StringUtils.isNotBlank(idmCandidateUsers)) {
                        propertiesNode.put(IDM_CANDIDATE_USERS, idmCandidateUsers);
                    }
                }
                if (IS_EDITDATA.equals(extensionElement.getName())) {
                    String isEditData = extensionElement.getElementText();
                    if (StringUtils.isNotBlank(isEditData)) {
                        propertiesNode.put(IS_EDITDATA, isEditData);
                    }
                }
                if (NODE_TYPE.equals(extensionElement.getName())) {
                    String nodeType = extensionElement.getElementText();
                    if (StringUtils.isNotBlank(nodeType)) {
                        propertiesNode.put(NODE_TYPE, nodeType);
                    }
                }
            }));

        }
    }

    /**
     * 创建自定义属性
     *
     * @param propertyName  属性名称
     * @param propertyValue 属性值
     */
    private CustomProperty createProperty(String propertyName, String propertyValue) {
        CustomProperty customProperty = new CustomProperty();
        customProperty.setId(propertyName);
        customProperty.setName(propertyName);
        customProperty.setSimpleValue(propertyValue);
        return customProperty;
    }

    @Override
    protected FlowElement convertJsonToElement(JsonNode elementNode, JsonNode modelNode, Map<String, JsonNode> shapeMap, BpmnJsonConverterContext converterContex) {
        FlowElement flowElement = super.convertJsonToElement(elementNode, modelNode, shapeMap, converterContex);
        if (flowElement instanceof UserTask) {
            Map<String, List<ExtensionAttribute>> atts = new HashMap<String, List<ExtensionAttribute>>();
            String allocationType = getPropertyValueAsString(ALLOCATION_TYPE, elementNode);

            if (StringUtils.isNotEmpty(allocationType)) {
                LOGGER.info("新增自定义属性,分配策略[" + ALLOCATION_TYPE + "]=" + allocationType);
                ExtensionAttribute at = generate(ALLOCATION_TYPE, allocationType);
                atts.put(ALLOCATION_TYPE, Arrays.asList(at));
            }

            String assigneeName = getPropertyValueAsString(ASSIGNEE_NAME, elementNode);
            if (StringUtils.isNotEmpty(assigneeName)) {
                LOGGER.info("新增自定义属性,分配策略[" + ASSIGNEE_NAME + "]=" + assigneeName);
                ExtensionAttribute an = generate(ASSIGNEE_NAME, assigneeName);
                atts.put(ASSIGNEE_NAME, Arrays.asList(an));
            }

            flowElement.setAttributes(atts);
            this.addExtansionPropertiesElement(flowElement, elementNode);
        }
        return flowElement;
    }

    private ExtensionAttribute generate(String key, String val) {
        ExtensionAttribute ea = new ExtensionAttribute();
        ea.setNamespace("http://flowable.org/bpmn");
        ea.setName(key);
        ea.setNamespacePrefix("flowable");
        ea.setValue(val);
        return ea;
    }


    /**
     * @Author: 土豆仙
     * @Date: 2021/8/5 14:51
     * @Description: 扩展用户任务属性
     */
    private void addExtansionPropertiesElement(FlowElement flowElement, JsonNode elementNode) {
        if (flowElement instanceof UserTask) {
            UserTask userTask = (UserTask) flowElement;
            ExtansionProperties.addExtansionPropertiesElement(elementNode, userTask, ASSIGNEE_TYPE);
            ExtansionProperties.addExtansionPropertiesElement(elementNode, userTask, ASSIGNEE_NAME);
            ExtansionProperties.addExtansionPropertiesElement(elementNode, userTask, ALLOCATION_TYPE);
            ExtansionProperties.addExtansionPropertiesElement(elementNode, userTask, IDM_ASSIGNEE);
            ExtansionProperties.addExtansionPropertiesElement(elementNode, userTask, IDM_CANDIDATE_GROUPS);
            ExtansionProperties.addExtansionPropertiesElement(elementNode, userTask, IDM_CANDIDATE_USERS);
            ExtansionProperties.addExtansionPropertiesElement(elementNode, userTask, IS_EDITDATA);
            ExtansionProperties.addExtansionPropertiesElement(elementNode, userTask, NODE_TYPE);
        }
    }

//
//    private void addExtansionPropertiesElement(JsonNode objectNode, UserTask userTask, String name) {
//        JsonNode expansionNode = this.getProperty(name, objectNode);
//        if (expansionNode instanceof TextNode){
//            if (expansionNode != null && StringUtils.isNotBlank(expansionNode.asText())){
//                ExtensionElement extensionElement = new ExtensionElement();
//                extensionElement.setName(name);
//                extensionElement.setNamespacePrefix(BpmnXMLConstants.FLOWABLE_EXTENSIONS_PREFIX);
//                extensionElement.setNamespace(BpmnXMLConstants.FLOWABLE_EXTENSIONS_NAMESPACE);
//                extensionElement.setElementText(expansionNode.asText());
//                userTask.addExtensionElement(extensionElement);
//            }
//        }
//    }

//    @Override
//    protected void addExtensionElement(String name, String elementText, UserTask task) {
//        ExtensionElement extensionElement = new ExtensionElement();
//        extensionElement.setNamespace(NAMESPACE);
//        extensionElement.setNamespacePrefix("flowable");
//        extensionElement.setName(name);
//        extensionElement.setElementText(elementText);
//        task.addExtensionElement(extensionElement);
//    }

}
