package com.workflow.process.center.service;

import java.util.Map;

public interface FlowableExpressionService {

    /**
     * 获取流程实例的表达式的字符串值
     *
     * @param processInstanceId 流程实例id
     * @param assignee               表达式
     * @return 值
     */
    String getStrValue(String processInstanceId, String assignee);

    /**
     * 获取流程实例的表达式的值
     *
     * @param processInstanceId 流程实例id
     * @param exp               表达式
     * @return 值
     */
    Object getValue(String processInstanceId, String exp);

    /**
     * 获取流程实例的表达式的值
     *
     * @param processInstanceId 流程实例id
     * @param exp               表达式
     * @param clazz             类
     * @param <T>               泛型
     * @return
     */
    <T> T getValue(String processInstanceId, String exp, Class<T> clazz);

    /**
     * 原生的解析表达式
     *
     * @param params 变量的值
     * @param exp    表达式
     * @param clazz  映射出来的值
     * @return
     */
    <T> T getValue(Map<String, Object> params, String exp, Class<T> clazz);
}
