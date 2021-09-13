package com.workflow.process.center.controller;

import com.workflow.process.center.domain.entity.WorkFlowEmail;
import com.workflow.process.center.service.WorkFlowEmailService;
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
 * 租户邮箱服务配置(WorkFlowEmail)表控制层
 *
 * @author 土豆仙
 * @since 2021-09-06 10:58:04
 */
@Api(tags = "租户邮箱服务配置")
@RestController
@RequestMapping("/workFlowEmail")
public class WorkFlowEmailController {

    /**
     * 服务对象
     */
    @Autowired
    WorkFlowEmailService workFlowEmailService;

    /**
     * 查询所有不分页
     */
    @ApiOperation(value = "查询所有信息", notes = "不分页")
    @GetMapping("/list")
    public ResultBean<List<WorkFlowEmail>> list() {

        List<WorkFlowEmail> list = workFlowEmailService.list();
        return ResultBean.ofSuccess(list);
    }

    /**
     * 分页查询所有数据
     *
     * @param pageIndex     页码
     * @param pageSize      页长
     * @param workFlowEmail 查询实体
     * @return 所有数据
     */
    @ApiOperation("分页查询所有数据")
    @GetMapping("/selectAll")
    public ResultBean<List<WorkFlowEmail>> list(WorkFlowEmail workFlowEmail,
                                                @RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
                                                @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) {
        PageHelper.startPage(pageIndex, pageSize, true);
        List<WorkFlowEmail> list = workFlowEmailService.list(new QueryWrapper<>(workFlowEmail));
        PageInfo<WorkFlowEmail> pageInfo = new PageInfo<>(list);
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
    public ResultBean<WorkFlowEmail> selectOne(@PathVariable Serializable id) {
        return ResultBean.ofSuccess(workFlowEmailService.getById(id));
    }

    /**
     * 新增数据
     *
     * @param workFlowEmail 实体对象
     * @return 新增结果
     */
    @ApiOperation("新增数据")
    @PostMapping("/insert")
    public ResultBean<Integer> insert(@RequestBody WorkFlowEmail workFlowEmail) {
        boolean rs = workFlowEmailService.save(workFlowEmail);
        return ResultBean.ofSuccess(rs ? workFlowEmail.getId() : 0);
    }

    /**
     * 修改数据
     *
     * @param workFlowEmail 实体对象
     * @return 修改结果
     */
    @ApiOperation("修改数据")
    @PutMapping("/update")
    public ResultBean<Boolean> update(@RequestBody WorkFlowEmail workFlowEmail) {
        return ResultBean.ofSuccess(workFlowEmailService.updateById(workFlowEmail));
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
        boolean b = workFlowEmailService.removeByIds(idList);
        return ResultBean.ofSuccess(b ? "删除成功！" : "删除失败！");
    }
}
