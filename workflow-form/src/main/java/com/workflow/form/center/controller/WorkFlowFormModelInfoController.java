package com.workflow.form.center.controller;

import com.workflow.form.center.domain.entity.WorkFlowFormModelInfo;
import com.workflow.form.center.service.WorkFlowFormModelInfoService;


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
 * 表单模型信息表(WorkFlowFormModelInfo)表控制层
 *
 * @author 土豆仙
 * @since 2021-07-29 10:55:18
 */
@Api(tags = "表单模型信息表")
@RestController
@RequestMapping("/workFlowFormModelInfo")
public class WorkFlowFormModelInfoController {

    /**
     * 服务对象
     */
    @Autowired
    WorkFlowFormModelInfoService workFlowFormModelInfoService;

    /**
     * 查询所有不分页
     */
    @ApiOperation(value = "查询所有信息", notes = "不分页")
    @GetMapping("/list")
    public ResultBean<List<WorkFlowFormModelInfo>> list() {

        List<WorkFlowFormModelInfo> list = workFlowFormModelInfoService.list();
        return ResultBean.ofSuccess(list);
    }

    /**
     * 分页查询所有数据
     *
     * @param pageIndex             页码
     * @param pageSize              页长
     * @param workFlowFormModelInfo 查询实体
     * @return 所有数据
     */
    @ApiOperation("分页查询所有数据")
    @GetMapping("/selectAll")
    public ResultBean<List<WorkFlowFormModelInfo>> list(WorkFlowFormModelInfo workFlowFormModelInfo,
                                                        @RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
                                                        @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) {
        PageHelper.startPage(pageIndex, pageSize, true);
        List<WorkFlowFormModelInfo> list = workFlowFormModelInfoService.list(new QueryWrapper<>(workFlowFormModelInfo));
        PageInfo<WorkFlowFormModelInfo> pageInfo = new PageInfo<>(list);
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
    public ResultBean<WorkFlowFormModelInfo> selectOne(@PathVariable Serializable id) {
        return ResultBean.ofSuccess(workFlowFormModelInfoService.getById(id));
    }

    /**
     * 新增数据
     *
     * @param workFlowFormModelInfo 实体对象
     * @return 新增结果
     */
    @ApiOperation("新增数据")
    @PostMapping("/insert")
    public ResultBean<Integer> insert(@RequestBody WorkFlowFormModelInfo workFlowFormModelInfo) {
        boolean rs = workFlowFormModelInfoService.save(workFlowFormModelInfo);
        return ResultBean.ofSuccess(rs ? workFlowFormModelInfo.getModelInfoId() : 0);
    }

    /**
     * 修改数据
     *
     * @param workFlowFormModelInfo 实体对象
     * @return 修改结果
     */
    @ApiOperation("修改数据")
    @PutMapping("/update")
    public ResultBean<Boolean> update(@RequestBody WorkFlowFormModelInfo workFlowFormModelInfo) {
        return ResultBean.ofSuccess(workFlowFormModelInfoService.updateById(workFlowFormModelInfo));
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
        return ResultBean.ofSuccess(workFlowFormModelInfoService.removeByIds(idList));
    }
}
