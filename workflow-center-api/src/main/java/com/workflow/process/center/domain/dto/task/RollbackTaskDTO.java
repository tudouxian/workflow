package com.workflow.process.center.domain.dto.task;


import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
@ApiModel("回撤任务")
public class RollbackTaskDTO extends BaseTaskDTO {
}
