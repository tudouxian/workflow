package com.workflow.process.center.controller;

import com.workflow.process.center.domain.entity.WorkFlowModel;
import com.workflow.process.center.service.WorkFlowModelService;
import com.workflow.process.center.common.ResultBean;


import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.io.Serializable;
import java.util.List;

/**
 * 流程模型信息(WorkFlowModel)表控制层
 *
 * @author 土豆仙
 * @since 2021-08-26 14:17:53
 */
@Api(tags = "流程模型信息")
@RestController
@RequestMapping("/workFlowModel")
public class WorkFlowModelController {

    /**
     * 服务对象
     */
    @Autowired
    WorkFlowModelService workFlowModelService;

    /**
     * 查询所有不分页
     */
    @ApiOperation(value = "查询所有信息", notes = "不分页")
    @GetMapping("/list")
    public ResultBean<List<WorkFlowModel>> list() {

        List<WorkFlowModel> list = workFlowModelService.list();
        return ResultBean.ofSuccess(list);
    }

    /**
     * 分页查询所有数据
     *
     * @param pageIndex     页码
     * @param pageSize      页长
     * @param workFlowModel 查询实体
     * @return 所有数据
     */
    @ApiOperation("分页查询所有数据")
    @GetMapping("/selectAll")
    public ResultBean<List<WorkFlowModel>> list(WorkFlowModel workFlowModel,
                                                @RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
                                                @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) {
        PageHelper.startPage(pageIndex, pageSize, true);
        List<WorkFlowModel> list = workFlowModelService.list(new QueryWrapper<>(workFlowModel));
        PageInfo<WorkFlowModel> pageInfo = new PageInfo<>(list);
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
    public ResultBean<WorkFlowModel> selectOne(@PathVariable Serializable id) {
        return ResultBean.ofSuccess(workFlowModelService.getById(id));
    }

    /**
     * 新增数据
     *
     * @param workFlowModel 实体对象
     * @return 新增结果
     */
    @ApiOperation("新增数据")
    @PostMapping("/insert")
    public ResultBean<String> insert(@RequestBody WorkFlowModel workFlowModel) {
        boolean rs = workFlowModelService.save(workFlowModel);
        return ResultBean.ofSuccess(rs ? workFlowModel.getId() : null);
    }

    /**
     * 修改数据
     *
     * @param workFlowModel 实体对象
     * @return 修改结果
     */
    @ApiOperation("修改数据")
    @PutMapping("/update")
    public ResultBean<Boolean> update(@RequestBody WorkFlowModel workFlowModel) {
        return ResultBean.ofSuccess(workFlowModelService.updateById(workFlowModel));
    }

    /**
     * 单条/批量删除数据
     *
     * @param idList 主键集合
     * @return 删除结果
     */
    @ApiOperation("单条/批量删除数据")
    @DeleteMapping("/delete")
    public ResultBean<String> delete(@RequestBody List<Integer> idList) {
        boolean b = workFlowModelService.removeByIds(idList);
        return ResultBean.ofSuccess(b ? "删除成功！" : "删除失败！");
    }
}
