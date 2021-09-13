package com.workflow.process.center.domain.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @Author: 土豆仙
 * @Date: 2021/6/28 0:05
 * @Description: 待办、已办VO
 */
@ApiModel(value = "TaskVO", description = "待办已办任务视图")
@Data
public class TaskDTO implements Serializable {

    /**
     * 任务id
     */
    @ApiModelProperty(value = "任务ID")
    private String taskId;

    /**
     * 服务名
     */
    @ApiModelProperty(value = "服务名")
    private String serviceName;

    /**
     * 任务名称
     */
    @ApiModelProperty(value = "任务名称")
    private String taskName;

    /**
     * 任务创建时间
     */
    @ApiModelProperty(value = "任务创建时间")
    private Date taskCreateTime;

    /**
     * 任务限定时间
     */
    @ApiModelProperty(value = "任务限定时间")
    private Date dueDate;

    /**
     * 任务结束时间
     */
    @ApiModelProperty(value = "任务结束时间")
    private Date taskEndTime;

    /**
     * 已办任务消耗时间
     */
    @ApiModelProperty(value = "已办任务消耗时间")
    private Long duration;

    /**
     * 任务停留小时-填充
     */
    @ApiModelProperty(value = "任务停留时间")
    private String taskStayHour;

    /**
     * 审批人 id
     */
    @ApiModelProperty(value = "当前审批人ID")
    private String assignee;

    /**
     * 审批人 姓名  -填充
     */
    @ApiModelProperty(value = "当前审批人")
    private String assigneeName;

    /**
     * 任务描述
     */
    @ApiModelProperty(value = "任务描述")
    private String description;

    /**
     * 任务定义key
     */
    @ApiModelProperty(value = "任务定义key")
    private String taskDefKey;

    /**
     * 任务分类
     */
    @ApiModelProperty(value = "任务分类")
    private String taskCategory;

    /**
     * 业务关联key
     */
    @ApiModelProperty(value = "业务关联key")
    private String businessKey;

    /**
     * 流程实例的id
     */
    @ApiModelProperty(value = "流程实例的ID")
    private String processInstId;

    /**
     * 流程定义的id
     */
    @ApiModelProperty(value = "流程定义的ID")
    private String processDefId;

    /**
     * 流程定义key
     */
    @ApiModelProperty(value = "流程定义key")
    private String processDefKey;

    /**
     * 流程定义名称
     */
    @ApiModelProperty(value = "流程定义名称")
    private String processDefName;

    /**
     * 流程启动时间
     */
    @ApiModelProperty(value = "流程启动时间")
    private Date processStartTime;

    /**
     * 流程结束时间
     */
    @ApiModelProperty(value = "流程结束时间")
    private Date processEndTime;

    /**
     * 流程总耗时
     */
    @ApiModelProperty(value = "流程总耗时")
    private String totalTime;

    /**
     * 流程启动人
     */
    @ApiModelProperty(value = "流程启动人ID")
    private String startUserId;

    /**
     * 流程启动人名称-填充
     */
    @ApiModelProperty(value = "流程启动人名称")
    private String startUserName;

    /**
     * 流程实例状态
     */
    @ApiModelProperty(value = "流程实例状态")
    private String processStatus;

    /**
     * 翻译后的流程实例状态名称  -填充
     */
    @ApiModelProperty(value = "流程实例状态名称")
    private String processStatusName;

    /**
     * 租户名称
     */
    @ApiModelProperty(value = "租户名称")
    private String tenantName;


}
