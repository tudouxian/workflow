package com.workflow.process.center.common.contant;

public class CommonContant {


    /** 下划线 */
    public static final String SEPARATOR = "+";

    public static final int PROCESSACTIVE = 1;
    public static final int PROCESSSUSPEND = 2;

    public static final int UNPUBLISH = 0;
    public static final int PUBLISH = 1;

    public static final int VALID = 0;
    public static final int NOVALID = 1;

    //流程定义状态值
    public static final int PROCESSDEFINITIONSTATEACTIVE = 1;
    public static final int PROCESSDEFINITIONSTATESUSPEND = 2;

    //Bpmn文件后缀
    public static final String BPMN_EXTENSION = ".bpmn";
    public static final String BPMN20_XML_EXTENSION = ".bpmn20.xml";

    /**
     * flowable:button 按钮名称
     */
    public static final String ELEMENT_BUTTON = "button";

    //缓存模块名称
    public static final String CACHE_PROCESS_ACTIVITYS = "cache-process-activitys";
    public static final String CACHE_PROCESS_HIGHLIGHTEDNODES = "cache-process-highlightednodes";
    public static final String CACHE_PROCESS_INSTANCE = "cache-process-instance";
    public static final String CACHE_PROCESS_DEFINITION = "cache-process-definition";
    public static final String CACHE_COMMON_DICTIONARY = "cache-common-dictionary";
    public static final String CACHE_START_PROCESSINSTANCE = "cache-start-processinstance";
    public static final String CACHE_ACL_PERMISSIONVALS = "cache-acl-permissionvals";


    /**
     * 提交人节点名称
     */
    public static final String FLOW_SUBMITTER = "提交人";
    /**
     * 提交人的变量名称
     */
    public static final String FLOW_SUBMITTER_VAR = "initiator";


    //节点类型
    public static final String NODE_TYPE = "nodetype";

    //后加签
    public static final String AFTER_ADDSIGN = "after";
    //前加签
    public static final String BEFORE_ADDSIGN = "before";
    //协同
    public static final String SYNERGY =  "synergy";


    public static final String IMAGE_TYPE = "png";


    //回撤

    /**
     * 配置 任务执行人变量
     */
    public static final String ASSIGNEE_PREFIX_KEY = "ROLLBACK_ASSIGNEE_PREFIX_";

    /**
     * 配置 任务执行人变量
     */
    public static final String TASK_TYPE_PREFIX_KEY = "ROLLBACK_TASK_TYPE_PREFIX_";


    /**
     * 会签任务变量
     */
    public static final String NR_OF_ACTIVE_INSTANCES = "nrOfActiveInstances";
    public static final String NR_OF_COMPLETE_INSTANCES = "nrOfCompletedInstances";
    public static final String NR_OF_INSTANCE = "nrOfInstances";
    public static final String LOOP_COUNTER = "loopCounter";


}
