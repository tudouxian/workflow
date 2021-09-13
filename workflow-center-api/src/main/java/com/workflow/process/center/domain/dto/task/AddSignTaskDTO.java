package com.workflow.process.center.domain.dto.task;

import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.validation.constraints.NotEmpty;
import java.util.List;

/**
*   @Author: 土豆仙
*   @Date: 2021/6/28 17:56
*   @Description: 加签
*/
@EqualsAndHashCode(callSuper = true)
@Data
@ApiModel("加签参数")
public class AddSignTaskDTO extends BaseTaskDTO {

    /**
     * 被加签人
     */
    @NotEmpty(message = "请指明向谁加签！！")
    private List<String> signUserIds;
}
