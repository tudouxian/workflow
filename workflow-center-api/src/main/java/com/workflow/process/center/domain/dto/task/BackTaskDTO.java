package com.workflow.process.center.domain.dto.task;

import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.validation.constraints.NotBlank;

/**
*   @Author: 土豆仙
*   @Date: 2021/6/28 17:55
*   @Description: 指定驳回
*/
@EqualsAndHashCode(callSuper = true)
@Data
@ApiModel("指定驳回参数")
public class BackTaskDTO extends BaseTaskDTO {

    /**
     * 需要驳回的节点id 必填
     */
    @NotBlank(message = "需要驳回的节点id不能为空！")
    private String distFlowElementId;
}
