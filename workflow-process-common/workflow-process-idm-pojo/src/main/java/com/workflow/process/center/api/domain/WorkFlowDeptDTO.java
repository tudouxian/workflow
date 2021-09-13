package com.workflow.process.center.api.domain;

import com.workflow.process.center.utils.tree.TreeNode;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Data
@ApiModel(value = "WorkFlowDeptDTO", description = "工作流用户部门")
public class WorkFlowDeptDTO implements TreeNode<String>, Serializable {

    private static final long serialVersionUID = -55176166562291230L;

    /** 部门ID */
    @ApiModelProperty(value = "部门ID")
    private Long deptId;

    /** 部门Key =>没有可设置部门ID */
    @ApiModelProperty(value = "部门Key")
    private String deptKey;

    /** 父部门ID */
    @ApiModelProperty(value = "父部门ID")
    private Long parentId;


    /** 父部门Key =>没有可设置父部门ID */
    @ApiModelProperty(value = "父部门Key")
    private String parentKey;

    /** 祖级列表 */
  /*  @ApiModelProperty(value = "祖级列表")
    private String ancestors;*/

    /** 部门名称 */
    @ApiModelProperty(value = "部门名称")
    private String deptName;

    /** 显示顺序 */
    @ApiModelProperty(value = "显示顺序")
    private String orderNum;

    /** 负责人 */
    @ApiModelProperty(value = "负责人")
    private String leader;

    /** 联系电话 */
    @ApiModelProperty(value = "联系电话")
    private String phone;

    /** 邮箱 */
    @ApiModelProperty(value = "邮箱")
    private String email;

    /** 部门状态:0正常,1停用 */
    @ApiModelProperty(value = "部门状态:0正常,1停用")
    private String status;

    /** 删除标志（0代表存在 2代表删除） */
    @ApiModelProperty(value = "删除标志（0代表存在 2代表删除）")
    private String delFlag;

    /** 父部门名称 */
    @ApiModelProperty(value = "父部门名称")
    private String parentName;

    /** 子部门递归 */
  /*  @ApiModelProperty(value = "子部门递归")
    private List<WorkFlowDeptDTO> children;*/

    private List<WorkFlowDeptDTO> children = new ArrayList<>();

    @Override
    public String id() {
        return deptKey;
    }

    @Override
    public String parentId() {
        return parentKey;
    }

    @Override
    public boolean root() {
        return Objects.equals(this.parentKey, "0");
    }

    @Override
    public void setChildren(List children) {
        this.children = children;
    }

}
