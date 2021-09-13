package com.workflow.process.center.domain.entity;

import java.util.Date;

import com.baomidou.mybatisplus.annotation.*;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import java.io.Serializable;
import java.util.Date;


/**
 * 服务表(WorkFlowService)表实体类
 *
 * @author 土豆仙
 * @since 2021-07-03 09:18:02
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("服务表")
public class WorkFlowService extends BaseEntity implements Serializable {

    private static final long serialVersionUID = -63207925137447371L;

    /**
     * 服务id
     */
    @ApiModelProperty(value = "服务id")
    @TableId(value = "id",type = IdType.AUTO)
    private Integer id;

    /**
     * 服务名称
     */
    @ApiModelProperty(value = "服务名称")
    @TableField("service_name")
    @NotBlank(message = "服务名称不能为空！")
    private String serviceName;

    /**
     * 服务编码
     */
    @ApiModelProperty(value = "服务编码")
    @TableField("service_code")
    @Pattern(regexp = "^[a-zA-Z][a-zA-Z0-9_]*$", message = "编码限制：以字母开头，只能由字母数字下划线组成")
    private String serviceCode;

    /**
     * 图标图片
     */
    @ApiModelProperty(value = "图标图片")
    @TableField("icon_url")
    private String iconUrl;

    /**
     * 服务分类-一对多=》取消中间表
     */
    @ApiModelProperty(value = "服务分类ID")
    @TableField("service_category_id")
    @NotNull(message = "未配置服务所属分类！")
    private Integer serviceCategoryId;

    @ApiModelProperty(value = "服务分类名称")
    @TableField(exist =false)
    private String serviceCategoryName;

    /**
     * 服务类型，1：内部表单服务；2，外部调用服务
     */
    @ApiModelProperty(value = "服务类型，1：内部表单服务；2，外部调用服务")
    @TableField("type")
    private Integer type;

    /**
     * 流程定义id
     */
    @ApiModelProperty(value = "流程定义id")
    @TableField("process_def_id")
    @NotBlank(message = "服务未指定流程定义！")
    private String processDefId;

    @ApiModelProperty(value = "流程定义名称")
    @TableField(exist = false)
    private String processDefName;

    @ApiModelProperty(value = "流程定义版本")
    @TableField(exist = false)
    private Integer processDefVersion;

    /**
     * 是否发布，0：不发布，1：发布
     */
    @ApiModelProperty(value = "是否发布，0：不发布，1：发布")
    @TableField("status")
    private Object status;

    /**
     * 打开方式,0-当前页面,1-新窗口打开
     */
    @ApiModelProperty(value = "打开方式,0-当前页面,1-新窗口打开")
    @TableField("open_way")
    private Object openWay;

    /**
     * 排序
     */
    @ApiModelProperty(value = "排序")
    @TableField("order_num")
    private Integer orderNum;

    /**
     * 备注
     */
    @ApiModelProperty(value = "备注")
    @TableField("`desc`")
    private String desc;

    /**
     * 系统标识-租户ID
     */
    @ApiModelProperty(value = "系统标识-租户ID")
    @TableField("tenant_id")
    private String tenantId;

    /**
     * 系统标识-租户名称
     */
    @ApiModelProperty(value = "系统标识-租户名称")
    @TableField(exist = false)
    private String tenantName;

    /**
     * 删除标识
     */
    @TableLogic
    @ApiModelProperty(value = "删除标识")
    @TableField(value = "del_flag",fill = FieldFill.INSERT)
    private Integer delFlag;


}
