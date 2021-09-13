package com.workflow.process.center.controller;

import com.workflow.process.center.domain.entity.WorkFlowListener;
import com.workflow.process.center.service.WorkFlowListenerService;
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
 * 流程监听器(WorkFlowListener)表控制层
 *
 * @author 土豆仙
 * @since 2021-08-23 15:15:26
 */
@Api(tags = "流程监听器")
@RestController
@RequestMapping("/workFlowListener")
public class WorkFlowListenerController {

    /**
     * 服务对象
     */
    @Autowired
    WorkFlowListenerService workFlowListenerService;

    /**
     * 查询所有不分页
     */
    @ApiOperation(value = "查询所有信息", notes = "不分页")
    @GetMapping("/list")
    public ResultBean<List<WorkFlowListener>> list(WorkFlowListener workFlowListener) {

        List<WorkFlowListener> list = workFlowListenerService.list(new QueryWrapper<>(workFlowListener));
        return ResultBean.ofSuccess(list);
    }

    /**
     * 分页查询所有数据
     *
     * @param pageIndex        页码
     * @param pageSize         页长
     * @param workFlowListener 查询实体
     * @return 所有数据
     */
    @ApiOperation("分页查询所有数据")
    @GetMapping("/selectAll")
    public ResultBean<List<WorkFlowListener>> selectAll(WorkFlowListener workFlowListener,
                                                   @RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
                                                   @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) {
        PageHelper.startPage(pageIndex, pageSize, true);
        List<WorkFlowListener> list = workFlowListenerService.list(new QueryWrapper<>(workFlowListener));
        PageInfo<WorkFlowListener> pageInfo = new PageInfo<>(list);
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
    public ResultBean<WorkFlowListener> selectOne(@PathVariable Serializable id) {
        return ResultBean.ofSuccess(workFlowListenerService.getById(id));
    }

    /**
     * 新增数据
     *
     * @param workFlowListener 实体对象
     * @return 新增结果
     */
    @ApiOperation("新增数据")
    @PostMapping("/insert")
    public ResultBean<Integer> insert(@RequestBody WorkFlowListener workFlowListener) {
        boolean rs = workFlowListenerService.save(workFlowListener);
        return ResultBean.ofSuccess(rs ? workFlowListener.getId() : 0);
    }

    /**
     * 修改数据
     *
     * @param workFlowListener 实体对象
     * @return 修改结果
     */
    @ApiOperation("修改数据")
    @PutMapping("/update")
    public ResultBean<Boolean> update(@RequestBody WorkFlowListener workFlowListener) {
        return ResultBean.ofSuccess(workFlowListenerService.updateById(workFlowListener));
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

        //级联删除配置参数
        boolean b = workFlowListenerService.deleteByIds(idList);
        return ResultBean.ofSuccess(b ? "删除成功！" : "删除失败！");
    }
}
