package com.workflow.process.center.domain.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Data
@ApiModel(value = "ActivityVO", description = "节点信息")
public class ActivityVO implements Serializable {

    //taskId
    @ApiModelProperty(value = "节点任务id")
    private String id;
    //x坐标
    @ApiModelProperty(value = "x坐标")
    private double x;
    //y坐标
    @ApiModelProperty(value = "y坐标")
    private double y;
    //宽度
    @ApiModelProperty(value = "width")
    private double width;
    //高度
    @ApiModelProperty(value = "高度")
    private double height;
    //说明
    @ApiModelProperty(value = "说明")
    private String documentation;
    //描述
    @ApiModelProperty(value = "描述")
    private String description;
    //名称
    @ApiModelProperty(value = "名称")
    private String name;
    //审批人工号
    @ApiModelProperty(value = "审批人工号")
    private String approverNo;
    //审批人
    @ApiModelProperty(value = "审批人")
    private String approver;
    //类型
    @ApiModelProperty(value = "类型")
    private String type;
    //节点类型
    @ApiModelProperty(value = "节点类型")
    private String nodeType;
    //节点状态
    @ApiModelProperty(value = "节点状态")
    private String status;
    //开始时间
    @ApiModelProperty(value = "开始时间")
    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm:ss")
    private Date startDate;
    //结束时间
    @ApiModelProperty(value = "结束时间")
    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm:ss")
    private Date endDate;
    //耗时
    @ApiModelProperty(value = "耗时")
    private String duration;
    //流程实例id
    @ApiModelProperty(value = "流程实例id")
    private String proceInsId;
    //定义id
    @ApiModelProperty(value = "流程定义Id")
    private String proceDefId;
    //节点id
    @ApiModelProperty(value = "节点任务定义key")
    private String taskDefKey;
}
