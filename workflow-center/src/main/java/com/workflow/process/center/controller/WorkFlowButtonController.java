package com.workflow.process.center.controller;

import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.domain.entity.WorkFlowButton;
import com.workflow.process.center.service.WorkFlowButtonService;


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
 * 流程按钮(WorkFlowButton)表控制层[不建议修改，如果有新增的方法，写在子类中]
 *
 * @author 土豆仙
 * @since 2021-06-21 16:39:39
 */
@Api(tags = "流程按钮")
@RestController
@RequestMapping("/workFlowButton")
public class WorkFlowButtonController {

    /**
     * 服务对象
     */
    @Autowired
    WorkFlowButtonService workFlowButtonService;

    /**
     * 查询所有不分页
     */
    @ApiOperation(value = "查询所有信息", notes = "不分页")
    @GetMapping("/list")
    public ResultBean<List<WorkFlowButton>> list() {

        List<WorkFlowButton> list = workFlowButtonService.list();
        return ResultBean.ofSuccess(list);
    }

    /**
     * 分页查询所有数据
     *
     * @param pageIndex      页码
     * @param pageSize       页长
     * @param workFlowButton 查询实体
     * @return 所有数据
     */
    @ApiOperation("分页查询所有数据")
    @GetMapping("/selectAll")
    public ResultBean<List<WorkFlowButton>> list(WorkFlowButton workFlowButton,
                                                 @RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
                                                 @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) {
        PageHelper.startPage(pageIndex, pageSize, true);
        List<WorkFlowButton> list = workFlowButtonService.list(new QueryWrapper<>(workFlowButton));
        PageInfo<WorkFlowButton> pageInfo = new PageInfo<>(list);
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
    public ResultBean<WorkFlowButton> selectOne(@PathVariable Serializable id) {
        return ResultBean.ofSuccess(workFlowButtonService.getById(id));
    }

    /**
     * 新增数据
     *
     * @param workFlowButton 实体对象
     * @return 新增结果
     */
    @ApiOperation("新增数据")
    @PostMapping("/insert")
    public ResultBean<Integer> insert(@RequestBody WorkFlowButton workFlowButton) {
        boolean rs = workFlowButtonService.save(workFlowButton);
        return ResultBean.ofSuccess(rs ? workFlowButton.getId() : 0);
    }

    /**
     * 修改数据
     *
     * @param workFlowButton 实体对象
     * @return 修改结果
     */
    @ApiOperation("修改数据")
    @PutMapping("/update")
    public ResultBean<String> update(@RequestBody WorkFlowButton workFlowButton) {
        boolean b = workFlowButtonService.updateById(workFlowButton);
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
    public ResultBean<String> delete(@RequestBody List<Integer> idList) {
        boolean b = workFlowButtonService.removeByIds(idList);
        return ResultBean.ofSuccess(b?"删除成功！":"删除失败！");
    }
}
