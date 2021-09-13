package com.workflow.process.center.domain.dto;

import lombok.Data;

import java.io.Serializable;

@Data
public class AssigneeDTO implements Serializable {

    //用户id
    private String  userId;
    //名称
    private String name;
    //电话
    private String mobile;
}
