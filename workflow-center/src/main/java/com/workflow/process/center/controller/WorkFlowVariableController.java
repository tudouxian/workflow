package com.workflow.process.center.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.domain.entity.WorkFlowVariable;
import com.workflow.process.center.service.WorkFlowVariableService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;
import org.flowable.engine.ProcessEngine;
import org.flowable.variable.api.history.HistoricVariableInstance;
import org.flowable.variable.api.history.HistoricVariableInstanceQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.io.Serializable;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 运行时变量信息Controller
 *
 * @author zhongmx
 * @date 2021-06-19
 */
@Api(tags = "流程变量管理")
@RestController
@RequestMapping("/workFlowVariable")
public class WorkFlowVariableController extends BaseController {
    /**
     * 服务对象
     */
    @Autowired
    WorkFlowVariableService workFlowVariableService;

    @Autowired
    private ProcessEngine processEngine;

    /**
     * 查询所有不分页
     */
    @ApiOperation(value = "查询所有信息", notes = "不分页")
    @GetMapping("/list")
    public ResultBean<List<WorkFlowVariable>> list() {

        List<WorkFlowVariable> list = workFlowVariableService.list();
        return ResultBean.ofSuccess(list);
    }

    /**
     * 分页查询所有数据
     *
     * @param pageIndex        页码
     * @param pageSize         页长
     * @param workFlowVariable 查询实体
     * @return 所有数据
     */
    @ApiOperation("分页查询所有数据")
    @GetMapping("/selectAll")
    public ResultBean<List<WorkFlowVariable>> list(WorkFlowVariable workFlowVariable,
                                                   @RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
                                                   @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) {
        PageHelper.startPage(pageIndex, pageSize, true);

        List<WorkFlowVariable> list = null;
        if (workFlowVariable.getIsRunTimeVariable()) {
            list = workFlowVariableService.list(new QueryWrapper<>(workFlowVariable));
            if (CollectionUtils.isNotEmpty(list)) {
                list.stream()
                        .forEach(_workFlowVariable -> {

                            if (ObjectUtils.isNotEmpty(_workFlowVariable.getDouble_())) {
                                _workFlowVariable.setVariableValue(_workFlowVariable.getDouble_());
                            } else if (ObjectUtils.isNotEmpty(_workFlowVariable.getLong_())) {
                                _workFlowVariable.setVariableValue(_workFlowVariable.getLong_());

                            } else if (ObjectUtils.isNotEmpty(_workFlowVariable.getText())) {
                                _workFlowVariable.setVariableValue(_workFlowVariable.getText());
                            } else {
                                _workFlowVariable.setVariableValue(_workFlowVariable.getText2());
                            }

                        });
            }
        }else {
            HistoricVariableInstanceQuery historicVariableInstanceQuery = processEngine.getHistoryService().createHistoricVariableInstanceQuery();

            if (StringUtils.isNotEmpty(workFlowVariable.getProcInstId())){
                historicVariableInstanceQuery.processInstanceId(workFlowVariable.getProcInstId());
            }
            if (StringUtils.isNotEmpty(workFlowVariable.getExecutionId())){
                historicVariableInstanceQuery.executionId(workFlowVariable.getExecutionId());
            }
            if (StringUtils.isNotEmpty(workFlowVariable.getTaskId())){
                historicVariableInstanceQuery.taskId(workFlowVariable.getTaskId());
            }
            if (StringUtils.isNotEmpty(workFlowVariable.getName())){
                historicVariableInstanceQuery.variableNameLike(workFlowVariable.getName());
            }
            List<HistoricVariableInstance> historicVariableInstanceList = historicVariableInstanceQuery.list();

            list = historicVariableInstanceList.stream().map(_historicVariableInstance -> {
                WorkFlowVariable _workFlowVariable = new WorkFlowVariable();
                _workFlowVariable.setId(_historicVariableInstance.getId());
                _workFlowVariable.setProcInstId(_historicVariableInstance.getProcessInstanceId());
                _workFlowVariable.setTaskId(_historicVariableInstance.getTaskId());
                _workFlowVariable.setName(_historicVariableInstance.getVariableName());
                _workFlowVariable.setVariableValue(_historicVariableInstance.getValue());
                _workFlowVariable.setType(_historicVariableInstance.getVariableTypeName());

                return _workFlowVariable;
            }).collect(Collectors.toList());
        }


        PageInfo<WorkFlowVariable> pageInfo = new PageInfo<>(list);
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
    public ResultBean<WorkFlowVariable> selectOne(@PathVariable Serializable id) {
        return ResultBean.ofSuccess(workFlowVariableService.getById(id));
    }

    /**
     * 新增数据
     *
     * @param workFlowVariable 实体对象
     * @return 新增结果
     */
    @ApiOperation("新增数据")
    @PostMapping("/insert")
    public ResultBean<String> insert(@RequestBody WorkFlowVariable workFlowVariable) {
        boolean rs = workFlowVariableService.save(workFlowVariable);
        return ResultBean.ofSuccess(rs ? workFlowVariable.getId() : null);
    }

    /**
     * 修改数据
     *
     * @param workFlowVariable 实体对象
     * @return 修改结果
     */
    @ApiOperation("修改数据")
    @PutMapping("/update")
    public ResultBean<String> update(@RequestBody WorkFlowVariable workFlowVariable) {
        boolean b = workFlowVariableService.updateById(workFlowVariable);
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
    public ResultBean<String> delete(@RequestBody List<Long> idList) {
        boolean b = workFlowVariableService.removeByIds(idList);
        return ResultBean.ofSuccess(b ? "删除成功！" : "删除失败！");
    }
}
