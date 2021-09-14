package com.workflow.form.center.controller;

import com.workflow.form.center.domain.entity.DictType;
import com.workflow.form.center.service.DictTypeService;


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
 * 字典类型表(DictType)表控制层
 *
 * @author 土豆仙
 * @since 2021-08-10 14:34:59
 */
@Api(tags = "字典类型表")
@RestController
@RequestMapping("/dictType")
public class DictTypeController {

    /**
     * 服务对象
     */
    @Autowired
    DictTypeService dictTypeService;

    /**
     * 查询所有不分页
     */
    @ApiOperation(value = "查询所有信息", notes = "不分页")
    @GetMapping("/list")
    public ResultBean<List<DictType>> list() {

        List<DictType> list = dictTypeService.list();
        return ResultBean.ofSuccess(list);
    }

    /**
     * 分页查询所有数据
     *
     * @param pageIndex 页码
     * @param pageSize  页长
     * @param dictType  查询实体
     * @return 所有数据
     */
    @ApiOperation("分页查询所有数据")
    @GetMapping("/selectAll")
    public ResultBean<List<DictType>> list(DictType dictType,
                                           @RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
                                           @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) {
        PageHelper.startPage(pageIndex, pageSize, true);
        List<DictType> list = dictTypeService.list(new QueryWrapper<>(dictType));
        PageInfo<DictType> pageInfo = new PageInfo<>(list);
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
    public ResultBean<DictType> selectOne(@PathVariable Serializable id) {
        return ResultBean.ofSuccess(dictTypeService.getById(id));
    }

    /**
     * 新增数据
     *
     * @param dictType 实体对象
     * @return 新增结果
     */
    @ApiOperation("新增数据")
    @PostMapping("/insert")
    public ResultBean<Long> insert(@RequestBody DictType dictType) {
        boolean rs = dictTypeService.save(dictType);
        return ResultBean.ofSuccess(rs ? dictType.getDictId() : 0);
    }

    /**
     * 修改数据
     *
     * @param dictType 实体对象
     * @return 修改结果
     */
    @ApiOperation("修改数据")
    @PutMapping("/update")
    public ResultBean<Boolean> update(@RequestBody DictType dictType) {
        return ResultBean.ofSuccess(dictTypeService.updateById(dictType));
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
        boolean b = dictTypeService.removeByIds(idList);
        return ResultBean.ofSuccess(b ? "删除成功！" : "删除失败！");
    }
}
