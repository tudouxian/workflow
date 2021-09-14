package com.workflow.form.center.domain.entity;

import java.util.Date;

import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;


/**
 * 字典数据表(DictData)表实体类
 *
 * @author 土豆仙
 * @since 2021-08-10 14:35:42
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("字典数据表")
public class DictData implements Serializable {

    private static final long serialVersionUID = 309133086968894823L;

    /**
     * 字典编码
     */
    @ApiModelProperty(value = "字典编码")
    @TableField("dict_code")
    private Long dictCode;

    /**
     * 字典排序
     */
    @ApiModelProperty(value = "字典排序")
    @TableField("dict_sort")
    private Integer dictSort;

    /**
     * 字典标签
     */
    @ApiModelProperty(value = "字典标签")
    @TableField("dict_label")
    private String dictLabel;

    /**
     * 字典键值
     */
    @ApiModelProperty(value = "字典键值")
    @TableField("dict_value")
    private String dictValue;

    /**
     * 字典类型
     */
    @ApiModelProperty(value = "字典类型")
    @TableField("dict_type")
    private String dictType;

    /**
     * 样式属性（其他样式扩展）
     */
    @ApiModelProperty(value = "样式属性（其他样式扩展）")
    @TableField("css_class")
    private String cssClass;

    /**
     * 表格回显样式
     */
    @ApiModelProperty(value = "表格回显样式")
    @TableField("list_class")
    private String listClass;

    /**
     * 是否默认（Y是 N否）
     */
    @ApiModelProperty(value = "是否默认（Y是 N否）")
    @TableField("is_default")
    private String isDefault;

    /**
     * 状态（0正常 1停用）
     */
    @ApiModelProperty(value = "状态（0正常 1停用）")
    @TableField("status")
    private String status;

    /**
     * 创建者
     */
    @ApiModelProperty(value = "创建者")
    @TableField("create_by")
    private String createBy;

    /**
     * 创建时间
     */
    @ApiModelProperty(value = "创建时间")
    @TableField("create_time")
    private Date createTime;

    /**
     * 更新者
     */
    @ApiModelProperty(value = "更新者")
    @TableField("update_by")
    private String updateBy;

    /**
     * 更新时间
     */
    @ApiModelProperty(value = "更新时间")
    @TableField("update_time")
    private Date updateTime;

    /**
     * 备注
     */
    @ApiModelProperty(value = "备注")
    @TableField("remark")
    private String remark;

}
