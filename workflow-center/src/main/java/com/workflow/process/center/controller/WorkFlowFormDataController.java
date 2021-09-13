package com.workflow.process.center.controller;

import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.domain.mongo.MongoWorkFlowFormData;
import com.workflow.process.center.service.CommonMongoService;
import com.workflow.process.center.service.WorkFlowFormDataService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 表单数据控制层
 *
 * @author 土豆仙
 * @since 2021-07-03 14:35:39
 */
@Api(tags = "自定义表单数据查询")
@RestController
@RequestMapping("/workFlowFormData")
public class WorkFlowFormDataController {

    @Autowired
    private CommonMongoService commonMongoService;

    @Autowired
    private WorkFlowFormDataService workFlowFormDataService;

    /**
     * 查询所有不分页
     */
 /*   @ApiOperation(value = "查询所有信息", notes = "不分页")
    @GetMapping("/list")
    public ResultBean<List<Document>> list() {

        return ResultBean.ofSuccess();
    }*/
    @ApiOperation(value = "获取流程启动定义表单", notes = "获取流程启动定义表单接口", httpMethod = "GET")
    @ApiImplicitParam(name = "processDefId", value = "流程定义ID", dataTypeClass = String.class, required = true, paramType = "path")
    @GetMapping("/getStartForm/{processDefId}")
    public ResultBean<MongoWorkFlowFormData> getStartFormData(@PathVariable String processDefId) {

        MongoWorkFlowFormData workFlowFormData = workFlowFormDataService.getStartFormData(processDefId);

        return ResultBean.ofSuccess(workFlowFormData);
    }

    @ApiOperation(value = "获取待办任务表单", notes = "获取待办任务表单接口", httpMethod = "GET")
    @ApiImplicitParam(name = "taskId", value = "任务ID", dataTypeClass = String.class, required = true, paramType = "path")
    @GetMapping("/getTaskFormData/{taskId}")
    public ResultBean<MongoWorkFlowFormData> getTaskFormData(@PathVariable String taskId) {

        MongoWorkFlowFormData workFlowFormData = workFlowFormDataService.getTaskFormData(taskId);
        return ResultBean.ofSuccess(workFlowFormData);
    }

    @ApiOperation(value = "获取已办任务表单", notes = "获取已办任务表单接口", httpMethod = "GET")
    @ApiImplicitParam(name = "taskId", value = "任务ID", dataTypeClass = String.class, required = true, paramType = "path")
    @GetMapping("/getCompletedTaskFormData/{taskId}")
    public ResultBean<MongoWorkFlowFormData> getCompletedTaskFormData(@PathVariable String taskId) {

        MongoWorkFlowFormData workFlowFormData = workFlowFormDataService.getCompletedTaskFormData(taskId);
        return ResultBean.ofSuccess(workFlowFormData);
    }

    @ApiOperation(value = "通过业务Key获取流程流转表单", notes = "通过业务Key获取流程流转表单(包括表单字段和值)", httpMethod = "GET")
    @ApiImplicitParam(name = "businessKey", value = "业务唯一标识", dataTypeClass = String.class, required = true, paramType = "path")
    @GetMapping("/getFormData/{businessKey}")
    public ResultBean<List<MongoWorkFlowFormData>> getFormData(@PathVariable String businessKey) {

        return ResultBean.ofSuccess();
    }


}
