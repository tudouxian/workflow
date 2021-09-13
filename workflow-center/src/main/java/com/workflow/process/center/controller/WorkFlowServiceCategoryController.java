package com.workflow.process.center.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.domain.entity.WorkFlowServiceCategory;
import com.workflow.process.center.exception.BizException;
import com.workflow.process.center.service.WorkFlowServiceCategoryService;


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
 * 服务分类表(WorkFlowServiceCategory)表控制层
 *
 * @author 土豆仙
 * @since 2021-07-03 09:34:00
 */
@Api(tags = "服务分类表")
@RestController
@RequestMapping("/workFlowServiceCategory")
public class WorkFlowServiceCategoryController {

    /**
     * 服务对象
     */
    @Autowired
    WorkFlowServiceCategoryService workFlowServiceCategoryService;

    /**
     * 查询所有不分页
     */
    @ApiOperation(value = "查询所有信息", notes = "不分页")
    @GetMapping("/list")
    public ResultBean<List<WorkFlowServiceCategory>> list() {

        List<WorkFlowServiceCategory> list = workFlowServiceCategoryService.list();
        return ResultBean.ofSuccess(list);
    }

    /**
     * 查询服务分类按树型结构
     */
    @ApiOperation(value = "查询服务分类按树型结构", notes = "服务分类树")
    @GetMapping("/treeByCateGroyName")
    public ResultBean<List<WorkFlowServiceCategory>> treeByCateGroyName(WorkFlowServiceCategory workFlowServiceCategory) {

        List<WorkFlowServiceCategory> list = workFlowServiceCategoryService.treeByCateGroyName(workFlowServiceCategory);
        return ResultBean.ofSuccess(list);
    }

    /**
     * 分页查询所有数据
     *
     * @param pageIndex               页码
     * @param pageSize                页长
     * @param workFlowServiceCategory 查询实体
     * @return 所有数据
     */
    @ApiOperation("分页查询所有数据")
    @GetMapping("/selectAll")
    public ResultBean<List<WorkFlowServiceCategory>> list(WorkFlowServiceCategory workFlowServiceCategory,
                                                          @RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
                                                          @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) {
        PageHelper.startPage(pageIndex, pageSize, true);
        List<WorkFlowServiceCategory> list = workFlowServiceCategoryService.list(new QueryWrapper<>(workFlowServiceCategory));
        PageInfo<WorkFlowServiceCategory> pageInfo = new PageInfo<>(list);
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
    public ResultBean<WorkFlowServiceCategory> selectOne(@PathVariable Serializable id) {
        return ResultBean.ofSuccess(workFlowServiceCategoryService.getById(id));
    }

    /**
     * 新增数据
     *
     * @param workFlowServiceCategory 实体对象
     * @return 新增结果
     */
    @ApiOperation("新增数据")
    @PostMapping("/insert")
    public ResultBean<Integer> insert(@RequestBody WorkFlowServiceCategory workFlowServiceCategory) {
        LambdaQueryWrapper<WorkFlowServiceCategory> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.eq(WorkFlowServiceCategory::getCategoryCode,workFlowServiceCategory.getCategoryCode());

        WorkFlowServiceCategory exist = workFlowServiceCategoryService.getOne(lambdaQueryWrapper);

        if (exist !=null){
            throw new BizException("服务分类编码已经存在！");
        }
        boolean rs = workFlowServiceCategoryService.save(workFlowServiceCategory);
        return ResultBean.ofSuccess(rs ? workFlowServiceCategory.getId() : 0);
    }

    /**
     * 修改数据
     *
     * @param workFlowServiceCategory 实体对象
     * @return 修改结果
     */
    @ApiOperation("修改数据")
    @PutMapping("/update")
    public ResultBean<String> update(@RequestBody WorkFlowServiceCategory workFlowServiceCategory) {
        LambdaQueryWrapper<WorkFlowServiceCategory> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.eq(WorkFlowServiceCategory::getCategoryCode,workFlowServiceCategory.getCategoryCode());
        lambdaQueryWrapper.ne(WorkFlowServiceCategory::getId,workFlowServiceCategory.getId());
        WorkFlowServiceCategory exist = workFlowServiceCategoryService.getOne(lambdaQueryWrapper);

        if (exist !=null){
            throw new BizException("服务分类编码已经存在！");
        }
        boolean b = workFlowServiceCategoryService.updateById(workFlowServiceCategory);
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
        boolean b = workFlowServiceCategoryService.removeByIds(idList);
        return ResultBean.ofSuccess(b?"删除成功！":"删除失败！");
    }
}
