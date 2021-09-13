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
 * 节点对流程模型关联的表单的权限(WorkFlowModelReFormReActivity)表实体类
 *
 * @author 土豆仙
 * @since 2021-07-29 09:59:36
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("节点对流程模型关联的表单的权限")
public class WorkFlowModelReFormReActivity  extends BaseEntity  implements Serializable {

    private static final long serialVersionUID = 208736282767526966L;

    /**
     * 主键
     */
    @ApiModelProperty(value = "主键")
    @TableId(type = IdType.AUTO)
    @TableField("id")
    private Integer id;

    /**
     * 模型关联表单ID
     */
    @ApiModelProperty(value = "模型关联表单ID")
    @TableField("model_re_form_id")
    private String modelReFormId;

    /**
     * 冗余字段-表单formKey-后期关联表内字段权限
     */
    @ApiModelProperty(value = "冗余字段-表单formKey-后期关联表内字段权限")
    @TableField("form_key")
    private String formKey;

    /**
     * 流程模型节点ID
     */
    @ApiModelProperty(value = "流程模型节点ID")
    @TableField("activity_id")
    private String activityId;

    /**
     * 权限级别：0-无 1-可读 2-可写
     */
    @ApiModelProperty(value = "权限级别：0-无 1-可读 2-可写")
    @TableField("auth_level")
    private Integer authLevel;


}
