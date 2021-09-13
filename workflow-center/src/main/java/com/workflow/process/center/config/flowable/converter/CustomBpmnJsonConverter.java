package com.workflow.process.center.config.flowable.converter;

import org.flowable.editor.language.json.converter.BpmnJsonConverter;

/**
*   @Author: 土豆仙
*   @Date: 2021/6/27 0:27
*   @Description: 扩展配置
*/
public class CustomBpmnJsonConverter extends BpmnJsonConverter {
    static {
        MyUserTaskJsonConverter.customFillTypes(convertersToBpmnMap, convertersToJsonMap);
        MyCallActivityJsonConverter.customFillTypes(convertersToBpmnMap, convertersToJsonMap);
        MySubProcessJsonConverter.customFillTypes(convertersToBpmnMap, convertersToJsonMap);
    }
}
