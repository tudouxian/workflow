package com.workflow.system.service.idm;

import com.workflow.process.center.api.RoleService;
import com.workflow.process.center.api.domain.WorkFlowRoleDTO;
import com.workflow.process.center.common.ResultBean;
import com.workflow.system.mapper.ProcessIdmMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProcessRoleService implements RoleService {

    @Autowired
    ProcessIdmMapper processIdmMapper;


    @Override
    public ResultBean<List<WorkFlowRoleDTO>> listRoles(WorkFlowRoleDTO workFlowRoleDTO) {
        List<WorkFlowRoleDTO> workFlowRoleDTOS = processIdmMapper.listRoles(workFlowRoleDTO);
        return ResultBean.ofSuccess(workFlowRoleDTOS);
    }

    @Override
    public ResultBean<WorkFlowRoleDTO> queryGroupByKey(String roleKey) {
        WorkFlowRoleDTO workFlowRoleDTO = processIdmMapper.queryGroupByRoleKey(roleKey);
        return ResultBean.ofSuccess(workFlowRoleDTO);
    }
}
