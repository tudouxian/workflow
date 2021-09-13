package com.workflow.process.center.domain.entity;

import java.util.Date;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;


/**
 * 流程监听器(WorkFlowListenerParam)表实体类
 *
 * @author 土豆仙
 * @since 2021-08-23 15:16:00
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("流程监听器")
public class WorkFlowListenerParam implements Serializable {

    private static final long serialVersionUID = -86715433788682931L;

    /**
     * 主键id
     */
    @ApiModelProperty(value = "主键id")
    @TableId(type = IdType.AUTO)
    @TableField("id")
    private Integer id;

    /**
     * 监听器ID
     */
    @ApiModelProperty(value = "监听器ID")
    @TableField("listener_id")
    private String listenerId;

    /**
     * 监听器参数名称
     */
    @ApiModelProperty(value = "监听器参数名称")
    @TableField("param_name")
    private String paramName;

    /**
     * 监听器参数类型-0.字符串 1.表达式
     */
    @ApiModelProperty(value = "监听器参数类型-0.字符串 1.表达式")
    @TableField("param_type")
    private Integer paramType;

    /**
     * 监听器参数值
     */
    @ApiModelProperty(value = "监听器参数值")
    @TableField("param_value")
    private String paramValue;

    /**
     * 是否必填
     */
    @ApiModelProperty(value = "是否必填")
    @TableField("required")
    private Integer required;

    /**
     * 备注-描述
     */
    @ApiModelProperty(value = "备注-描述")
    @TableField("`desc`")
    private String desc;

    /**
     * 创建人
     */
    @ApiModelProperty(value = "创建人")
    @TableField("creator")
    private String creator;

    /**
     * 创建时间
     */
    @ApiModelProperty(value = "创建时间")
    @TableField("create_time")
    private Date createTime;

    /**
     * 更新时间
     */
    @ApiModelProperty(value = "更新时间")
    @TableField("update_time")
    private Date updateTime;

    /**
     * 更新人
     */
    @ApiModelProperty(value = "更新人")
    @TableField("updator")
    private String updator;

    /**
     * 删除标识1表示删除0表示存在
     */
    @ApiModelProperty(value = "删除标识1表示删除0表示存在")
    @TableField(value = "del_flag",fill = FieldFill.INSERT)
    private Integer delFlag;

}
