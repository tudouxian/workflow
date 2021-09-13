package com.workflow.process.center.domain.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @Author: 土豆仙
 * @Date: 2021/6/27 22:40
 * @Description: 流程实例的VO
 */
@Data
@ApiModel(value = "ProcessInstanceVO", description = "查询流程实例返回对象")
public class ProcessInstanceDTO implements Serializable {

    /**
     * 服务名
     */
    @ApiModelProperty(value = "服务名")
    private String serviceName;

    /**
     * 业务关联key
     */
    @ApiModelProperty(value = "业务关联key")
    private String businessKey;

    /**
     * 流程实例id
     */
    @ApiModelProperty(value = "流程实例ID")
    private String processInstanceId;
    /**
     * 流程实例的名称
     */
    @ApiModelProperty(value = "流程实例的名称")
    private String processInstanceName;
    /**
     * 流程定义id
     */
    @ApiModelProperty(value = "流程定义ID")
    private String processDefinitionId;
    /**
     * 流程定义的名称
     */
    @ApiModelProperty(value = "流程定义的名称")
    private String processDefinitionName;
    /**
     * 流程定义的key
     */
    @ApiModelProperty(value = "流程定义的key")
    private String processDefinitionKey;

    /**
     * 应用标识-租户Id
     */
    @ApiModelProperty(value = "租户标识")
    private String tenantId;
    /**
     * 系统名称
     */
    @ApiModelProperty(value = "租户名称")
    private String tenantName;

    /**
     * 流程实例状态 @see {@link }
     */
    @ApiModelProperty(value = "流程实例状态")
    private String processStatus;

    /**
     * 翻译后的流程实例状态名称
     */
    @ApiModelProperty(value = "流程实例状态展示")
    private String processStatusName;

    /**
     * 流程的创建时间
     */
    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty(value = "流程的创建时间")
    private Date startTime;
    /**
     * 结束时间
     */
    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty(value = "流程的结束时间")
    private Date endTime;

    /**
     * 总耗时
     */
    @ApiModelProperty(value = "总耗时")
    private String totalTime;
    /**
     * 当前办理人
     */
    @ApiModelProperty(value = "当前办理人")
    private List<AssigneeDTO> currentAssignees;

    /**
     * 当前候选人、组
     */
    @ApiModelProperty(value = "当前候选人")
    private List<AssigneeDTO> currentCandidateUsers;

    /**
     * 当前候选组
     */
    @ApiModelProperty(value = "当前候选人")
    private Map<String,List<AssigneeDTO>> currentCandidateGroups;

    /**
     * 挂起状态   1激活 2挂起   @see ProcessInstanceStatusEnum
     */
    /* private Boolean pState;*/

    /**
     * 创建人的id
     */
    private String startedUserId;
    /**
     * 创建人的名称
     */
    private String startedUserName;
    /**
     * 创建人部门名称
     */
    private String startedUserDeptName;

}
