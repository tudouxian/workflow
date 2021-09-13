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
 * 服务指南配置(WorkFlowServiceGuide)表实体类
 *
 * @author 土豆仙
 * @since 2021-07-03 09:34:57
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("服务指南配置")
public class WorkFlowServiceGuide extends BaseEntity implements Serializable {

    private static final long serialVersionUID = 666973936550185336L;

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
     * 服务名称
     */
    @ApiModelProperty(value = "服务名称")
    @TableField("service_name")
    private String serviceName;

    /**
     * 基本信息
     */
    @ApiModelProperty(value = "基本信息")
    @TableField("basic_info")
    private String basicInfo;

    /**
     * 办理流程
     */
    @ApiModelProperty(value = "办理流程")
    @TableField("processing_info")
    private String processingInfo;

    /**
     * 注意事项
     */
    @ApiModelProperty(value = "注意事项")
    @TableField("attention_info")
    private String attentionInfo;

    /**
     * 注意事项
     */
    @ApiModelProperty(value = "注意事项")
    @TableField("question_info")
    private String questionInfo;

    /**
     * 咨询方式
     */
    @ApiModelProperty(value = "咨询方式")
    @TableField("consultation")
    private String consultation;


}
