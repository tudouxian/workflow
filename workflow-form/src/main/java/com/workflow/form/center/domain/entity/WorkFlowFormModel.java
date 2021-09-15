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
 * 自定义表单模型表(WorkFlowFormModel)表实体类
 *
 * @author 土豆仙
 * @since 2021-07-29 10:54:57
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("自定义表单模型表")
public class WorkFlowFormModel implements Serializable {

    private static final long serialVersionUID = 755961126202787381L;

    @TableId(value = "model_id",type = IdType.AUTO)
    private Integer modelId;

    /**
     * 表单模型id
     */
    @ApiModelProperty(value = "表单模型id")
    @TableField("model_info_id")
    private Integer modelInfoId;

    /**
     * 表单唯一标识Key：用于关联流程
     */
    @ApiModelProperty(value = "表单唯一标识Key：用于关联流程")
    @TableField("form_key")
    private String formKey;

    /**
     * 表单配置json
     */
    @ApiModelProperty(value = "表单配置json")
    @TableField("form_json")
    private Object formJson;

    /**
     * 状态值-0：pc表单 1：移动端表单
     */
    @ApiModelProperty(value = "状态值-0：pc表单 1：移动端表单")
    @TableField("form_type")
    private Object formType;

    /**
     * 状态1-未发布，2-已发布
     */
    @ApiModelProperty(value = "状态1-未发布，2-已发布")
    @TableField("status")
    private String status;

    /**
     * 是否为主版本
     */
    @ApiModelProperty(value = "是否为主版本")
    @TableField("main_version")
    private Object mainVersion;

    /**
     * 表单表头字段配置
     */
    @ApiModelProperty(value = "表单表头字段配置")
    @TableField("config_json")
    private Object configJson;

    /**
     * 版本说明
     */
    @ApiModelProperty(value = "版本说明")
    @TableField("release_note")
    private String releaseNote;

    /**
     * 版本号
     */
    @ApiModelProperty(value = "版本号")
    @TableField("version")
    private Integer version;

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
