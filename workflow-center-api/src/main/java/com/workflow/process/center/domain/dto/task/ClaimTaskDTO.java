package com.workflow.process.center.domain.dto.task;

import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
*   @Author: 土豆仙
*   @Date: 2021/6/28 17:54
*   @Description: 签收
*/
@EqualsAndHashCode(callSuper = true)
@Data
@ApiModel("签收参数")
public class ClaimTaskDTO extends BaseTaskDTO {
}
