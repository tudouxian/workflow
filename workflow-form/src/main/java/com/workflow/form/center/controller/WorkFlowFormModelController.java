package com.workflow.form.center.controller;

import com.workflow.form.center.domain.entity.WorkFlowFormModel;
import com.workflow.form.center.service.WorkFlowFormModelService;


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
 * 自定义表单模型表(WorkFlowFormModel)表控制层
 *
 * @author 土豆仙
 * @since 2021-07-29 10:54:57
 */
@Api(tags = "自定义表单模型表")
@RestController
@RequestMapping("/workFlowFormModel")
public class WorkFlowFormModelController {

    /**
     * 服务对象
     */
    @Autowired
    WorkFlowFormModelService workFlowFormModelService;

    /**
     * 查询所有不分页
     */
    @ApiOperation(value = "查询所有信息", notes = "不分页")
    @GetMapping("/list")
    public ResultBean<List<WorkFlowFormModel>> list() {
        List<WorkFlowFormModel> list = workFlowFormModelService.list();
        return ResultBean.ofSuccess(list);
    }

    /**
     * 分页查询所有数据
     *
     * @param pageIndex         页码
     * @param pageSize          页长
     * @param workFlowFormModel 查询实体
     * @return 所有数据
     */
    @ApiOperation("分页查询所有数据")
    @GetMapping("/selectAll")
    public ResultBean<List<WorkFlowFormModel>> list(WorkFlowFormModel workFlowFormModel,
                                                    @RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
                                                    @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) {
        PageHelper.startPage(pageIndex, pageSize, true);
        List<WorkFlowFormModel> list = workFlowFormModelService.list(new QueryWrapper<>(workFlowFormModel));
        PageInfo<WorkFlowFormModel> pageInfo = new PageInfo<>(list);
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
    public ResultBean<WorkFlowFormModel> selectOne(@PathVariable Serializable id) {
        return ResultBean.ofSuccess(workFlowFormModelService.getById(id));
    }

    /**
     * 新增数据
     *
     * @param workFlowFormModel 实体对象
     * @return 新增结果
     */
    @ApiOperation("新增数据")
    @PostMapping("/insert")
    public ResultBean<Integer> insert(@RequestBody WorkFlowFormModel workFlowFormModel) {
        boolean rs = workFlowFormModelService.save(workFlowFormModel);
        return ResultBean.ofSuccess(rs ? workFlowFormModel.getModelId() : 0);
    }

    /**
     * 修改数据
     *
     * @param workFlowFormModel 实体对象
     * @return 修改结果
     */
    @ApiOperation("修改数据")
    @PutMapping("/update")
    public ResultBean<Boolean> update(@RequestBody WorkFlowFormModel workFlowFormModel) {
        return ResultBean.ofSuccess(workFlowFormModelService.updateById(workFlowFormModel));
    }

    /**
     * 单条/批量删除数据
     *
     * @param idList 主键集合
     * @return 删除结果
     */
    @ApiOperation("单条/批量删除数据")
    @DeleteMapping("/delete")
    public ResultBean<Boolean> delete(@RequestParam("idList") List<Long> idList) {
        return ResultBean.ofSuccess(workFlowFormModelService.removeByIds(idList));
    }
}
