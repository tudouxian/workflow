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
 * 流程监听器(WorkFlowListener)表实体类
 *
 * @author 土豆仙
 * @since 2021-08-23 15:15:21
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("流程监听器")
public class WorkFlowListener implements Serializable {

    private static final long serialVersionUID = 238139756491352668L;

    /**
     * 主键id
     */
    @ApiModelProperty(value = "主键id")
    @TableId(value = "id",type = IdType.AUTO)
    private Integer id;

    /**
     * 监听器名称
     */
    @ApiModelProperty(value = "监听器名称")
    @TableField("listener_name")
    private String listenerName;

    /**
     * 监听器类型1-执行监听器，2-任务监听器
     */
    @ApiModelProperty(value = "监听器类型1-执行监听器，2-任务监听器")
    @TableField("listener_type")
    private Integer listenerType;

    /**
     * 事件类型（1.创建、2.指派、3.完成、4.删除）
     */
    @ApiModelProperty(value = "事件类型（1.创建、2.指派、3.完成、4.删除）")
    @TableField("event_type")
    private String eventType;

    /**
     * 值类型1-类，2-表达式，3-委托表达式
     */
    @ApiModelProperty(value = "值类型1-类，2-表达式，3-委托表达式")
    @TableField("value_type")
    private String valueType;

    /**
     * 监听器值
     */
    @ApiModelProperty(value = "监听器值")
    @TableField("listener_value")
    private String listenerValue;

    /**
     * 是否是系统预设监听器（0.是、1.否）
     */
    @ApiModelProperty(value = "是否是系统预设监听器（0.是、1.否）")
    @TableField("system_listener")
    private Integer systemListener;

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
