package com.workflow.process.center.domain.entity;

import java.util.Date;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;


/**
 * 流程引擎扩展表-主要记录流程实例运行状态(WorkFlowExtendHisprocinst)表实体类
 *
 * @author 土豆仙
 * @since 2021-07-12 14:07:34
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("流程引擎扩展表-主要记录流程实例运行状态")
public class WorkFlowExtendHisprocinst  extends BaseEntity implements Serializable {

    private static final long serialVersionUID = -77686761899967772L;

    /**
     * 主键
     */
    @TableId(value = "id",type = IdType.AUTO)
    private Integer id;

    /**
     * 流程实例对应服务ID
     */
    @ApiModelProperty(value = "服务ID")
    @TableField("service_id")
    private String serviceID;

    /**
     * 模型key
     */
    @ApiModelProperty(value = "模型key")
    @TableField("model_key")
    private String modelKey;

    /**
     * 流程实例ID
     */
    @ApiModelProperty(value = "流程实例ID")
    @TableField("process_instance_id")
    private String processInstanceId;

    /**
     * 流程定义ID
     */
    @ApiModelProperty(value = "流程定义ID")
    @TableField("process_definition_id")
    private String processDefinitionId;

    /**
     * 业务单据KEY
     */
    @ApiModelProperty(value = "业务单据KEY")
    @TableField("business_key")
    private String businessKey;

    /**
     * 流程名称
     */
    @ApiModelProperty(value = "流程名称")
    @TableField("process_name")
    private String processName;

    /**
     * 流程状态
     */
    @ApiModelProperty(value = "流程状态")
    @TableField("process_status")
    private String processStatus;

    /**
     * 租户id(系统标识)
     */
    @ApiModelProperty(value = "租户id(系统标识)")
    @TableField("tenant_id")
    private String tenantId;

    /**
     * 删除标识1表示删除0表示存在
     */
    @TableLogic
    @ApiModelProperty(value = "删除标识0表示删除1表示存在")
    @TableField("del_flag")
    private Integer delFlag;

}
