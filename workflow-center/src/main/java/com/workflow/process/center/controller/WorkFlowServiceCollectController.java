package com.workflow.process.center.controller;

import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.domain.entity.WorkFlowServiceCollect;
import com.workflow.process.center.service.WorkFlowServiceCollectService;


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
 * 服务收藏表(WorkFlowServiceCollect)表控制层
 *
 * @author 土豆仙
 * @since 2021-07-03 09:34:32
 */
@Api(tags = "服务收藏表")
@RestController
@RequestMapping("/workFlowServiceCollect")
public class WorkFlowServiceCollectController {

    /**
     * 服务对象
     */
    @Autowired
    WorkFlowServiceCollectService workFlowServiceCollectService;

    /**
     * 查询所有不分页
     */
    @ApiOperation(value = "查询所有信息", notes = "不分页")
    @GetMapping("/list")
    public ResultBean<List<WorkFlowServiceCollect>> list() {

        List<WorkFlowServiceCollect> list = workFlowServiceCollectService.list();
        return ResultBean.ofSuccess(list);
    }

    /**
     * 分页查询所有数据
     *
     * @param pageIndex              页码
     * @param pageSize               页长
     * @param workFlowServiceCollect 查询实体
     * @return 所有数据
     */
    @ApiOperation("分页查询所有数据")
    @GetMapping("/selectAll")
    public ResultBean<List<WorkFlowServiceCollect>> list(WorkFlowServiceCollect workFlowServiceCollect,
                                                         @RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
                                                         @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) {
        PageHelper.startPage(pageIndex, pageSize, true);
        List<WorkFlowServiceCollect> list = workFlowServiceCollectService.list(new QueryWrapper<>(workFlowServiceCollect));
        PageInfo<WorkFlowServiceCollect> pageInfo = new PageInfo<>(list);
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
    public ResultBean<WorkFlowServiceCollect> selectOne(@PathVariable Serializable id) {
        return ResultBean.ofSuccess(workFlowServiceCollectService.getById(id));
    }

    /**
     * 新增数据
     *
     * @param workFlowServiceCollect 实体对象
     * @return 新增结果
     */
    @ApiOperation("新增数据")
    @PostMapping("/insert")
    public ResultBean<Integer> insert(@RequestBody WorkFlowServiceCollect workFlowServiceCollect) {
        boolean rs = workFlowServiceCollectService.save(workFlowServiceCollect);
        return ResultBean.ofSuccess(rs ? workFlowServiceCollect.getId() : 0);
    }

    /**
     * 修改数据
     *
     * @param workFlowServiceCollect 实体对象
     * @return 修改结果
     */
    @ApiOperation("修改数据")
    @PutMapping("/update")
    public ResultBean<String> update(@RequestBody WorkFlowServiceCollect workFlowServiceCollect) {
        boolean b = workFlowServiceCollectService.updateById(workFlowServiceCollect);
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
        boolean b = workFlowServiceCollectService.removeByIds(idList);
        return ResultBean.ofSuccess(b?"删除成功！":"删除失败！");
    }
}
