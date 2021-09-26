package com.workflow.process.center.controller;

import com.workflow.process.center.domain.entity.WorkFlowListenerParam;
import com.workflow.process.center.service.WorkFlowListenerParamService;
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
 * 流程监听器(WorkFlowListenerParam)表控制层
 *
 * @author 土豆仙
 * @since 2021-08-23 15:16:01
 */
@Api(tags = "流程监听器参数")
@RestController
@RequestMapping("/workFlowListenerParam")
public class WorkFlowListenerParamController {

    /**
     * 服务对象
     */
    @Autowired
    WorkFlowListenerParamService workFlowListenerParamService;

    /**
     * 查询所有不分页
     */
    @ApiOperation(value = "查询所有信息", notes = "不分页")
    @GetMapping("/list")
    public ResultBean<List<WorkFlowListenerParam>> list(WorkFlowListenerParam workFlowListenerParam) {

        List<WorkFlowListenerParam> list = workFlowListenerParamService.list(new QueryWrapper<>(workFlowListenerParam));
        return ResultBean.ofSuccess(list);
    }

    /**
     * 分页查询所有数据
     *
     * @param pageIndex             页码
     * @param pageSize              页长
     * @param workFlowListenerParam 查询实体
     * @return 所有数据
     */
    @ApiOperation("分页查询所有数据")
    @GetMapping("/selectAll")
    public ResultBean<List<WorkFlowListenerParam>> list(WorkFlowListenerParam workFlowListenerParam,
                                                        @RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
                                                        @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) {
        PageHelper.startPage(pageIndex, pageSize, true);
        List<WorkFlowListenerParam> list = workFlowListenerParamService.list(new QueryWrapper<>(workFlowListenerParam));
        PageInfo<WorkFlowListenerParam> pageInfo = new PageInfo<>(list);
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
    public ResultBean<WorkFlowListenerParam> selectOne(@PathVariable Serializable id) {
        return ResultBean.ofSuccess(workFlowListenerParamService.getById(id));
    }

    /**
     * 新增数据
     *
     * @param workFlowListenerParam 实体对象
     * @return 新增结果
     */
    @ApiOperation("新增数据")
    @PostMapping("/insert")
    public ResultBean<Integer> insert(@RequestBody WorkFlowListenerParam workFlowListenerParam) {
        boolean rs = workFlowListenerParamService.save(workFlowListenerParam);
        return ResultBean.ofSuccess(rs ? workFlowListenerParam.getId() : 0);
    }

    /**
     * 修改数据
     *
     * @param workFlowListenerParam 实体对象
     * @return 修改结果
     */
    @ApiOperation("修改数据")
    @PutMapping("/update")
    public ResultBean<Boolean> update(@RequestBody WorkFlowListenerParam workFlowListenerParam) {
        return ResultBean.ofSuccess(workFlowListenerParamService.updateById(workFlowListenerParam));
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
        boolean b = workFlowListenerParamService.removeByIds(idList);
        return ResultBean.ofSuccess(b ? "删除成功！" : "删除失败！");
    }
}
