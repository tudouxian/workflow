package com.workflow.process.center.domain.dto.task;

import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.validation.constraints.NotBlank;

/**
*   @Author: 土豆仙
*   @Date: 2021/6/28 17:49
*   @Description: 转办
*/
@EqualsAndHashCode(callSuper = true)
@Data
@ApiModel("转办参数")
public class TurnTaskDTO extends BaseTaskDTO {
    /**
     * 被转办人工号 必填
     */
    @NotBlank(message = "请指明向谁转办！")
    private String turnToUserId;
}
