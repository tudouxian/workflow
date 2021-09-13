package com.workflow.process.center.domain.dto.task;

import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.validation.constraints.NotEmpty;
import java.util.List;

/**
*   @Author: 土豆仙
*   @Date: 2021/6/28 17:56
*   @Description: 协同
*/
@EqualsAndHashCode(callSuper = true)
@Data
@ApiModel("协同参数")
public class SynergyTaskDTO extends BaseTaskDTO{

    /**
     * 协同人
     */
    @NotEmpty(message = "请指明和谁协同办理！！")
    private List<String> synergyUserIds;
}
