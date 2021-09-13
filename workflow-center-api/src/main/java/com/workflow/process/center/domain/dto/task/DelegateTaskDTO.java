package com.workflow.process.center.domain.dto.task;

import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.validation.constraints.NotBlank;

/**
*   @Author: 土豆仙
*   @Date: 2021/6/28 17:53
*   @Description: 委派
*/
@EqualsAndHashCode(callSuper = true)
@Data
@ApiModel("委派参数")
public class DelegateTaskDTO  extends BaseTaskDTO{
    /**
     * 委派人
     */
    @NotBlank(message = "委派人Id不能为空！")
    private String delegateUserId;
}
