package com.workflow.process.center.controller;

import com.workflow.process.center.domain.entity.WorkFlowExtendHisprocinst;
import com.workflow.process.center.service.WorkFlowExtendHisprocinstService;
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
 * 流程引擎扩展表-主要记录流程实例运行状态(WorkFlowExtendHisprocinst)表控制层
 *
 * @author 土豆仙
 * @since 2021-07-12 14:07:37
 */
@Api(tags = "流程引擎扩展表-主要记录流程实例运行状态")
@RestController
@RequestMapping("/workFlowExtendHisprocinst")
public class WorkFlowExtendHisprocinstController {

    /**
     * 服务对象
     */
    @Autowired
    WorkFlowExtendHisprocinstService workFlowExtendHisprocinstService;

    /**
     * 查询所有不分页
     */
    @ApiOperation(value = "查询所有信息", notes = "不分页")
    @GetMapping("/list")
    public ResultBean<List<WorkFlowExtendHisprocinst>> list() {

        List<WorkFlowExtendHisprocinst> list = workFlowExtendHisprocinstService.list();
        return ResultBean.ofSuccess(list);
    }

    /**
     * 分页查询所有数据
     *
     * @param pageIndex                 页码
     * @param pageSize                  页长
     * @param workFlowExtendHisprocinst 查询实体
     * @return 所有数据
     */
    @ApiOperation("分页查询所有数据")
    @GetMapping("/selectAll")
    public ResultBean<List<WorkFlowExtendHisprocinst>> list(WorkFlowExtendHisprocinst workFlowExtendHisprocinst,
                                                            @RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
                                                            @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) {
        PageHelper.startPage(pageIndex, pageSize, true);
        List<WorkFlowExtendHisprocinst> list = workFlowExtendHisprocinstService.list(new QueryWrapper<>(workFlowExtendHisprocinst));
        PageInfo<WorkFlowExtendHisprocinst> pageInfo = new PageInfo<>(list);
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
    public ResultBean<WorkFlowExtendHisprocinst> selectOne(@PathVariable Serializable id) {
        return ResultBean.ofSuccess(workFlowExtendHisprocinstService.getById(id));
    }

    /**
     * 新增数据
     *
     * @param workFlowExtendHisprocinst 实体对象
     * @return 新增结果
     */
    @ApiOperation("新增数据")
    @PostMapping("/insert")
    public ResultBean<Integer> insert(@RequestBody WorkFlowExtendHisprocinst workFlowExtendHisprocinst) {
        boolean rs = workFlowExtendHisprocinstService.save(workFlowExtendHisprocinst);
        return ResultBean.ofSuccess(rs ? workFlowExtendHisprocinst.getId() : 0);
    }

    /**
     * 修改数据
     *
     * @param workFlowExtendHisprocinst 实体对象
     * @return 修改结果
     */
    @ApiOperation("修改数据")
    @PutMapping("/update")
    public ResultBean<Boolean> update(@RequestBody WorkFlowExtendHisprocinst workFlowExtendHisprocinst) {
        return ResultBean.ofSuccess(workFlowExtendHisprocinstService.updateById(workFlowExtendHisprocinst));
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
        return ResultBean.ofSuccess(workFlowExtendHisprocinstService.removeByIds(idList));
    }
}
