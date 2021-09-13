package com.workflow.process.center.domain.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.List;
import java.util.Set;

/**
*   @Author: 土豆仙
*   @Date: 2021/6/28 0:13
*   @Description: 待办、已办查询参数
*/
@EqualsAndHashCode(callSuper = true)
@Data
@ApiModel(value = "TaskQueryDTO", description = "查询任务实例的参数")
public class TaskQueryDTO  extends BaseQueryDTO{
    //系统标识
    @ApiModelProperty(
            value = "系统标识列表",
            example = "lczx"
    )
    private List<String> tenantIds;

    @ApiModelProperty(
            value = "系统标识",
            example = "lczx"
    )
    private String tenantId;

    @ApiModelProperty(
            value = "服务Id",
            example = "111"
    )
    private String serviceId;

    private String serviceCode;

    //开始时间
    @ApiModelProperty(
            value = "开始时间",
            example = "2020-08-05 08:12:41"
    )
    private String startTime;
    //结束时间
    @ApiModelProperty(
            value = "结束时间",
            example = "2020-08-05 08:12:41"
    )
    private String endTime;
    //流程实例ID
    @ApiModelProperty(
            value = "流程名称",
            example = "工时申报单"
    )
    private String processName;
    //业务关联key
    @ApiModelProperty(
            value = "业务主键",
            example = "1234656"
    )
    private String businessKey;
    //待办人
    @ApiModelProperty(
            value = "待办人id",
            example = "13"
    )
    private String assignee;
    /**
     * 组标识列表 roleKeys、deptKeys、areas
     */
    @ApiModelProperty(value = "角色列表")
    private Set<String> groups;
    //用户的工号
    @ApiModelProperty(
            value = "当前操作用户",
            example = "00004737"
    )
    private String userId;

    @ApiModelProperty(
            value = "节点名称",
            example = "部门经理审批"
    )
    //节点名称
    private String taskName;

    @ApiModelProperty(
            value = "查询关键字",
            example = "财务"
    )
    private String keyword;
}
