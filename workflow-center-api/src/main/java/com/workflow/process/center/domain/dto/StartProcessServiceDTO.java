package com.workflow.process.center.domain.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;
import java.util.Map;

/**
 * @Author: 土豆仙
 * @Date: 2021/7/1 15:13
 * @Description: 启动流程参数  -dubbo参数校验后续加上
 */
@Data
public class StartProcessServiceDTO implements Serializable {

    /**
     * 租户ID
     *
     */
    @ApiModelProperty(value = "发起人所在体系租户ID")
    private String tenantId;
    /**
     * 流程服务ID 必填
     */
    @ApiModelProperty(value = "流程服务ID", required = true)
    @NotBlank(message = "流程服务ID不能为空！")
    private String serviceID;

    /**
     * 流程服务编码  ID、编码二选一 必填
     */
    @ApiModelProperty(value = "流程服务编码", required = true)
    private String serviceCode;

    /**
     * 业务系统id 必填
     */
    @ApiModelProperty(value = "业务表单唯一标识-后端生成", required = true)
    private String businessKey;

    /**
     * 启动流程变量 选填
     */
    @ApiModelProperty(value = "启动流程变量")
    private Map<String, Object> variables;

    /**
     * 申请人ID 必填
     */
    @ApiModelProperty(value = "申请人ID")
    private String userId;

    /**
     * 申请人名称 必填
     */
    @ApiModelProperty(value = "申请人名称")
    private String userName;

}
