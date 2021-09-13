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
@ApiModel(value = "WorkFlowAreaDTO", description = "工作流用户区域")
public class WorkFlowAreaDTO implements TreeNode<String>, Serializable {

    /** 区域ID */
    @ApiModelProperty(value = "区域ID")
    private Long areaId;

    /** 区域Key */
    @ApiModelProperty(value = "区域Key")
    private String areaKey;

    /** 父区域ID */
    @ApiModelProperty(value = "父部门ID")
    private Long parentId;

    /** 父区域Key */
    @ApiModelProperty(value = "父区域Key")
    private String parentKey;

    /** 祖级列表 */
    @ApiModelProperty(value = "祖级列表")
    private String ancestors;

    /** 区域名称 */
    @ApiModelProperty(value = "部门名称")
    private String areaName;

    private List<WorkFlowAreaDTO> children = new ArrayList<>();

    @Override
    public String id() {
        return areaKey;
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
