package com.workflow.process.center.domain.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.List;

/**
*   @Author: 土豆仙
*   @Date: 2021/6/27 14:49
*   @Description: 高亮信息
*/
@Data
@AllArgsConstructor
@NoArgsConstructor
@ApiModel(value = "HighLightedNodeVO", description = "高亮节点")
public class HighLightedNodeVO implements Serializable {
    public HighLightedNodeVO(List<String> highLightedFlows, List<String> activeActivityIds) {
        this.highLightedFlows = highLightedFlows;
        this.activeActivityIds = activeActivityIds;
    }

    //高亮线id集合
    @ApiModelProperty(value = "高亮线id集合")
    private List<String> highLightedFlows;
    //高亮节点id集合
    @ApiModelProperty(value = "高亮节点id集合")
    private List<String> activeActivityIds;
    //model的xml文件
    @ApiModelProperty(value = "model的xml文件")
    private String modelXml;
    //model的名称
    @ApiModelProperty(value = "model的名称")
    private String modelName;
}
