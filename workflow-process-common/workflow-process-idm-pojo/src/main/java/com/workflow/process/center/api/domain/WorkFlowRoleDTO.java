package com.workflow.process.center.api.domain;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 工作流用户组
 *
 * @author 土豆仙
 * @since 2021-06-23 15:17:42
 */
@Data
@ApiModel(value = "WorkFlowGroupDTO", description = "工作流用户组=角色")
public class WorkFlowRoleDTO implements Serializable {
    /**
     * 角色ID
     */
    @ApiModelProperty(value = "角色ID")
    private Long roleId;

    /**
     * 角色名称
     */
    @ApiModelProperty(value = "角色名称")
    private String roleName;

    /**
     * 角色权限
     */
    @ApiModelProperty(value = "角色权限")
    private String roleKey;

    /**
     * 角色排序
     */
    @ApiModelProperty(value = "角色排序")
    private String roleSort;

    /**
     * 数据范围（1：所有数据权限；2：自定义数据权限；3：本部门数据权限；4：本部门及以下数据权限；5：仅本人数据权限）
     */
   /* @ApiModelProperty(value = "数据范围（1：所有数据权限；2：自定义数据权限；3：本部门数据权限；4：本部门及以下数据权限；5：仅本人数据权限）")
    private String dataScope;*/

    /**
     * 菜单树选择项是否关联显示（ 0：父子不互相关联显示 1：父子互相关联显示）
     */
 /*   @ApiModelProperty(value = "单树选择项是否关联显示（ 0：父子不互相关联显示 1：父子互相关联显示）")
    private boolean menuCheckStrictly;*/

    /**
     * 部门树选择项是否关联显示（0：父子不互相关联显示 1：父子互相关联显示 ）
     */
  /*  @ApiModelProperty(value = "部门树选择项是否关联显示（0：父子不互相关联显示 1：父子互相关联显示 ）")
    private boolean deptCheckStrictly;*/

    /**
     * 角色状态（0正常 1停用）
     */
    @ApiModelProperty(value = "角色状态（0正常 1停用）")
    private String status;

    /**
     * 删除标志（0代表存在 2代表删除）
     */
    @ApiModelProperty(value = "删除标志（0代表存在 2代表删除）")
    private String delFlag;

    /**
     * 用户是否存在此角色标识 默认不存在
     */
  /*  @ApiModelProperty(value = "用户是否存在此角色标识 默认不存在")
    private boolean flag = false;*/

    /**
     * 菜单组
     */
    /*@ApiModelProperty(value = "菜单组")
    private Long[] menuIds;*/

    /**
     * 部门组（数据权限）
     */
   /* @ApiModelProperty(value = "部门组（数据权限）")
    private Long[] deptIds;*/
}
