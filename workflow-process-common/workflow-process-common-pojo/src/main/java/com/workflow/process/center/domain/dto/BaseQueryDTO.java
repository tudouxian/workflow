package com.workflow.process.center.domain.dto;

import lombok.Data;

import java.io.Serializable;

@Data
public class BaseQueryDTO implements Serializable {

    private Integer pageIndex =1;

    private Integer pageSize =10;
}
