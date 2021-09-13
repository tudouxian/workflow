package com.workflow.process.center.common.enums;

import java.io.Serializable;

/**
*   @Author: 土豆仙
*   @Date: 2021/6/27 22:43
*   @Description: 流程的状态
*/
public enum ProcessStatusEnum implements Serializable {

    SPZ("流转中"),
    BH("驳回"),
    CH("撤回流程"),
    WP("委派"),
    JQ("加签"),
    ZC("暂存"),
    ZB("转办"),
    CX("撤销"),
    BJ("办结"),
    QZJS("强制结束"),
    ZZ("中止");

    private String msg;
    private String type;

    ProcessStatusEnum(String msg) {
        this.msg = msg;
    }

    /**
     * 通过type获取Msg
     *
     * @param type
     * @return
     * @Description:
     */
    public static String getEnumMsgByType(String type) {
        for (ProcessStatusEnum e : ProcessStatusEnum.values()) {
            if (e.toString().equals(type)) {
                return e.msg;
            }
        }
        return "";
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}

	