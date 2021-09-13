package com.workflow.process.center.domain.entity;

import java.util.Date;

import com.baomidou.mybatisplus.annotation.*;
import com.workflow.process.center.common.enums.entity.ButtonTypeEnum;
import com.workflow.process.center.common.enums.entity.CommonTypeEnum;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;

import java.io.Serializable;
import java.util.Date;


/**
 * 流程按钮(WorkFlowButton)表实体类
 *
 * @author 土豆仙
 * @since 2021-06-21 16:39:36
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("流程按钮")
public class WorkFlowButton extends BaseEntity implements Serializable {

    private static final long serialVersionUID = 295608518894795119L;

    /**
     * 主键id
     */
    @ApiModelProperty(value = "主键id")
    @TableId(value = "id",type = IdType.AUTO)
    private Integer id;

    /**
     * 按钮名称
     */
    @ApiModelProperty(value = "按钮名称")
    @TableField("button_name")
    private String buttonName;

    /**
     * 按钮编码
     */
    @ApiModelProperty(value = "按钮编码")
    @TableField("button_code")
    private String buttonCode;

    /**
     * 请求路径-相对
     */
    @ApiModelProperty(value = "请求路径")
    @TableField("request_url")
    private String requestUrl;

    /**
     * 按钮类型
     */
    @ApiModelProperty(value = "按钮类型")
    @TableField("button_type")
    private ButtonTypeEnum buttonTypeEnum;

    /**
     * 系统预设按钮，0：否，1：是
     */
    @ApiModelProperty(value = "系统预设按钮，0：否，1：是")
    @TableField("system_button")
    private CommonTypeEnum systemButton;

    /**
     * 描述信息
     */
    @ApiModelProperty(value = "描述信息")
    @TableField("`desc`")
    private String desc;

    /**
     * 按钮排序
     */
    @ApiModelProperty(value = "按钮排序")
    @TableField("order_num")
    private String orderNum;

    /**
     * 删除标识
     */
    @TableLogic
    @ApiModelProperty(value = "删除标识")
    @TableField(value = "del_flag",fill = FieldFill.INSERT)
    private Integer delFlag;


}
