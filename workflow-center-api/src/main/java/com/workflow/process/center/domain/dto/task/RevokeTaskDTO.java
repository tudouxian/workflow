package com.workflow.process.center.domain.dto.task;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
*   @Author: 土豆仙
*   @Date: 2021/6/28 17:50
*   @Description: 撤回
*/
@Data
@ApiModel("撤回参数")
public class RevokeTaskDTO implements Serializable {

    /**
     * 流程实例的id 必填
     */
    @NotBlank(message = "流程实例的id不能为空！！")
    @ApiModelProperty(value = "流程实例的id")
    private String processInstanceId;

    /**********************审批意见的参数**********************/
    /**
     * 操作人code 必填
     */
    @ApiModelProperty(value = "操作人员id")
    private String userId;
    /**
     * 审批意见 必填
     */
    @ApiModelProperty(value = "审批意见")
    @NotBlank(message = "审批意见不能为空！")
    private String message;
}
