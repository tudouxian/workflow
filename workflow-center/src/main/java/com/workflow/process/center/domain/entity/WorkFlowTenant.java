package com.workflow.process.center.domain.entity;

import java.util.Date;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;

import java.io.Serializable;
import java.util.Date;


/**
 * (WorkFlowTenant)表实体类
 *
 * @author 土豆仙
 * @since 2021-06-30 10:44:54
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("租户")
public class WorkFlowTenant extends BaseEntity implements Serializable {

    private static final long serialVersionUID = 269084702289915597L;

    @ApiModelProperty(value = "租户id")
    @TableId(value = "id",type = IdType.AUTO)
    private Integer id;

    /**
     * 系统标示
     */
    @ApiModelProperty(value = "系统标示")
    @TableField("tennat_id")
    private String tennatId;

    /**
     * 名称
     */
    @ApiModelProperty(value = "名称")
    @TableField("tenant_name")
    private String tenantName;

    @ApiModelProperty(value = "租户状态值")
    @TableField("status")
    private Integer status;

    @ApiModelProperty(value = "租户密钥")
    @TableField("secret_key")
    private String secretKey;

    /**
     * 系统url前缀
     */
    @ApiModelProperty(value = "系统url前缀")
    @TableField("url")
    private String url;

    /**
     * 系统的图标
     */
    @ApiModelProperty(value = "系统的图标")
    @TableField("image")
    private String image;

    /**
     * 系统备注
     */
    @ApiModelProperty(value = "系统备注")
    @TableField("note")
    private String note;


    /**
     * 删除标识1：删除0：存在
     */
    @TableLogic
    @ApiModelProperty(value = "删除标识0：删除1：存在")
    @TableField("del_flag")
    private Integer delFlag;

}
