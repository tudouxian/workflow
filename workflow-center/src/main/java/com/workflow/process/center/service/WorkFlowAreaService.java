package com.workflow.process.center.service;

import com.workflow.process.center.api.domain.WorkFlowAreaDTO;
import com.workflow.process.center.common.ResultBean;

import java.util.List;

public interface WorkFlowAreaService {

    ResultBean<List<WorkFlowAreaDTO>> listAreas(WorkFlowAreaDTO workFlowAreaDTO);

    List<WorkFlowAreaDTO> deptTree(WorkFlowAreaDTO workFlowAreaDTO);

    /**
     * 根据区域key获取区域信息
     */
    WorkFlowAreaDTO  queryAreaByAreaKey(String areaKey);

    /**
     * 根据区域key获取上N级区域信息
     */
    WorkFlowAreaDTO queryUpArea(String areaId, Integer stepSize);

}
