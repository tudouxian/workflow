package com.workflow.process.center.domain.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
*   @Author: 土豆仙
*   @Date: 2021/6/27 20:15
*   @Description: 查询我发起的流程查询参数
*/
@EqualsAndHashCode(callSuper = true)
@Data
@ApiModel(value = "InstanceQueryDTO", description = "查询流程实例的参数")
public class ProcessInstanceQueryDTO extends BaseQueryDTO {

    /**
     * 业务KEY
     */
    @ApiModelProperty(value = "业务KEY-雪花算法UUID")
    private String businessKey;

    /**
     * 服务ID
     */
    @ApiModelProperty(value = "服务ID")
    private String serviceId;
    /**
     * 服务ID
     */
    @ApiModelProperty(value = "服务ID")
    private String serviceCode;
    /**
     * 服务名
     */
    @ApiModelProperty(value = "服务名")
    private String serviceName;

    /**
     * 开始时间
     */
    @ApiModelProperty(value = "开始时间")
    private String startTime;
    /**
     * 结束时间
     */
    @ApiModelProperty(value = "结束时间")
    private String endTime;

    /**
     * 流程实例ID
     */
    @ApiModelProperty(value = "流程实例ID")
    private String processInstanceId;

    /**
     * 流程实例名称
     */
    @ApiModelProperty(value = "流程实例名称")
    private String processInstanceName;

    /**
     * 流程实例名称
     */
    @ApiModelProperty(value = "流程实例名称")
    private String processName;

    /**
     * 流程状态
     */
    @ApiModelProperty(value = "流程状态")
    private String processStatus;

    /**
     * 租户ID
     *
     * @return
     */
    @ApiModelProperty(value = "发起人所在体系租户ID")
    private String tenantId;
    /**
     * 发起人所在公司ID
     *
     * @return
     */
/*    @ApiModelProperty(value = "发起人所在公司ID")
    private String companyId;*/
    /**
     * 发起人所在部门ID
     *
     * @return
     */
    @ApiModelProperty(value = "发起人所在部门ID")
    private String deptId;


    /**
     * 用户的Id
     */
    @ApiModelProperty(value = "用户的Id")
    private String userId;
    /**
     * 排序字段 1 升序  0 降序
     */
    @ApiModelProperty(value = "排序字段 1 升序  0 降序")
    private Integer orderFlag = 0;

    /**
     * 发起人工号集合
     */
    @ApiModelProperty(value = "发起人工号集合")
    private String startedUserIds;
    /**
     * 流程定义KEY
     */
    @ApiModelProperty(value = "流程定义KEY")
    private String processDefinitionKey;

    /**
     * 查询关键字
     */
    @ApiModelProperty(value = "查询关键字")
    private String keyword;


}
