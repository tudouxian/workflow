package com.workflow.process.center.service;

import java.util.Map;

public interface IDynamDubbo {

    public Object invoke(String clazzName, String method, String version, String parameter);

    public Object invoke(String clazzName, String method, String version, Map<String, String> parameter);

    public Object invoke(String clazzName, String method, String version, String[] parameters);
}
