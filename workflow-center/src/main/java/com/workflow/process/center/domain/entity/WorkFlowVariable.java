package com.workflow.process.center.domain.entity;

import com.baomidou.mybatisplus.annotation.*;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 运行时变量信息对象 act_ru_variable
 * 
 * @author 土豆仙
 * @date 2021-06-19
 */
@Data
@TableName("act_ru_variable")
public class WorkFlowVariable
{

    /** 运行时|历史 */
    @ApiModelProperty(value = "运行时|历史")
    @TableField(exist = false)
    private Boolean isRunTimeVariable  = true;

    /** 主键 */
    @ApiModelProperty(value = "主键")
    @TableId(value = "ID_",type = IdType.ASSIGN_UUID)
    private String id;

    /** 版本 */
    @ApiModelProperty(value = "版本")
    @TableField("REV_")
    @Version
    private Long rev;

    /** 变量类型 */
    @ApiModelProperty(value = "变量类型")
    @TableField("TYPE_")
    private String type;

    /** 变量名称 */
    @ApiModelProperty(value = "变量名称")
    @TableField("NAME_")
    private String name;

    /** 变量值 */
    @ApiModelProperty(value = "变量值")
    @TableField(exist = false)
    private Object variableValue;

    /** 流程实例ID */
    @ApiModelProperty(value = "流程实例ID")
    @TableField("PROC_INST_ID_")
    private String procInstId;

    /** 流程执行实例ID */
    @ApiModelProperty(value = "流程执行实例ID")
    @TableField("EXECUTION_ID_")
    private String executionId;

    /** 任务ID */
    @ApiModelProperty(value = "任务ID")
    @TableField("TASK_ID_")
    private String taskId;

    /** 作用域ID */
    @ApiModelProperty(value = "作用域ID")
    @TableField("SCOPE_ID_")
    private String scopeId;

    /** 子作用域ID */
    @ApiModelProperty(value = "子作用域ID")
    @TableField("SUB_SCOPE_ID_")
    private String subScopeId;

    /** 作用域类型 */
    @ApiModelProperty(value = "作用域类型")
    @TableField("SCOPE_TYPE_")
    private String scopeType;

    /** 字节表ID */
    @ApiModelProperty(value = "字节表ID")
    @TableField("BYTEARRAY_ID_")
    private String bytearrayId;

    /** 存储值double类型 */
    @ApiModelProperty(value = "存储值double类型")
    @TableField("DOUBLE_")
    private Long double_;

    /** 存储值long类型 */
    @ApiModelProperty(value = "存储值long类型")
    @TableField("LONG_")
    private Long long_;

    /** 存储值字符串类型 */
    @ApiModelProperty(value = "存储值字符串类型")
    @TableField("TEXT_")
    private String text;

    /** 存储值字符串类型2 */
    @ApiModelProperty(value = "存储值字符串类型2")
    @TableField("TEXT2_")
    private String text2;

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("rev", getRev())
            .append("type", getType())
            .append("name", getName())
            .append("executionId", getExecutionId())
            .append("procInstId", getProcInstId())
            .append("taskId", getTaskId())
            .append("scopeId", getScopeId())
            .append("subScopeId", getSubScopeId())
            .append("scopeType", getScopeType())
            .append("bytearrayId", getBytearrayId())
            .append("double_", getDouble_())
            .append("long_", getLong_())
            .append("text", getText())
            .append("text2", getText2())
            .toString();
    }
}
