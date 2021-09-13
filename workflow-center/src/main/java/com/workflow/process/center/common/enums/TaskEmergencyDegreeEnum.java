package com.workflow.process.center.common.enums;

import com.baomidou.mybatisplus.annotation.EnumValue;
import com.fasterxml.jackson.annotation.JsonValue;

/**
*   @Author: 土豆仙
*   @Date: 2021/7/24 20:38
*   @Description: 任务紧急程度枚举
*/
public enum TaskEmergencyDegreeEnum {
    GENERAL(1,"一般"),
    URGENCY(2,"紧急");
    @EnumValue
    private Integer type;

    @JsonValue
    private String name;

    TaskEmergencyDegreeEnum(Integer type, String name) {
        this.type = type;
        this.name = name;
    }


    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
