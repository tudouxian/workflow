package com.workflow.form.center.domain.entity;

import java.util.Date;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;


/**
 * 表单模型信息表(WorkFlowFormModelInfo)表实体类
 *
 * @author 土豆仙
 * @since 2021-07-29 10:55:18
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("表单模型信息表")
public class WorkFlowFormModelInfo implements Serializable {

    private static final long serialVersionUID = 189607474375478436L;

    /**
     * 表单模型信息主键
     */
    @ApiModelProperty(value = "表单模型信息主键")
    @TableId(value = "model_info_id",type = IdType.AUTO)
    private Integer modelInfoId;

    /**
     * 表单分类ID
     */
    @ApiModelProperty(value = "表单分类ID")
    @TableField("category_id")
    private Integer categoryId;

    /**
     * 表单分类名称
     */
    @ApiModelProperty(value = "表单分类名称")
    @TableField("category_name")
    private String categoryName;

    /**
     * 表单名称
     */
    @ApiModelProperty(value = "表单名称")
    @TableField("form_name")
    private String formName;

    /**
     * 主版本formKey=》用于关联工作流
     */
    @ApiModelProperty(value = "主版本formKey=》用于关联工作流")
    @TableField("form_key")
    private String formKey;

    /**
     * 主版本版本号
     */
    @ApiModelProperty(value = "主版本版本号")
    @TableField("version")
    private Integer version;

    /**
     * 默认：0-外部表单 1-自定义表单
     */
    @ApiModelProperty(value = "默认：0-外部表单 1-自定义表单")
    @TableField("form_model_type")
    private Object formModelType;

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

    /**
     * 删除标识1表示删除0表示存在
     */
    @ApiModelProperty(value = "删除标识1表示删除0表示存在")
    @TableField("del_flag")
    private Integer delFlag;

}
