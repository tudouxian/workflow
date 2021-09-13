package com.workflow.process.center.domain.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.util.Map;
/**
*   @Author: 土豆仙
*   @Date: 2021/7/1 15:13
*   @Description: 启动流程参数
*/
@Data
public class StartProcessInstanceByKeyDTO {

    /**
     * 流程定义key 必填
     */
    @ApiModelProperty(value = "流程定义key", required = true)
    @NotBlank(message = "流程定义key不能为空！")
    private String processDefinitionKey;
    /**
     * 启动流程变量 选填
     */
    @ApiModelProperty(value = "启动流程变量")
    private Map<String, Object> variables;

    /**
     * 业务系统id 必填
     */
    @ApiModelProperty(value = "业务表单唯一标识-后端生成", required = true)
    private String businessKey;
    /**
     * 申请人工号 必填
     */
    @ApiModelProperty(value = "申请人工号-后端注入")
    private String currentUserId;
    /**
     * 流程提交人工号 必填
     */
    @ApiModelProperty(value = "流程提交人工号 通常和申请人工号一致即可-后端注入", required = true)
    private String creator;
    /**
     * 要走流程部门ID
     */
    @ApiModelProperty(value = "要走流程部门ID-后端注入")
    private String deptId;
    /**
     * 系统标识 必填
     */
    @ApiModelProperty(value = "租户Id-后端注入", required = true)
    @NotBlank(message = "服务启动，租户ID不能为空！")
    private String tenantId;
    /**
     * 表单显示名称 必填
     */
    @ApiModelProperty(value = "表单显示名称", required = true)
    private String formName;
    /**
     * 老的流程实例id
     */
   /* @ApiModelProperty(value = "老的流程实例id")
    private String oldProcessInstanceId;*/

    /**
     * 是否走底表数据
     */
   /* @ApiModelProperty(value = "是否走底表数据")
    private boolean flowLevelFlag = true;*/
}
