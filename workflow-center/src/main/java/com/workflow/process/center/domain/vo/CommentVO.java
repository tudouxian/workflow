package com.workflow.process.center.domain.vo;

import com.workflow.process.center.common.enums.entity.CommentTypeEnum;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

/**
 * @Author: 土豆仙
 * @Date: 2021/7/14 10:42
 * @Description: 审核意见视图
 */
@ApiModel(value = "CommentVO", description = "审批信息")
@Data
public class CommentVO {

    //审核人ID
    @ApiModelProperty("审核人ID")
    protected String userId;

    //审核人名称
    @ApiModelProperty("审核人名称")
    protected String userName;

    //审核类型
    @ApiModelProperty("审核类型")
    protected CommentTypeEnum type;

    //审核时间
    @ApiModelProperty("审核时间")
    protected Date time;

    //审核信息
   /* @ApiModelProperty("审核信息")
    protected String message;*/

    //审核信息
    @ApiModelProperty("操作记录")
    protected String action;

    //审核详细信息
    @ApiModelProperty("审核详细信息")
    protected String fullMessage;
}
