package com.workflow.process.center.service;

import com.workflow.process.center.api.domain.WorkFlowDeptDTO;
import com.workflow.process.center.api.domain.WorkFlowRoleDTO;
import com.workflow.process.center.common.ResultBean;

import java.util.List;

public interface WorkFlowRoleService {

    ResultBean<List<WorkFlowRoleDTO>> listRoles(WorkFlowRoleDTO workFlowRoleDTO);

}
