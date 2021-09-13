package com.workflow.process.center.domain.entity;

import java.util.Date;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;

import java.io.Serializable;
import java.util.Date;


/**
 * 流程模型关联表单（先只控制到表级读写权限=》后期再扩展到表内字段的读写权限）(WorkFlowModelReForm)表实体类
 *
 * @author 土豆仙
 * @since 2021-07-29 09:59:07
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("流程模型关联表单（先只控制到表级读写权限=》后期再扩展到表内字段的读写权限）")
public class WorkFlowModelReForm extends BaseEntity implements Serializable {

    private static final long serialVersionUID = -58692311671172133L;

    /**
     * 模型关联表单主键
     */
    @ApiModelProperty(value = "模型关联表单主键")
    @TableId(type = IdType.AUTO)
    @TableField("id")
    private Integer id;

    /**
     * 流程模型ID
     */
    @ApiModelProperty(value = "流程模型ID")
    @TableField("pro_def_id")
    private String proDefId;

    /**
     * 表单名称
     */
    @ApiModelProperty(value = "表单名称")
    @TableField("form_name")
    private String formName;

    /**
     * 表单formKey
     */
    @ApiModelProperty(value = "表单formKey")
    @TableField("form_key")
    private String formKey;

    /**
     * 表单配置类型：0-节点表单 1-全局表单
     */
    @ApiModelProperty(value = "表单配置类型：0-节点表单 1-全局表单")
    @TableField("type")
    private Integer type;


}
