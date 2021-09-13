package com.workflow.process.center.domain.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
*   @Author: 土豆仙
*   @Date: 2021/6/26 23:17
*   @Description: 模型视图
*/
@Data
@ApiModel(value = "ModelInfoVo", description = "查询模型对象返回对象")
public class ModelInfoDTO {

    @ApiModelProperty(value = "模型ID")
    @NotBlank(message = "模型id不能为空！！！")
    private String modelId;

    @ApiModelProperty(value = "模型Key")
    //@NotBlank(message = "模型Key为空")
    //@Length(max = 20, message = "模型Key不能超过20个字符")
    //@Pattern(regexp = "^[a-zA-Z][a-zA-Z0-9_]*$", message = "模型Key限制：以字母开头，只能由字母数字下划线组成")
    private String modelKey;

    @ApiModelProperty(value = "模型名称")
    //@NotBlank(message = "模型名称不能为空！！！")
    private String modelName;

    @ApiModelProperty(value = "模型文件名")
    private String fileName;

    @ApiModelProperty(value = "模型XML信息")
    @NotBlank(message = "模型xml信息不能为空！！！")
    private String modelXml;
}
