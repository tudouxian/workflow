package com.workflow.process.center.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.workflow.process.center.domain.entity.WorkFlowModel;
import org.flowable.bpmn.model.BpmnModel;
import org.flowable.engine.repository.Model;

/**
 * 流程模型信息(WorkFlowModel)表服务接口
 *
 * @author 土豆仙
 * @since 2021-08-26 14:17:52
 */
public interface WorkFlowModelService extends IService<WorkFlowModel> {


    BpmnModel getBpmnModel(String modelId);
}
