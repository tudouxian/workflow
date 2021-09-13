package com.workflow.process.center.api;

import com.workflow.process.center.api.domain.WorkFlowDeptDTO;
import com.workflow.process.center.common.ResultBean;

import java.util.List;

public interface DeptService {

    /**
     * 获取部门列表
     */
    public ResultBean<List<WorkFlowDeptDTO>> listDepts(WorkFlowDeptDTO workFlowDeptDTO);

    /**
     * 根据部门key获取部门信息
     */
    ResultBean<WorkFlowDeptDTO> queryGroupByKey(String deptKey);
}
