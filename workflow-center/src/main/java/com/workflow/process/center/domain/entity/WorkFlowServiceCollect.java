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
 * 服务收藏表(WorkFlowServiceCollect)表实体类
 *
 * @author 土豆仙
 * @since 2021-07-03 09:34:31
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("服务收藏表")
public class WorkFlowServiceCollect extends BaseEntity implements Serializable {

    private static final long serialVersionUID = 606197429236793155L;

    /**
     * 自增id
     */
    @ApiModelProperty(value = "自增id")
    @TableId(value = "id",type = IdType.AUTO)
    private Integer id;

    /**
     * 服务id
     */
    @ApiModelProperty(value = "服务id")
    @TableField("service_id")
    private Integer serviceId;

    /**
     * 0-未收藏,1-收藏
     */
    @ApiModelProperty(value = "0-未收藏,1-收藏")
    @TableField("collect_status")
    private Object collectStatus;

    /**
     * 用户id
     */
    @ApiModelProperty(value = "用户id")
    @TableField("user_id")
    private Integer userId;

    /**
     * 系统标识-租户ID
     */
    @ApiModelProperty(value = "系统标识-租户ID")
    @TableField("tenant_id")
    private String tenantId;


}
