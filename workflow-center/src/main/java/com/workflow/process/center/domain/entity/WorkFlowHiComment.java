package com.workflow.process.center.domain.entity;

import java.util.Date;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableField;
import com.workflow.process.center.common.enums.entity.CommentTypeEnum;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;

import java.io.Serializable;


/**
 * (WorkFlowHiComment)表实体类
 *
 * @author 土豆仙
 * @since 2021-07-20 15:54:05
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("自定义审核操作记录表")
public class WorkFlowHiComment extends BaseEntity implements Serializable {

    private static final long serialVersionUID = -86057457613027025L;

    /**
     * 主键
     */
    @ApiModelProperty(value = "主键")
    @TableId(value = "id",type = IdType.AUTO)
    private Integer id;

    /**
     * 审核类型
     */
    @ApiModelProperty(value = "类型")
    @TableField("type")
    private CommentTypeEnum commentTypeEnum;

    /**
     * 员工工号
     */
    @ApiModelProperty(value = "员工工号")
    @TableField("user_id")
    private String userId;

    /**
     * 员工姓名
     */
    @ApiModelProperty(value = "员工姓名")
    @TableField("user_name")
    private String userName;

    /**
     * 审批时间
     */
    @ApiModelProperty(value = "审批时间")
    @TableField("time")
    private Date time;

    /**
     * 任务ID
     */
    @ApiModelProperty(value = "任务ID")
    @TableField("task_id")
    private String taskId;

    /**
     * 任务名称
     */
    @ApiModelProperty(value = "任务名称")
    @TableField("task_name")
    private String taskName;

    /**
     * 活动节点ID
     */
    @ApiModelProperty(value = "活动节点ID")
    @TableField("activity_id")
    private String activityId;

    /**
     * 活动节点名称
     */
    @ApiModelProperty(value = "活动节点名称")
    @TableField("activity_name")
    private String activityName;

    /**
     * 流程实例id
     */
    @ApiModelProperty(value = "流程实例id")
    @TableField("process_ins_id")
    private String processInsId;

    /**
     * 动作
     */
    @ApiModelProperty(value = "动作")
    @TableField("action")
    private String action;

    /**
     * 审批意见
     */
    @ApiModelProperty(value = "审批意见")
    @TableField("message")
    private String message;


    /**
     * 删除标识1：删除 0:存在
     */
    @ApiModelProperty(value = "删除标识1：删除 0:存在")
    @TableField("del_flag")
    private Integer delFlag;

    /**
     * 系统标识-租户ID
     */
    @ApiModelProperty(value = "系统标识-租户ID")
    @TableField("tenant_id")
    private String tenantId;

}
