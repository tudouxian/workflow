package com.workflow.process.center.controller;

import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.domain.dto.ModelInfoDTO;
import com.workflow.process.center.domain.vo.ActivityVO;
import com.workflow.process.center.domain.vo.HighLightedNodeVO;
import com.workflow.process.center.service.AuthService;
import com.workflow.process.center.service.FlowableModelService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.flowable.engine.ProcessEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

/**
 * @Author: 土豆仙
 * @Date: 2021/6/20 11:44
 * @Description: flowable 原生支持流程模型
 */
@Api(tags = "流程模型相关")
@RestController
@RequestMapping("/flowable/modeler")
public class FlowableModelController {

    @Autowired
    private ProcessEngine processEngine;

    @Autowired
    FlowableModelService flowableModelService;

    @Autowired
    AuthService authService;


    /**
     * 通过主键查询单条数据
     *
     * @param modelId 主键
     * @return 单条数据
     */
    @ApiOperation("通过模型id查询模型")
    @GetMapping("/getBpmnByModelId/{modelId}")
    public ResultBean<ModelInfoDTO> selectOne(@PathVariable String modelId) {

        ModelInfoDTO modelInfoDTO = flowableModelService.loadBpmnXmlByModelId(modelId);
        return ResultBean.ofSuccess(modelInfoDTO);
    }


    /**
     * 保存模型设计器bpmn
     *
     * @param modelInfoDTO
     * @return 单条数据
     */
    @ApiOperation("保存模型设计器bpmn")
    @PostMapping(value = "/saveBpmnModel")
    public ResultBean<String> saveBpmnModel(@RequestBody @Valid ModelInfoDTO modelInfoDTO) {
        flowableModelService.importBpmnModel(modelInfoDTO);
        return ResultBean.ofSuccess("保存模型成功！");
    }

    /**
     * 发布Bpmn
     *
     * @param modelId 模型id
     * @return
     */
    @ApiOperation("发布Bpmn")
    @PostMapping("/publishBpmn/{modelId}")
    public ResultBean<String> publishBpmn(@PathVariable String modelId) {
        flowableModelService.publishBpmn(modelId);
        return ResultBean.ofSuccess("发布成功！");
    }

    /**
     * 停用Bpmn
     *
     * @param modelId 模型id
     * @return
     */
    @ApiOperation("停用Bpmn")
    @PostMapping(value = "/stopBpmn/{modelId}")
    public ResultBean<String> stopBpmn(@PathVariable String modelId) {
        flowableModelService.stopBpmn(modelId);
        return ResultBean.ofSuccess("停用成功！");
    }


    /**
     * 通过流程实例id获取流程图和高亮线和高亮节点
     *
     * @param processInstanceId 流程实例id
     * @return
     */
    @ApiOperation("通过流程实例id获取流程图和高亮线和高亮节点")
    @GetMapping("/getHighLightedNodeVoByProcessInstanceId/{processInstanceId}")
    public ResultBean<HighLightedNodeVO> getHighLightedNodeVoByProcessInstanceId(@PathVariable String processInstanceId) {

        HighLightedNodeVO highLightedNodeVO = flowableModelService.getHighLightedNodeVoByProcessInstanceId(processInstanceId);
        return ResultBean.ofSuccess(highLightedNodeVO);
    }

    /**
     * 过流程实例id获取节点的信息
     *
     * @param processInstanceId 流程实例id
     * @param activityId        节点id
     * @return
     */
    @ApiOperation("过流程实例id获取节点的信息")
    @GetMapping("/getOneActivityVoByProcessInstanceIdAndActivityId/{processInstanceId}/{activityId}")
    public ResultBean<ActivityVO> getOneActivityVoByProcessInstanceIdAndActivityId(@PathVariable String processInstanceId, @PathVariable String activityId) {
        ActivityVO processActivityVO = flowableModelService.getOneActivityVoByProcessInstanceIdAndActivityId(processInstanceId, activityId);
        return ResultBean.ofSuccess(processActivityVO);
    }

    /**
     * 通过流程实例id获取每个节点的审批人信息
     *
     * @param processInstanceId 流程实例id
     * @return
     */
    @ApiOperation("通过流程实例id获取每个节点的审批人信息")
    @GetMapping("/getProcessActivityVosByProcessInstanceId/{processInstanceId}")
    public ResultBean<List<ActivityVO>> getProcessActivityVosByProcessInstanceId(@PathVariable String processInstanceId) {

        List<ActivityVO> processActivityVos = flowableModelService.getProcessActivityVosByProcessInstanceId(processInstanceId);
        return ResultBean.ofSuccess(processActivityVos);
    }
}

