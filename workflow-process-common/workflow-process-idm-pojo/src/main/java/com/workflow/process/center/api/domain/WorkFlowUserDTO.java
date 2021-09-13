package com.workflow.process.center.api.domain;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;


/**
 * 工作流用户
 *
 * @author 土豆仙
 * @since 2021-06-23 15:17:42
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("工作流用户表")
public class WorkFlowUserDTO implements Serializable {

    private static final long serialVersionUID = 748114183109149030L;

    /** 用户ID */
    @ApiModelProperty(value = "用户ID")
    private String userId;

    /** 部门ID */
    @ApiModelProperty(value = "部门ID")
    private String deptId;

    @ApiModelProperty(value = "拥有部门")
    private String deptName;

    /** 区域ID =>递推设置上级区域用到 */
    @ApiModelProperty(value = "区域ID")
    private String areaId;

    /** 用户账号 */
    @ApiModelProperty(value = "用户账号")
    private String userName;

    /** 用户昵称 */
    @ApiModelProperty(value = "用户昵称")
    private String nickName;

    /** 用户邮箱 */
    @ApiModelProperty(value = "用户邮箱")
    private String email;

    /** 手机号码 */
    @ApiModelProperty(value = "手机号码")
    private String phonenumber;


    /** 用户性别 */
    @ApiModelProperty(value = "用户性别")
    private String sex;


    /** 帐号状态（0正常 1停用） */
    @ApiModelProperty(value = "帐号状态（0正常 1停用）")
    private String status;

    /** 用户头像 */
   /* @ApiModelProperty(value = "用户头像")
    private String avatar;*/

    /** 密码 */
    @ApiModelProperty(value = "密码")
    private String password;

    /** 盐加密 */
   /* @ApiModelProperty(value = "盐加密")
    private String salt;*/

    /** 删除标志（0代表存在 2代表删除） */
  /*  @ApiModelProperty(value = "删除标志（0代表存在 2代表删除）")
    private String delFlag;*/

    /** 最后登录IP */
   /* @ApiModelProperty(value = "最后登录IP")
    private String loginIp;*/

    /** 最后登录时间 */
  /*  @ApiModelProperty(value = "最后登录时间")
    private String loginDate;*/


    /*@ApiModelProperty(value = "拥有角色")
    private String roleNames;*/

    /**
     * 租户ID
     */
   /* @ApiModelProperty(value = "租户ID")
    private String tenantId;*/


}
