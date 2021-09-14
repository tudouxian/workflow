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
 * 字典类型表(DictType)表实体类
 *
 * @author 土豆仙
 * @since 2021-08-10 14:34:56
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("字典类型表")
public class DictType implements Serializable {

    private static final long serialVersionUID = 385441793557343237L;

    /**
     * 字典主键
     */
    @ApiModelProperty(value = "字典主键")
    @TableField("dict_id")
    private Long dictId;

    /**
     * 字典名称
     */
    @ApiModelProperty(value = "字典名称")
    @TableField("dict_name")
    private String dictName;

    /**
     * 字典类型
     */
    @ApiModelProperty(value = "字典类型")
    @TableField("dict_type")
    private String dictType;

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
