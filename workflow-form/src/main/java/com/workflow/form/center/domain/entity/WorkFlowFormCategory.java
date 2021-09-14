package com.workflow.form.center.domain.entity;

import java.util.Date;

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


/**
 * 表单分类表(WorkFlowFormCategory)表实体类
 *
 * @author 土豆仙
 * @since 2021-07-29 10:54:22
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("表单分类表")
public class WorkFlowFormCategory implements Serializable {

    private static final long serialVersionUID = -77631192750668818L;

    @TableId(type = IdType.AUTO)
    private Integer id;

    /**
     * 分类编码
     */
    @ApiModelProperty(value = "分类编码")
    @TableField("code")
    private String code;

    /**
     * 分类名称
     */
    @ApiModelProperty(value = "分类名称")
    @TableField("category_name")
    private String categoryName;

    /**
     * 排序
     */
    @ApiModelProperty(value = "排序")
    @TableField("order_num")
    private Integer orderNum;

    /**
     * 上级分类id
     */
    @ApiModelProperty(value = "上级分类id")
    @TableField("parent_id")
    private Integer parentId;

    /**
     * 描述
     */
    @ApiModelProperty(value = "描述")
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
     * 更新人
     */
    @ApiModelProperty(value = "更新人")
    @TableField("updator")
    private String updator;

    /**
     * 修改时间
     */
    @ApiModelProperty(value = "修改时间")
    @TableField("update_time")
    private Date updateTime;

}
