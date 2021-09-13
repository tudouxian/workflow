package com.workflow.process.center.domain.dto;


import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel("服务配置关联流程定义")
public class ServiceReProcessDefinitionDTO {

    @ApiModelProperty("流程分类")
    private String category;

    @ApiModelProperty("流程key")
    private String key;

    @ApiModelProperty("流程名称")
    private String name;

    @ApiModelProperty("版本")
    private int version;

    @ApiModelProperty("流程定义id")
    private String id;

}
