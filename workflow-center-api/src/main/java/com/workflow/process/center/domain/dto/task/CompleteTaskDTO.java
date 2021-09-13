package com.workflow.process.center.domain.dto.task;

import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.Map;

/**
*   @Author: 土豆仙
*   @Date: 2021/6/28 17:49
*   @Description: 审批完成
*/
@EqualsAndHashCode(callSuper = true)
@Data
@ApiModel("审批完成参数")
public class CompleteTaskDTO  extends BaseTaskDTO {
    /**
     * 任务参数 选填
     */
    private Map<String, Object> variables;
}
