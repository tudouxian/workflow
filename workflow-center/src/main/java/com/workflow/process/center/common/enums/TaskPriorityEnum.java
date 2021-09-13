package com.workflow.process.center.common.enums;

import com.baomidou.mybatisplus.annotation.EnumValue;
import com.fasterxml.jackson.annotation.JsonValue;

public enum TaskPriorityEnum {

    NOTHING(1,"无"),
    LOW(50,"低"),
    MIDDLE(80,"中"),
    HIGH(100,"高");
    @EnumValue
    private Integer type;

    @JsonValue
    private String name;

    TaskPriorityEnum(Integer type, String name) {
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
