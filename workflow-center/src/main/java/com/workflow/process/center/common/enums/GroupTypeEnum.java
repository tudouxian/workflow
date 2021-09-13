package com.workflow.process.center.common.enums;

public enum GroupTypeEnum {
    /**
     * 组-对应-标识=》约定
     */
    //角色
    ROLE_GROUP("role","role_"),
    //部门
    DEPT_GROUP("dept","dept_"),
    //区域
    AREA_GROUP("area","area_");

    private String type;

    private String key;

    GroupTypeEnum(String type, String key) {
        this.type = type;
        this.key = key;
    }

    public static GroupTypeEnum getGroupType(String key) {

        for (GroupTypeEnum e : GroupTypeEnum.values()) {
            if (e.type.equals(key)) {
                return e;
            }
        }
        return null;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }
}
