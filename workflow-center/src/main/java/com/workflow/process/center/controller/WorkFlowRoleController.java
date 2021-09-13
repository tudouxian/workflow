package com.workflow.process.center.controller;

import com.workflow.process.center.api.domain.WorkFlowDeptDTO;
import com.workflow.process.center.api.domain.WorkFlowRoleDTO;
import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.service.WorkFlowDeptService;
import com.workflow.process.center.service.WorkFlowRoleService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @Author: 土豆仙
 * @Date: 2021/6/23 14:41
 * @Description: 流程角色管理
 */
@Api(tags = "流程角色管理")
@RestController
@RequestMapping("/workFlowRoles")
public class WorkFlowRoleController {

    @Autowired
    private WorkFlowRoleService workFlowRoleService;

    /**
     * 分页查询所有数据
     *
     * @param workFlowRoleDTO 查询实体
     * @return 所有数据
     */
    @ApiOperation("分页查询所有部门数据")
    @GetMapping("/selectAll")
    public ResultBean<List<WorkFlowRoleDTO>> listUsers(WorkFlowRoleDTO workFlowRoleDTO) {

        ResultBean<List<WorkFlowRoleDTO>> resultBean = workFlowRoleService.listRoles(workFlowRoleDTO);
        return resultBean;

    }


}
