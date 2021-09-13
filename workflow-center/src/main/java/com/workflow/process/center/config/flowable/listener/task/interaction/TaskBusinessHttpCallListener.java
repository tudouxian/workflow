package com.workflow.process.center.config.flowable.listener.task.interaction;


import com.alibaba.fastjson.JSON;
import com.workflow.process.center.utils.StringUtils;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.jayway.jsonpath.JsonPath;
import lombok.extern.slf4j.Slf4j;
import okhttp3.*;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.collections4.MapUtils;
import org.apache.commons.lang3.ObjectUtils;
import org.flowable.bpmn.model.FieldExtension;
import org.flowable.bpmn.model.FlowableListener;
import org.flowable.bpmn.model.UserTask;
import org.flowable.common.engine.api.delegate.Expression;
import org.flowable.engine.ProcessEngine;
import org.flowable.engine.delegate.DelegateExecution;
import org.flowable.engine.delegate.DelegateHelper;
import org.flowable.engine.delegate.ExecutionListener;
import org.flowable.engine.delegate.TaskListener;
import org.flowable.engine.impl.cfg.ProcessEngineConfigurationImpl;
import org.flowable.engine.impl.util.ProcessDefinitionUtil;
import org.flowable.task.service.delegate.DelegateTask;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import static org.apache.commons.lang3.StringUtils.trimToEmpty;

@Component(value = "taskBusinessHttpCallListener")
@Slf4j
public class TaskBusinessHttpCallListener implements TaskListener, ExecutionListener {

    @Autowired
    private ProcessEngine processEngine;

    @Autowired
    private ProcessEngineConfigurationImpl processEngineConfiguration;

    @Autowired
    private OkHttpClient okHttpClient;

    // private final AtomicReference<OkHttpClient> okHttpClientAtomicReference = new AtomicReference<>();

    //属性：
    //请求路径：http://115.231.181.186:9007/rest/index/login/login
    private Expression remoteUrl;

    //GET, POST, PUT, PATCH, DELETE, HEAD, OPTIONS
    private Expression method;

    //Content-Type  =>application/json
    private Expression contentType;

    //授权请求头
    private Expression authorization;

    //JSON、FROMBODY、MULTIPARTBODY
    private Expression requestBodyFormat;

    //表单数据，字段前缀
    private String formBase = "form:";

    //true|false
    private Expression putResponseBodyInVariable;


    //连接池初始化参数
    private Expression connectionTimeout;

    private Expression readTimeout;

    private Expression idleTimeout;

    private Expression maxIdleConnections;


    //请求表单
    private static final Pattern DYNAMIC_FORM_PARAMETER_NAME = Pattern.compile("form:(?<formDataName>.*)$");

    //返回结果设置变量-设置执行实例变量
    private static final Pattern DYNAMIC_RESULT_PARAMETER_NAME_EXEC = Pattern.compile("exec:(?<formDataName>.*)$");

    //返回结果设置变量-设置执行任务变量
    private static final Pattern DYNAMIC_RESULT_PARAMETER_NAME_TASK = Pattern.compile("task:(?<formDataName>.*)$");

    @Override
    public void notify(DelegateExecution execution) {
        //获取执行监听器所有扩展字段
        List<FieldExtension> fields = DelegateHelper.getFields(execution);
    }


    private enum RequestBodyType {
        JSON,
        FROMBODY,
        MULTIPARTBODY
    }


    @Override
    public void notify(DelegateTask delegateTask) {
        //创建http客户端
       /* OkHttpClient.Builder okHttpClientBuilder = new OkHttpClient().newBuilder();

        //协议
        okHttpClientBuilder.protocols(Arrays.asList(Protocol.HTTP_1_1, Protocol.HTTP_2));

        // 设置超时
        okHttpClientBuilder.connectTimeout((Integer.parseInt(connectionTimeout.getValue(delegateTask).toString())), TimeUnit.MILLISECONDS);
        okHttpClientBuilder.readTimeout((Integer.parseInt(readTimeout.getValue(delegateTask).toString())), TimeUnit.MILLISECONDS);

        //连接池设置
        okHttpClientBuilder.connectionPool(
                new ConnectionPool(
                        Integer.parseInt(maxIdleConnections.getValue(delegateTask).toString()),
                        Integer.parseInt(idleTimeout.getValue(delegateTask).toString()), TimeUnit.MILLISECONDS
                )
        );

        //缓存Http客户端
        okHttpClientAtomicReference.set(okHttpClientBuilder.build());*/

        //获取执行监听器所有扩展字段
        //Expression xxx = DelegateHelper.getFieldExpression(delegateTask, "xxx");

        onTrigger(delegateTask);


    }

    private Map<String, String> getListenerVariables(DelegateTask delegateTask) {

        String eventHandlerId = delegateTask.getEventHandlerId();
        org.flowable.bpmn.model.Process process = ProcessDefinitionUtil.getProcess(delegateTask.getProcessDefinitionId());
        UserTask userTask = (UserTask) process.getFlowElementMap().get(delegateTask.getTaskDefinitionKey());

        FlowableListener flowableListener = null;
        for (FlowableListener f : userTask.getTaskListeners()) {
            if (f.getId() != null && f.getId().equals(eventHandlerId)) {
                flowableListener = f;
            }
        }

        if (flowableListener != null) {
            List<FieldExtension> fieldExtensions = flowableListener.getFieldExtensions();
            if (CollectionUtils.isNotEmpty(fieldExtensions)) {
                Map<String, String> collect = fieldExtensions.stream()
                        .collect(Collectors.toMap(FieldExtension::getFieldName, fieldExtension -> {
                            return StringUtils.isNotEmpty(fieldExtension.getStringValue()) ? fieldExtension.getStringValue() : fieldExtension.getExpression();
                        }));

                return collect;

            }
        }
        return null;
    }

    public void onTrigger(DelegateTask delegateTask) {
        //获取缓存客户端
        //OkHttpClient okHttpClient = okHttpClientAtomicReference.get();

        //检查是否要根据返回结果-设置流程变量  TODO
        boolean putResponseBodyInVariableValue = Boolean.parseBoolean(putResponseBodyInVariable.getValue(delegateTask).toString());

        //读取请求路径
        String urlstr = remoteUrl.getValue(delegateTask).toString();

        System.out.println("===" + JSON.toJSONString(delegateTask));
        try {
            URL url = new URL(urlstr);
            //获取所有表单参数变量名
            Map<String, String> formCollect = new HashMap<>();

            //获取所有需要设置执行变量名-解析结果集
            Map<String, String> execCollect = new HashMap<>();

            //获取所有需要设置任务变量名-解析结果集
            Map<String, String> taskCollect = new HashMap<>();

            //Map<String, Object> variables = delegateTask.getVariables();

            Map<String, String> variables = getListenerVariables(delegateTask);


            variables.forEach((key, value) -> {
                Matcher formMatcher = DYNAMIC_FORM_PARAMETER_NAME.matcher(key);
                Matcher execMatcher = DYNAMIC_RESULT_PARAMETER_NAME_EXEC.matcher(key);
                Matcher taskMatcher = DYNAMIC_RESULT_PARAMETER_NAME_TASK.matcher(key);
                if (formMatcher.matches()) {
                    formCollect.put(formMatcher.group("formDataName"), value);
                }
                if (execMatcher.matches()) {
                    execCollect.put(execMatcher.group("formDataName"), value);
                }
                if (taskMatcher.matches()) {
                    taskCollect.put(taskMatcher.group("formDataName"), value);
                }
            });
            //创建请求
            Request httpRequest = configureRequest(url, formCollect, delegateTask);


            try (Response responseHttp = okHttpClient.newCall(httpRequest).execute()) {
                //返回状态码和消息
                int statusCode = responseHttp.code();
                String statusMessage = responseHttp.message();
                log.info("Http请求返回状态码：【{}】  消息：【{}】", statusCode, statusMessage);

                //解析返回道流程变量中
                if (putResponseBodyInVariableValue) {
                    ResponseBody responseBody = responseHttp.body();
                    String strJson = responseBody.string();
                    log.info("解析返回结果至流程变量中。返回结果：【{}】", strJson);

                    //解析返回结果
                    resolveResponse(delegateTask, strJson, execCollect, taskCollect);
                }

            }


        } catch (Exception e) {
            e.printStackTrace();
        }


    }

    private void resolveResponse(DelegateTask delegateTask, String resJson, Map<String, String> execCollect, Map<String, String> taskCollect) {

        if (MapUtils.isNotEmpty(execCollect)) {
            //设置执行实例变量
            Set<Map.Entry<String, JsonPath>> execJsonPaths = execCollect.entrySet().stream()
                    .filter(e -> ObjectUtils.isNotEmpty(e.getValue()))
                    .collect(Collectors.toMap(e -> e.getKey(), e -> JsonPath.compile(e.getValue().toString())))
                    .entrySet();

            for (Map.Entry<String, JsonPath> taskJsonPath : execJsonPaths) {

                processEngine.getRuntimeService()
                        .setVariable(delegateTask.getExecutionId(),
                                taskJsonPath.getKey(),
                                taskJsonPath.getValue().read(resJson));

            }
        }


        if (MapUtils.isNotEmpty(taskCollect)) {
            //设置执行任务变量
            Set<Map.Entry<String, JsonPath>> taskJsonPaths = taskCollect.entrySet().stream()
                    .filter(e -> ObjectUtils.isNotEmpty(e.getValue()))
                    .collect(Collectors.toMap(e -> e.getKey(), e -> JsonPath.compile(e.getValue().toString())))
                    .entrySet();

            for (Map.Entry<String, JsonPath> taskJsonPath : taskJsonPaths) {

                delegateTask.setVariable(taskJsonPath.getKey(), taskJsonPath.getValue().read(resJson));

            }
        }


    }

    //构建请求
    private Request configureRequest(URL url, Map<String, String> formCollect, DelegateTask delegateTask) {
        //创建请求
        Request.Builder requestBuilder = new Request.Builder();

        //设置请求路径
        requestBuilder = requestBuilder.url(url);

        String authorizationValue = authorization.getValue(delegateTask).toString();
        if (StringUtils.isNotEmpty(authorizationValue)) {
            requestBuilder = requestBuilder.header("Authorization", authorizationValue);
        }

        String methodValue = trimToEmpty(method.getValue(delegateTask).toString()).toUpperCase();
        switch (methodValue) {
            case "GET":
                requestBuilder = requestBuilder.get();
                break;
            case "POST":
                RequestBody requestBody = getRequestBodyToSend(formCollect, delegateTask);
                requestBuilder = requestBuilder.post(requestBody);
                break;
            case "PUT":
                requestBody = getRequestBodyToSend(formCollect, delegateTask);
                requestBuilder = requestBuilder.put(requestBody);
                break;
            case "PATCH":
                requestBody = getRequestBodyToSend(formCollect, delegateTask);
                requestBuilder = requestBuilder.patch(requestBody);
                break;
            case "HEAD":
                requestBuilder = requestBuilder.head();
                break;
            case "DELETE":
                requestBuilder = requestBuilder.delete();
                break;
            default:
                requestBuilder = requestBuilder.method(methodValue, null);
        }

        requestBuilder = setHeaderProperties(delegateTask, requestBuilder);

        return requestBuilder.build();
    }

    //设置请求头
    private Request.Builder setHeaderProperties(DelegateTask delegateTask, Request.Builder requestBuilder) {
        //时间请求头
       /* if (context.getProperty(PROP_DATE_HEADER).asBoolean()) {
            requestBuilder = requestBuilder.addHeader("Date", DATE_FORMAT.print(System.currentTimeMillis()));
        }*/

        return requestBuilder;
    }


    //设置请求体
    private RequestBody getRequestBodyToSend(Map<String, String> formCollect, DelegateTask delegateTask) {

        //获取请求体类型
        String contentTypeValue = contentType.getValue(delegateTask).toString();


        //需要构造请求参数体
        if (formCollect.size() > 0) {
            //获取配置请求体格式
            String requestBodyFormatValue = requestBodyFormat.getValue(delegateTask).toString();
            RequestBodyType requestBodyType = RequestBodyType.valueOf(requestBodyFormatValue);

            switch (requestBodyType) {
                case JSON:
                    ObjectMapper objectMapper = new ObjectMapper();
                    ObjectNode objectNode = objectMapper.createObjectNode();
                    for (final Map.Entry<String, String> entry : formCollect.entrySet()) {

                        Object value = processEngineConfiguration.getExpressionManager()
                                .createExpression(entry.getValue().toString()).getValue(delegateTask);
                        objectNode.put(entry.getKey(), value.toString());
                    }

                    return RequestBody.create(MediaType.parse(contentTypeValue), objectNode.toString());
                case FROMBODY:
                    FormBody.Builder fBuilder = new FormBody.Builder();
                    for (final Map.Entry<String, String> entry : formCollect.entrySet()) {
                        Object value = processEngineConfiguration.getExpressionManager()
                                .createExpression(entry.getValue()).getValue(delegateTask);
                        fBuilder.add(entry.getKey(), value.toString());
                    }
                    return fBuilder.build();

                //文件上传
            }
        }

        return RequestBody.create(null, new byte[0]);


    }

}
