package com.workflow.process.center.domain.dto.task;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
*   @Author: 土豆仙
*   @Date: 2021/6/28 17:51
*   @Description: 终止任务
*/
@Data
@ApiModel("终止任务参数")
public class EndTaskDTO implements Serializable {

    /**
     * 操作人code 必填
     */
    @ApiModelProperty(value = "操作人员id")
    private String userId;

    /**
     * 流程实例的id 必填
     */
    @NotBlank(message = "流程实例的id不能为空！！")
    @ApiModelProperty(value = "流程实例的id")
    private String processInstanceId;

    /**
     * 审批意见 必填
     */
    @ApiModelProperty(value = "审批意见")
    private String message;
}
