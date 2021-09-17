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

    /** 主键 */
    @ApiModelProperty(value = "主键")
    @TableId(value = "id",type = IdType.ASSIGN_UUID)
    private String id;

    /** 版本 */
    @ApiModelProperty(value = "版本")
    @TableField("rev")
    @Version
    private Long rev;

    /** 变量类型 */
    @ApiModelProperty(value = "变量类型")
    @TableField("type")
    private String type;

    /** 变量名称 */
    @ApiModelProperty(value = "变量名称")
    @TableField("name")
    private String name;

    /** 变量值 */
    @ApiModelProperty(value = "变量值")
    @TableField(exist = false)
    private Object variableValue;

    /** 流程实例ID */
    @ApiModelProperty(value = "流程实例ID")
    @TableField("procInstId")
    private String procInstId;

    /** 流程执行实例ID */
    @ApiModelProperty(value = "流程执行实例ID")
    @TableField("executionId")
    private String executionId;

    /** 任务ID */
    @ApiModelProperty(value = "任务ID")
    @TableField("taskId")
    private String taskId;

    /** 作用域ID */
    @ApiModelProperty(value = "作用域ID")
    @TableField("scopeId")
    private String scopeId;

    /** 子作用域ID */
    @ApiModelProperty(value = "子作用域ID")
    @TableField("subScopeId")
    private String subScopeId;

    /** 作用域类型 */
    @ApiModelProperty(value = "作用域类型")
    @TableField("scopeType")
    private String scopeType;

    /** 字节表ID */
    @ApiModelProperty(value = "字节表ID")
    @TableField("bytearrayId")
    private String bytearrayId;

    /** 存储值double类型 */
    @ApiModelProperty(value = "存储值double类型")
    @TableField("double_")
    private Long double_;

    /** 存储值long类型 */
    @ApiModelProperty(value = "存储值long类型")
    @TableField("long_")
    private Long long_;

    /** 存储值字符串类型 */
    @ApiModelProperty(value = "存储值字符串类型")
    @TableField("text")
    private String text;

    /** 存储值字符串类型2 */
    @ApiModelProperty(value = "存储值字符串类型2")
    @TableField("text2")
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
