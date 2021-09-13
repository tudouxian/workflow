package com.workflow.process.center.domain.entity;

import java.util.Date;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;


/**
 * 流程模型信息(WorkFlowModel)表实体类
 *
 * @author 土豆仙
 * @since 2021-08-26 14:17:39
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("流程模型信息")
public class WorkFlowModel implements Serializable {

    private static final long serialVersionUID = -80805443817960041L;

    /**
     * id
     */
    @ApiModelProperty(value = "id")
    @TableId(type = IdType.ASSIGN_UUID)
    @TableField("id")
    private String id;


    /**
     * 流程Key数据
     */
    @ApiModelProperty(value = "流程Key数据")
    @TableField("model_key")
    private String modelKey;

    @ApiModelProperty(value = "版本号")
    @TableField("version")
    private Integer version;

    /**
     * 流程名称
     */
    @ApiModelProperty(value = "流程名称")
    @TableField("model_name")
    private String modelName;

    /**
     * 流程json数据
     */
    @ApiModelProperty(value = "流程json数据")
    @TableField("model_json")
    private String modelJson;

    /**
     * 流程xml数据
     */
    @ApiModelProperty(value = "流程xml数据")
    @TableField("model_xml")
    private String modelXml;

    /**
     * 文件名称
     */
    @ApiModelProperty(value = "文件名称")
    @TableField("file_name")
    private String fileName;

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
     * 删除标识0表示删除1表示存在
     */
    @ApiModelProperty(value = "删除标识0表示删除1表示存在")
    @TableField("del_flag")
    private Integer delFlag;

}
