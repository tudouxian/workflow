package com.workflow.process.center.domain.entity;

import java.util.Date;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableField;
import com.workflow.process.center.utils.tree.TreeNode;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.Objects;


/**
 * 服务分类表(WorkFlowServiceCategory)表实体类
 *
 * @author 土豆仙
 * @since 2021-07-03 09:34:00
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("服务分类表")
public class WorkFlowServiceCategory extends BaseEntity implements TreeNode<Integer> , Serializable {

    private static final long serialVersionUID = -55176166562291230L;

    @TableId(value = "id",type = IdType.AUTO)
    private Integer id;

    /**
     * 分类名称
     */
    @ApiModelProperty(value = "分类名称")
    @TableField("category_name")
    @NotBlank(message = "分类名称不能为空！")
    private String categoryName;

    /**
     * 分类编码
     */
    @ApiModelProperty(value = "分类编码")
    @TableField("category_code")
    @Pattern(regexp = "^[a-zA-Z][a-zA-Z0-9_]*$", message = "编码限制：以字母开头，只能由字母数字下划线组成")
    @NotBlank(message = "分类编码不能为空！")
    private String categoryCode;

    /**
     * 上级分类id
     */
    @ApiModelProperty(value = "上级分类id")
    @TableField("parent_id")
    @NotNull(message = "上级分类不能为空！")
    private Integer parentId;

    /**
     * 排序
     */
    @ApiModelProperty(value = "排序")
    @TableField("order_num")
    private Integer orderNum;

    /**
     * 描述
     */
    @ApiModelProperty(value = "描述")
    @TableField("`desc`")
    private String desc;

    /**
     * 状态，0：关闭，1：开启
     */
    @ApiModelProperty(value = "状态，0：关闭，1：开启")
    @TableField("status")
    private Object status;

    /**
     * 图标名称
     */
    @ApiModelProperty(value = "图标名称")
    @TableField("icon_name")
    private String iconName;

    @TableField(exist = false)
    private List<WorkFlowServiceCategory> children;


    @Override
    public Integer id() {
        return getId();
    }

    @Override
    public Integer parentId() {
        return getParentId();
    }

    @Override
    public boolean root() {
        return Objects.equals(this.parentId, 0);
    }

    @Override
    public void setChildren(List children) {

        this.children = children;
    }

}
