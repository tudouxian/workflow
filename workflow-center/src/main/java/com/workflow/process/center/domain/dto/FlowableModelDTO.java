package com.workflow.process.center.domain.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.flowable.engine.ProcessEngineConfiguration;

import java.util.Date;

//TODO 待删除
@Data
@ApiModel("flowable流程模型")
public class FlowableModelDTO {

    @ApiModelProperty(value = "主键id")
    private String id;

    //@ApiModelProperty(value = "乐观锁")
    //private int revision = 1;

    @ApiModelProperty(value = "模型名称")
    private String name;

    @ApiModelProperty(value = "模型key")
    private String key;

    @ApiModelProperty(value = "模型分类")
    private String category;

    @ApiModelProperty(value = "创建时间")
    private Date createTime;

    @ApiModelProperty(value = "最新更新时间")
    private Date lastUpdateTime;

    @ApiModelProperty(value = "版本")
    private Integer version;

    @ApiModelProperty(value = "以json格式保存流程定义的信息")
    private String metaInfo;

    @ApiModelProperty(value = "部署ID")
    private String deploymentId;

    @ApiModelProperty(value = "模型对应的模型文件（json格式数据）-外键")
    private String editorSourceValueId;

    @ApiModelProperty(value = "模型生成的图片文件-外键")
    private String editorSourceExtraValueId;

    @ApiModelProperty(value = "租户ID")
    private String tenantId = ProcessEngineConfiguration.NO_TENANT_ID;
}
