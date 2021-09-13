package com.workflow.process.center.controller;

import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.domain.entity.WorkFlowService;
import com.workflow.process.center.service.WorkFlowServiceService;


import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import org.flowable.engine.ProcessEngine;
import org.flowable.engine.repository.ProcessDefinition;
import org.flowable.engine.repository.ProcessDefinitionQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.io.Serializable;
import java.util.List;

/**
 * 服务表(WorkFlowService)表控制层
 *
 * @author 土豆仙
 * @since 2021-07-03 09:32:58
 */
@Api(tags = "服务表")
@RestController
@RequestMapping("/workFlowService")
public class WorkFlowServiceController {

    /**
     * 服务对象
     */
    @Autowired
    WorkFlowServiceService workFlowServiceService;

    @Autowired
    private ProcessEngine processEngine;

    /**
     * 查询所有不分页
     */
    @ApiOperation(value = "查询所有服务信息", notes = "不分页")
    @GetMapping("/list")
    public ResultBean<List<WorkFlowService>> list() {

        List<WorkFlowService> list = workFlowServiceService.list();
        //填充流程定义信息
        list.stream()
                .forEach(_workFlowService1 -> {
                    ProcessDefinitionQuery processDefinitionQuery = processEngine.getRepositoryService().createProcessDefinitionQuery();
                    ProcessDefinition _processDefinition = processDefinitionQuery.processDefinitionId(_workFlowService1.getProcessDefId()).singleResult();
                    if (_processDefinition !=null){
                        _workFlowService1.setProcessDefName(_processDefinition.getName());
                        _workFlowService1.setProcessDefVersion(_processDefinition.getVersion());
                    }
                });
        return ResultBean.ofSuccess(list);
    }

    /**
     * 查询所有不分页
     */
    @ApiOperation(value = "查询所有服务信息", notes = "不分页")
    @PostMapping("/listAllServiceUnderCategory")
    public ResultBean<List<WorkFlowService>> listAllServiceUnderCategory(@RequestBody WorkFlowService workFlowService) {

        List<WorkFlowService> list = workFlowServiceService.listAllServiceUnderCategory(workFlowService);
        //填充流程定义信息
        list.stream()
                .forEach(_workFlowService1 -> {
                    ProcessDefinitionQuery processDefinitionQuery = processEngine.getRepositoryService().createProcessDefinitionQuery();
                    ProcessDefinition _processDefinition = processDefinitionQuery.processDefinitionId(_workFlowService1.getProcessDefId()).singleResult();
                    if (_processDefinition !=null){
                        _workFlowService1.setProcessDefName(_processDefinition.getName());
                        _workFlowService1.setProcessDefVersion(_processDefinition.getVersion());
                    }
                });
        return ResultBean.ofSuccess(list);
    }

    /**
     * 分页查询所有数据
     *
     * @param pageIndex       页码
     * @param pageSize        页长
     * @param workFlowService 查询实体
     * @return 所有数据
     */
    @ApiOperation("分页查询所有服务数据")
    @GetMapping("/selectAll")
    public ResultBean<List<WorkFlowService>> list(WorkFlowService workFlowService,
                                                  @RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
                                                  @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) {
        PageHelper.startPage(pageIndex, pageSize, true);
        List<WorkFlowService> list = workFlowServiceService.listAll(workFlowService);

        //填充流程定义信息
        list.stream()
                .forEach(_workFlowService1 -> {
                    ProcessDefinitionQuery processDefinitionQuery = processEngine
                            .getRepositoryService()
                            .createProcessDefinitionQuery();
                    ProcessDefinition _processDefinition = processDefinitionQuery
                            .processDefinitionId(_workFlowService1.getProcessDefId())
                            .singleResult();
                    if (_processDefinition !=null){
                        _workFlowService1.setProcessDefName(_processDefinition.getName());
                        _workFlowService1.setProcessDefVersion(_processDefinition.getVersion());
                    }
                });

        PageInfo<WorkFlowService> pageInfo = new PageInfo<>(list);
        return ResultBean.ofSuccess(list, pageInfo.getTotal(), pageInfo.getPageNum(), pageInfo.getPageSize());

    }

    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @ApiOperation("通过主键查询单条数据")
    @GetMapping("/{id}")
    public ResultBean<WorkFlowService> selectOne(@PathVariable Serializable id) {
        WorkFlowService workFlowService = workFlowServiceService.getById(id);
        ProcessDefinitionQuery processDefinitionQuery = processEngine.getRepositoryService().createProcessDefinitionQuery();
        ProcessDefinition _processDefinition = processDefinitionQuery.processDefinitionId(workFlowService.getProcessDefId()).singleResult();
        if (_processDefinition !=null){
            workFlowService.setProcessDefName(_processDefinition.getName());
            workFlowService.setProcessDefVersion(_processDefinition.getVersion());
        }
        return ResultBean.ofSuccess(workFlowService);
    }

    /**
     * 新增数据
     *
     * @param workFlowService 实体对象
     * @return 新增结果
     */
    @ApiOperation("新增数据")
    @PostMapping("/insert")
    public ResultBean<Integer> insert(@RequestBody WorkFlowService workFlowService) {
        boolean rs = workFlowServiceService.save(workFlowService);
        return ResultBean.ofSuccess(rs ? workFlowService.getId() : 0);
    }

    /**
     * 修改数据
     *
     * @param workFlowService 实体对象
     * @return 修改结果
     */
    @ApiOperation("修改数据")
    @PutMapping("/update")
    public ResultBean<String> update(@RequestBody WorkFlowService workFlowService) {
        boolean b = workFlowServiceService.updateById(workFlowService);
        return ResultBean.ofSuccess(b?"修改成功！":"修改失败！");
    }

    /**
     * 单条/批量删除数据
     *
     * @param idList 主键集合
     * @return 删除结果
     */
    @ApiOperation("单条/批量删除数据")
    @DeleteMapping("/delete")
    public ResultBean<String> delete(@RequestBody List<Long> idList) {
        boolean b = workFlowServiceService.removeByIds(idList);
        return ResultBean.ofSuccess(b?"删除成功！":"删除失败！");
    }
}
