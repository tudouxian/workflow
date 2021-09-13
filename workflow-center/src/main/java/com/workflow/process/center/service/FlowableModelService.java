package com.workflow.process.center.service;

import com.workflow.process.center.domain.dto.ModelInfoDTO;
import com.workflow.process.center.domain.entity.WorkFlowModel;
import com.workflow.process.center.domain.entity.WorkFlowModelInfo;
import com.workflow.process.center.domain.vo.ActivityVO;
import com.workflow.process.center.domain.vo.HighLightedNodeVO;
import org.flowable.engine.repository.Deployment;

import java.io.InputStream;
import java.util.List;

public interface FlowableModelService {

    WorkFlowModel createInitBpmn(WorkFlowModelInfo workFlowModelInfo);

    ModelInfoDTO loadBpmnXmlByModelId(String modelId);

    String importBpmnModel(ModelInfoDTO modelInfoDTO);

    void publishBpmn(String modelId);

    void stopBpmn(String modelId);

    /**
     * 部署流程
     *
     * @param modelInfo 模型的扩展信息
     * @return
     */
    Deployment deployBpmn(WorkFlowModelInfo modelInfo);

    HighLightedNodeVO getHighLightedNodeVoByProcessInstanceId(String processInstanceId);

    ActivityVO getOneActivityVoByProcessInstanceIdAndActivityId(String processInstanceId, String activityId);

    List<ActivityVO> getProcessActivityVosByProcessInstanceId(String processInstanceId);

}
