package com.workflow.process.center.domain.entity;

import java.util.Date;

import com.baomidou.mybatisplus.annotation.*;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import java.io.Serializable;
import java.util.Date;


/**
 * (WorkFlowModelInfo)表实体类
 *
 * @author 土豆仙
 * @since 2021-06-26 22:25:14
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("模型信息")
public class WorkFlowModelInfo extends BaseEntity implements Serializable {

    private static final long serialVersionUID = 703559098230616741L;

    /**
     * 主键
     */
    @ApiModelProperty(value = "主键")
    @TableId(value = "id",type = IdType.AUTO)
    private Integer id;

    /**
     * 模型id
     */
    @ApiModelProperty(value = "模型id")
    @TableField("model_id")
    private String modelId;

    /**
     * 模型名称
     */
    @ApiModelProperty(value = "模型名称")
    @TableField("name")
    @NotBlank(message = "模型名称不能为空！！")
    private String name;

    /**
     * 模型key
     */
    @ApiModelProperty(value = "模型key")
    @TableField("model_key")
    @Pattern(regexp = "^[a-zA-Z][a-zA-Z0-9_]*$", message = "模型Key限制：以字母开头，只能由字母数字下划线组成")
    @NotBlank(message = "模型key不能为空！！")
    private String modelKey;

    /**
     * 模型类型: 0 自定义流程 1是业务流程
     */
    @ApiModelProperty(value = "模型类型: 0 自定义流程 1是业务流程")
    @TableField("model_type")
    private Integer modelType;

    /**
     * 分类id
     */
    @ApiModelProperty(value = "分类id")
    @TableField("category_id")
    @NotNull(message = "模型分类不能为空！！！")
    private Integer categoryId;

/*    @ApiModelProperty(value = "分类名称")
    @TableField(exist = false)
    private String categoryName;*/

    /**
     * 流程图Model状态
     */
    @ApiModelProperty(value = "流程图Model状态")
    @TableField("status")
    private Integer status;

    /**
     * 所属部们id
     */
    @ApiModelProperty(value = "所属部们id")
    @TableField("own_dept_id")
    private Integer ownDeptId;

    /**
     * 所属部门名称
     */
    @ApiModelProperty(value = "所属部门名称")
    @TableField("own_dept_name")
    private String ownDeptName;

    /**
     * 适用公司(多个公司，以逗号隔开)
     */
    @ApiModelProperty(value = "适用公司(多个公司，以逗号隔开)")
    @TableField("apply_company_id")
    private String applyCompanyId;

    /**
     * 功能范围(1 允许转办 2允许加签 3允许转阅 4允许打印 5相近节点同一人员自动跳过 可以多选 )
     */
    @ApiModelProperty(value = "功能范围(1 允许转办 2允许加签 3允许转阅 4允许打印 5相近节点同一人员自动跳过 可以多选 )")
    @TableField("function_range")
    private String functionRange;

    /**
     * 排序
     */
    @ApiModelProperty(value = "排序")
    @TableField("order_num")
    private Integer orderNum;

    /**
     * 系统标识-租户ID
     */
    @ApiModelProperty(value = "系统标识-租户ID")
    @TableField("tenant_id")
    private String tenantId;


    /**
     * 删除标识
     */
    @TableLogic
    @ApiModelProperty(value = "删除标识")
    @TableField(value = "del_flag",fill = FieldFill.INSERT)
    private Integer delFlag;

}
