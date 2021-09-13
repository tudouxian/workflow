package com.workflow.process.center.domain;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Set;

@Data
@ApiModel(value = "LoginUser", description = "登录用户信息")
public class LoginUser implements Serializable {
    /**
     * 用户唯一标识
     */
    @ApiModelProperty(value = "登录用户唯一标识")
    private String token;

    /**
     * 用户名id
     */
    @ApiModelProperty(value = "登录用户id")
    private Long userid;

    /**
     * 用户名
     */
    @ApiModelProperty(value = "用户名")
    private String username;

    /**
     * 用户昵称
     */
    @ApiModelProperty(value = "用户昵称")
    private String nickName;

    /**
     * 所属区域key
     */
    @ApiModelProperty(value = "所属区域")
    private String area;

    /**
     * 所属区域及管辖子区域key
     */
    @ApiModelProperty(value = "所属区域及管辖子区域")
    private Set<String> areaKeys;


    /**
     * 所属部门key
     */
    @ApiModelProperty(value = "所属部门")
    private String dept;

    /**
     * 所属部门及管辖子部门key
     */
    @ApiModelProperty(value = "所属部门及管辖子部门")
    private Set<String> deptKeys;

    /**
     * 角色列表-roleKeys
     */
    @ApiModelProperty(value = "角色列表")
    private Set<String> roles;

    /**
     * 是否是管理员
     */
    private Boolean admin;

    /**
     * 权限列表 eg: *:*:*
     */
    @ApiModelProperty(value = "权限列表")
    private Set<String> permissions;

    /**
     * 登录时间
     */
    @ApiModelProperty(value = "登录时间")
    private Long loginTime;

    /**
     * 过期时间
     */
    @ApiModelProperty(value = "过期时间")
    private Long expireTime;

    /**
     * 登录IP地址
     */
    @ApiModelProperty(value = "登录IP地址")
    private String ipaddr;


}
