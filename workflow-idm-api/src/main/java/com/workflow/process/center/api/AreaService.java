package com.workflow.process.center.api;

import com.workflow.process.center.api.domain.WorkFlowAreaDTO;
import com.workflow.process.center.common.ResultBean;

import java.util.List;

public interface AreaService {

    /**
     * 获取区域列表
     */
    public ResultBean<List<WorkFlowAreaDTO>> listAreas(WorkFlowAreaDTO workFlowAreaDTO);

    /**
     * 根据区域key获取部门信息
     */
    ResultBean<WorkFlowAreaDTO> queryGroupByKey(String areaKey);
}
