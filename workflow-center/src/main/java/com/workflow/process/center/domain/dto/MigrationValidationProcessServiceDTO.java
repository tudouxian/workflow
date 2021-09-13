package com.workflow.process.center.domain.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;

@Data
public class MigrationValidationProcessServiceDTO {

    /**
     * 流程实例ID 必填
     */
    @ApiModelProperty(value = "流程实例ID", required = true)
    @NotBlank(message = "流程实例ID不能为空！")
    private String procInsId;

    /**
     * 新版本流程定义ID 必填
     */
    @ApiModelProperty(value = "新版本流程定义ID", required = true)
    @NotBlank(message = "流程定义ID不能为空！")
    private String procDefId;
}
