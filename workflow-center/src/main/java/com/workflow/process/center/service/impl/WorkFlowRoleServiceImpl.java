package com.workflow.process.center.service.impl;

import com.workflow.process.center.api.RoleService;
import com.workflow.process.center.api.domain.WorkFlowRoleDTO;
import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.service.WorkFlowRoleService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class WorkFlowRoleServiceImpl implements WorkFlowRoleService {

    @Autowired
    private RoleService roleService;

  /*  @Autowired
    private RemoteRoleService roleService;*/


    @Override
    public ResultBean<List<WorkFlowRoleDTO>> listRoles(WorkFlowRoleDTO workFlowRoleDTO) {
        ResultBean<List<WorkFlowRoleDTO>> resultBean = roleService.listRoles(workFlowRoleDTO);

        return resultBean;
    }
}
