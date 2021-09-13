package com.workflow.process.center.config.flowable.converter;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.apache.commons.lang3.StringUtils;
import org.flowable.bpmn.model.BaseElement;
import org.flowable.bpmn.model.CallActivity;
import org.flowable.bpmn.model.FlowElement;
import org.flowable.editor.language.json.converter.BaseBpmnJsonConverter;
import org.flowable.editor.language.json.converter.BpmnJsonConverterContext;
import org.flowable.editor.language.json.converter.CallActivityJsonConverter;

import java.util.Map;

/**
*   @Author: 土豆仙
*   @Date: 2021/6/27 0:32
*   @Description: 扩展
*/
public class MyCallActivityJsonConverter extends CallActivityJsonConverter {

    private static final String MODEL_BPMN_EXTENSION = "modelBpmnExtension";

    public static void customFillTypes(Map<String, Class<? extends BaseBpmnJsonConverter>> convertersToBpmnMap, Map<Class<? extends BaseElement>, Class<? extends BaseBpmnJsonConverter>> convertersToJsonMap) {
        fillJsonTypes(convertersToBpmnMap);
        fillBpmnTypes(convertersToJsonMap);
    }

    public static void fillJsonTypes(Map<String, Class<? extends BaseBpmnJsonConverter>> convertersToBpmnMap) {
        convertersToBpmnMap.put(STENCIL_CALL_ACTIVITY, MyCallActivityJsonConverter.class);
    }

    public static void fillBpmnTypes(Map<Class<? extends BaseElement>, Class<? extends BaseBpmnJsonConverter>> convertersToJsonMap) {
        convertersToJsonMap.put(CallActivity.class, MyCallActivityJsonConverter.class);
    }

    @Override
    protected void convertElementToJson(ObjectNode propertiesNode, BaseElement baseElement,
                                        BpmnJsonConverterContext converterContext) {
        super.convertElementToJson(propertiesNode, baseElement, converterContext);
        final String[] text = new String[1];
        baseElement.getExtensionElements().forEach((s, elements) -> elements.forEach(extensionElement -> {
            if (MODEL_BPMN_EXTENSION.equals(extensionElement.getName())) {
                text[0] = extensionElement.getElementText();
            }
        }));
        if (StringUtils.isNotBlank(text[0])) {
            propertiesNode.put(MODEL_BPMN_EXTENSION, text[0]);
        }
    }

    @Override
    protected FlowElement convertJsonToElement(JsonNode elementNode, JsonNode modelNode, Map<String, JsonNode> shapeMap, BpmnJsonConverterContext converterContex) {
        FlowElement flowElement = super.convertJsonToElement(elementNode, modelNode, shapeMap, converterContex);
        this.addExtansionPropertiesElement(flowElement, elementNode);
        return flowElement;
    }

    private void addExtansionPropertiesElement(FlowElement flowElement, JsonNode elementNode) {
        if (flowElement instanceof CallActivity) {
            CallActivity callActivity = (CallActivity) flowElement;
            ExtansionProperties.addExtansionPropertiesElement(elementNode, callActivity, MODEL_BPMN_EXTENSION);
        }
    }

}
