package com.workflow.process.center.controller;

import com.workflow.process.center.api.domain.WorkFlowAreaDTO;
import com.workflow.process.center.api.domain.WorkFlowDeptDTO;
import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.service.WorkFlowAreaService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.List;

/**
 * @Author: 土豆仙
 * @Date: 2021/6/23 14:41
 * @Description: 流程区域管理
 */
@Api(tags = "流程区域管理")
@RestController
@RequestMapping("/workFlowAreas")
public class WorkFlowAreaController {

    @Autowired
    private WorkFlowAreaService workFlowAreaService;

    /**
     * 分页查询所有数据
     *
     * @param workFlowAreaDTO 查询实体
     * @return 所有数据
     */
    @ApiOperation("分页查询所有部门数据")
    @GetMapping("/selectAll")
    public ResultBean<List<WorkFlowAreaDTO>> listUsers(WorkFlowAreaDTO workFlowAreaDTO) {

       // ResultBean<List<WorkFlowAreaDTO>> resultBean = workFlowAreaService.listAreas(workFlowAreaDTO);
        return ResultBean.ofSuccess(Arrays.asList());

    }

    /**
     * 树化数据
     *
     * @param workFlowAreaDTO 查询实体
     * @return 树化数据
     */
    @ApiOperation("树化数据")
    @GetMapping("/areaTree")
    public ResultBean<List<WorkFlowAreaDTO>> deptTree(WorkFlowAreaDTO workFlowAreaDTO) {

        //List<WorkFlowAreaDTO> treeList = workFlowAreaService.deptTree(workFlowAreaDTO);
        return ResultBean.ofSuccess(Arrays.asList());

    }



}
