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
 * 服务与服务分类关联表-服务可以配置在多个分类下(WorkFlowServiceRelCategory)表实体类
 *
 * @author 土豆仙
 * @since 2021-07-03 09:35:23
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("服务与服务分类关联表-服务可以配置在多个分类下")
public class WorkFlowServiceRelCategory extends BaseEntity implements Serializable {

    private static final long serialVersionUID = 189962627768732849L;

    /**
     * 主键id
     */
    @ApiModelProperty(value = "主键id")
    @TableId(value = "id",type = IdType.AUTO)
    private Integer id;

    /**
     * 服务id
     */
    @ApiModelProperty(value = "服务id")
    @TableField("service_id")
    private Integer serviceId;

    /**
     * 分类id
     */
    @ApiModelProperty(value = "分类id")
    @TableField("category_id")
    private Integer categoryId;


}
