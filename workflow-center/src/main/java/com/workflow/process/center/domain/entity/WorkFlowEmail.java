package com.workflow.process.center.domain.entity;

import java.util.Date;

import com.baomidou.mybatisplus.annotation.*;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;


/**
 * 租户邮箱服务配置(WorkFlowEmail)表实体类
 *
 * @author 土豆仙
 * @since 2021-09-06 10:58:01
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("租户邮箱服务配置")
public class WorkFlowEmail implements Serializable {

    private static final long serialVersionUID = -47774234893417299L;

    /**
     * 主键
     */
    @ApiModelProperty(value = "主键")
    @TableId(type = IdType.AUTO)
    @TableField("id")
    private Integer id;

    /**
     * 租户标示
     */
    @ApiModelProperty(value = "租户标示")
    @TableField("tennat_id")
    private String tennatId;

    /**
     * 邮箱服务eg:smtp.163.com
     */
    @ApiModelProperty(value = "邮箱服务eg:smtp.163.com")
    @TableField("mail_server_host")
    private String mailServerHost;

    /**
     * 邮箱服务端口eg:465
     */
    @ApiModelProperty(value = "邮箱服务端口eg:465")
    @TableField("mail_server_port")
    private Integer mailServerPort;

    /**
     * 邮箱服务默认发送邮箱
     */
    @ApiModelProperty(value = "邮箱服务默认发送邮箱")
    @TableField("mail_default_from")
    private String mailDefaultFrom;

    /**
     * 邮箱服务
     */
    @ApiModelProperty(value = "邮箱服务")
    @TableField("mail_username")
    private String mailUsername;

    /**
     * 系统url前缀
     */
    @ApiModelProperty(value = "系统url前缀")
    @TableField("mail_password")
    private String mailPassword;

    /**
     * 是否使用SSL-0-是  1-否
     */
    @ApiModelProperty(value = "是否使用SSL-0-是  1-否")
    @TableField("mail_ssl")
    private Boolean mailSsl;

    /**
     * 邮箱备注
     */
    @ApiModelProperty(value = "邮箱备注")
    @TableField("note")
    private String note;

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
     * 更新时间
     */
    @ApiModelProperty(value = "更新时间")
    @TableField("update_time")
    private Date updateTime;

    /**
     * 更新人
     */
    @ApiModelProperty(value = "更新人")
    @TableField("updator")
    private String updator;

    /**
     * 删除标识1表示删除0表示存在
     */
    @ApiModelProperty(value = "删除标识1表示删除0表示存在")
    @TableLogic
    @TableField(value = "del_flag",fill = FieldFill.INSERT)
    private Integer delFlag;

}
