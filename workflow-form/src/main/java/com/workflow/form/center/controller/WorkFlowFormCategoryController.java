package com.workflow.form.center.controller;

import com.workflow.form.center.domain.entity.WorkFlowFormCategory;
import com.workflow.form.center.service.WorkFlowFormCategoryService;


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
 * 表单分类表(WorkFlowFormCategory)表控制层
 *
 * @author 土豆仙
 * @since 2021-07-29 10:54:26
 */
@Api(tags = "表单分类表")
@RestController
@RequestMapping("/workFlowFormCategory")
public class WorkFlowFormCategoryController {

    /**
     * 服务对象
     */
    @Autowired
    WorkFlowFormCategoryService workFlowFormCategoryService;

    /**
     * 查询所有不分页
     */
    @ApiOperation(value = "查询所有信息", notes = "不分页")
    @GetMapping("/list")
    public ResultBean<List<WorkFlowFormCategory>> list() {

        List<WorkFlowFormCategory> list = workFlowFormCategoryService.list();
        return ResultBean.ofSuccess(list);
    }

    /**
     * 分页查询所有数据
     *
     * @param pageIndex            页码
     * @param pageSize             页长
     * @param workFlowFormCategory 查询实体
     * @return 所有数据
     */
    @ApiOperation("分页查询所有数据")
    @GetMapping("/selectAll")
    public ResultBean<List<WorkFlowFormCategory>> list(WorkFlowFormCategory workFlowFormCategory,
                                                       @RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
                                                       @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) {
        PageHelper.startPage(pageIndex, pageSize, true);
        List<WorkFlowFormCategory> list = workFlowFormCategoryService.list(new QueryWrapper<>(workFlowFormCategory));
        PageInfo<WorkFlowFormCategory> pageInfo = new PageInfo<>(list);
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
    public ResultBean<WorkFlowFormCategory> selectOne(@PathVariable Serializable id) {
        return ResultBean.ofSuccess(workFlowFormCategoryService.getById(id));
    }

    /**
     * 新增数据
     *
     * @param workFlowFormCategory 实体对象
     * @return 新增结果
     */
    @ApiOperation("新增数据")
    @PostMapping("/insert")
    public ResultBean<Integer> insert(@RequestBody WorkFlowFormCategory workFlowFormCategory) {
        boolean rs = workFlowFormCategoryService.save(workFlowFormCategory);
        return ResultBean.ofSuccess(rs ? workFlowFormCategory.getId() : 0);
    }

    /**
     * 修改数据
     *
     * @param workFlowFormCategory 实体对象
     * @return 修改结果
     */
    @ApiOperation("修改数据")
    @PutMapping("/update")
    public ResultBean<Boolean> update(@RequestBody WorkFlowFormCategory workFlowFormCategory) {
        return ResultBean.ofSuccess(workFlowFormCategoryService.updateById(workFlowFormCategory));
    }

    /**
     * 单条/批量删除数据
     *
     * @param idList 主键集合
     * @return 删除结果
     */
    @ApiOperation("单条/批量删除数据")
    @DeleteMapping("/delete")
    public ResultBean<Boolean> delete(@RequestBody List<Integer> idList) {
        return ResultBean.ofSuccess(workFlowFormCategoryService.removeByIds(idList));
    }
}
