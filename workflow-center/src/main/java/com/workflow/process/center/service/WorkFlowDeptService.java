package com.workflow.process.center.service;

import com.workflow.process.center.api.domain.WorkFlowDeptDTO;
import com.workflow.process.center.common.ResultBean;

import java.util.List;

public interface WorkFlowDeptService {

    ResultBean<List<WorkFlowDeptDTO>> listDepts(WorkFlowDeptDTO workFlowDeptDTO);

    List<WorkFlowDeptDTO> deptTree(WorkFlowDeptDTO workFlowDeptDTO);

    /**
     * 根据部门key获取部门信息
     */
    WorkFlowDeptDTO queryDeptByDeptKey(String deptKey);

    /**
     * 根据部门key获取上N级部门信息
     */
    WorkFlowDeptDTO queryUpDept(String deptId, Integer stepSize);
}
