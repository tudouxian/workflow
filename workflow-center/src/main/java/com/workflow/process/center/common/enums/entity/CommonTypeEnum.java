package com.workflow.process.center.common.enums.entity;

import com.baomidou.mybatisplus.annotation.EnumValue;
import com.fasterxml.jackson.annotation.JsonValue;

public enum CommonTypeEnum {

    NO(0,"否"),
    YSE(1,"是");


    @EnumValue
    private Integer key;

    @JsonValue
    private String display;

    CommonTypeEnum(Integer key, String display) {
        this.key = key;
        this.display = display;
    }

    public Integer getKey() {
        return key;
    }

    public void setKey(Integer key) {
        this.key = key;
    }

    public String getDisplay() {
        return display;
    }

    public void setDisplay(String display) {
        this.display = display;
    }
}
