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
 * 流程表达式(WorkFlowExpression)表实体类
 *
 * @author 土豆仙
 * @since 2021-08-23 16:24:52
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("流程表达式")
public class WorkFlowExpression implements Serializable {

    private static final long serialVersionUID = 526173574494154438L;

    /**
     * 主键id
     */
    @ApiModelProperty(value = "主键id")
    @TableId(type = IdType.AUTO)
    @TableField("id")
    private Integer id;

    /**
     * 表达式名称
     */
    @ApiModelProperty(value = "表达式名称")
    @TableField("expression_name")
    private String expressionName;

    /**
     * 表达式内容
     */
    @ApiModelProperty(value = "表达式内容")
    @TableField("expression_value")
    private String expressionValue;

    /**
     * 系统预设表达式,0:是，1:否
     */
    @ApiModelProperty(value = "系统预设表达式,0:是，1:否")
    @TableField("system_expression")
    private Integer systemExpression;

    /**
     * 描述信息
     */
    @ApiModelProperty(value = "描述信息")
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
     * 删除标识0表示删除1表示存在
     */
    @ApiModelProperty(value = "删除标识0表示删除1表示存在")
    @TableField(value = "del_flag",fill = FieldFill.INSERT)
    private Integer delFlag;

}
