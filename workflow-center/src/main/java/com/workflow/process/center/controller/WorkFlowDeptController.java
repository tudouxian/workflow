package com.workflow.process.center.controller;

import com.workflow.process.center.api.domain.WorkFlowDeptDTO;
import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.service.WorkFlowDeptService;
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
 * @Description: 流程部门管理
 */
@Api(tags = "流程部门管理")
@RestController
@RequestMapping("/workFlowDepts")
public class WorkFlowDeptController {

    @Autowired
    private WorkFlowDeptService workFlowDeptService;

    /**
     * 分页查询所有数据
     *
     * @param workFlowDeptDTO 查询实体
     * @return 所有数据
     */
    @ApiOperation("分页查询所有部门数据")
    @GetMapping("/selectAll")
    public ResultBean<List<WorkFlowDeptDTO>> listUsers(WorkFlowDeptDTO workFlowDeptDTO) {

        ResultBean<List<WorkFlowDeptDTO>> resultBean = workFlowDeptService.listDepts(workFlowDeptDTO);
        return resultBean;

    }


    /**
     * 树化数据
     *
     * @param workFlowDeptDTO 查询实体
     * @return 树化数据
     */
    @ApiOperation("树化数据")
    @GetMapping("/deptTree")
    public ResultBean<List<WorkFlowDeptDTO>> deptTree(WorkFlowDeptDTO workFlowDeptDTO) {

        List<WorkFlowDeptDTO> treeList = workFlowDeptService.deptTree(workFlowDeptDTO);
        return ResultBean.ofSuccess(treeList);

    }

}
