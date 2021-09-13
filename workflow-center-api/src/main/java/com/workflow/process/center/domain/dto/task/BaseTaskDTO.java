package com.workflow.process.center.domain.dto.task;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * @Author: 土豆仙
 * @Date: 2021/6/28 21:23
 * @Description: 任务操作参数基类
 */
@Data
public class BaseTaskDTO implements Serializable {
    /**********************任务相关的参数**********************/
    /**
     * 任务id 必填
     */
    @NotBlank(message = "任务id不能为空！！")
    @ApiModelProperty(value = "任务id")
    private String taskId;

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
    private String message;

}
