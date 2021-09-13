package com.workflow.process.center.domain.entity;

import java.util.Date;

import com.baomidou.mybatisplus.annotation.*;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;

import java.io.Serializable;
import java.util.Date;


/**
 * 流程分类(WorkFlowCategory)表实体类
 *
 * @author 土豆仙
 * @since 2021-06-21 15:59:37
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("流程分类")
public class WorkFlowCategory extends BaseEntity implements Serializable {

    private static final long serialVersionUID = -28876718788802831L;

    @ApiModelProperty(value = "分类id")
    @TableId(value = "id",type = IdType.AUTO)
    private Integer id;

    /**
     * 分类名称
     */
    @ApiModelProperty(value = "分类名称")
    @TableField("category_name")
    private String categoryName;

    /**
     * 父编号
     */
    @ApiModelProperty(value = "父编号")
    @TableField("parent_id")
    private Integer parentId;

    /**
     * 备注
     */
    @ApiModelProperty(value = "备注")
    @TableField("remark")
    private String remark;

    /**
     * 删除标识
     */
    @TableLogic
    @ApiModelProperty(value = "删除标识")
    @TableField(value = "del_flag",fill = FieldFill.INSERT)
    private Integer delFlag;


}
