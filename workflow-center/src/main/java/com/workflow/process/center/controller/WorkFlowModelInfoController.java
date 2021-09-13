package com.workflow.process.center.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.domain.entity.WorkFlowModelInfo;
import com.workflow.process.center.service.FlowableModelService;
import com.workflow.process.center.service.WorkFlowModelInfoService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.io.Serializable;
import java.util.List;

/**
 * (WorkFlowModelInfo)表控制层
 *
 * @author 土豆仙
 * @since 2021-06-26 22:25:21
 */
@Api(tags = "flowable模型信息")
@RestController
@RequestMapping("/workFlowModelInfo")
public class WorkFlowModelInfoController {

    /**
     * 服务对象
     */
    @Autowired
    WorkFlowModelInfoService workFlowModelInfoService;

    @Autowired
    private FlowableModelService flowableModelService;

    /**
     * 查询所有不分页
     */
    @ApiOperation(value = "查询所有信息", notes = "不分页")
    @GetMapping("/list")
    public ResultBean<List<WorkFlowModelInfo>> list() {

        List<WorkFlowModelInfo> list = workFlowModelInfoService.list();
        return ResultBean.ofSuccess(list);
    }

    /**
     * 分页查询所有数据
     *
     * @param pageIndex         页码
     * @param pageSize          页长
     * @param workFlowModelInfo 查询实体
     * @return 所有数据
     */
    @ApiOperation("分页查询所有数据")
    @GetMapping("/selectAll")
    public ResultBean<List<WorkFlowModelInfo>> list(WorkFlowModelInfo workFlowModelInfo,
                                                    @RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
                                                    @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) {
        PageHelper.startPage(pageIndex, pageSize, true);
        List<WorkFlowModelInfo> list = workFlowModelInfoService.list(new QueryWrapper<>(workFlowModelInfo));
        PageInfo<WorkFlowModelInfo> pageInfo = new PageInfo<>(list);
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
    public ResultBean<WorkFlowModelInfo> selectOne(@PathVariable Serializable id) {
        return ResultBean.ofSuccess(workFlowModelInfoService.getById(id));
    }

    /**
     * 新增数据
     *
     * @param workFlowModelInfo 实体对象
     * @return 新增结果
     */
    @ApiOperation("新增数据")
    @PostMapping("/insert")
    public ResultBean<Integer> insert(@RequestBody WorkFlowModelInfo workFlowModelInfo) {
        boolean rs = workFlowModelInfoService.save(workFlowModelInfo);
        return ResultBean.ofSuccess(rs ? workFlowModelInfo.getId() : 0);
    }

    /**
     * 修改数据
     *
     * @param workFlowModelInfo 实体对象
     * @return 修改结果
     */
    @ApiOperation("修改数据")
    @PutMapping("/update")
    public ResultBean<String> update(@RequestBody WorkFlowModelInfo workFlowModelInfo) {
        boolean b = workFlowModelInfoService.updateById(workFlowModelInfo);
        return ResultBean.ofSuccess(b ? "修改成功！" : "修改失败！");
    }

    /**
     * 单条/批量删除数据
     *
     * @param idList 主键集合
     * @return 删除结果
     */
    @ApiOperation("单条/批量删除数据")
    @DeleteMapping("/delete")
    public ResultBean<String> delete(@RequestParam("idList") List<Long> idList) {
        boolean b = workFlowModelInfoService.removeByIds(idList);
        return ResultBean.ofSuccess(b ? "删除成功！" : "删除失败！");
    }


    //保存更新
    @ApiOperation("新增或更新数据")
    @PostMapping("/insertOrUpdate")
    public ResultBean<WorkFlowModelInfo> insertOrUpdate(@RequestBody @Valid WorkFlowModelInfo workFlowModelInfo) {

        workFlowModelInfoService.insertOrUpdate(workFlowModelInfo);

        return ResultBean.ofSuccess(workFlowModelInfo);
    }
}
