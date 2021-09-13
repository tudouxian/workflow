package com.workflow.process.center.api;

import com.workflow.process.center.api.domain.WorkFlowRoleDTO;
import com.workflow.process.center.common.ResultBean;

import java.util.List;

public interface RoleService {

    /**
     * 获取角色列表
     */
    public ResultBean<List<WorkFlowRoleDTO>> listRoles(WorkFlowRoleDTO workFlowRoleDTO);

    /**
     * 根据角色key获取角色名
     */
    public ResultBean<WorkFlowRoleDTO> queryGroupByKey(String roleKey);

}
