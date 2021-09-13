package com.workflow.process.center.common.enums;
/**
*   @Author: 土豆仙
*   @Date: 2021/7/1 15:34
*   @Description: 启动变量mei'ju
*/
public enum StartVariableEnum {
    FORM("form", "表单");
    private String code;
    private String msg;

    StartVariableEnum(String code, String msg) {
        this.msg = msg;
        this.code = code;
    }

    /**
     * 通过code获取Msg
     *
     * @param code
     * @return
     * @Description:
     */
    public static String getEnumMsgByCode(String code) {
        for (StartVariableEnum e : StartVariableEnum.values()) {
            if (e.getCode().equals(code)) {
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

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
}
