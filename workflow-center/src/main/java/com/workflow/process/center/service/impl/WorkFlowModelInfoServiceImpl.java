package com.workflow.process.center.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.workflow.process.center.common.enums.ModelStatusEnum;
import com.workflow.process.center.domain.entity.WorkFlowModel;
import com.workflow.process.center.domain.entity.WorkFlowModelInfo;
import com.workflow.process.center.mapper.WorkFlowModelInfoMapper;
import com.workflow.process.center.service.FlowableModelService;
import com.workflow.process.center.service.WorkFlowModelInfoService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * (WorkFlowModelInfo)表服务实现类
 *
 * @author 土豆仙
 * @since 2021-06-26 22:25:20
 */
@Slf4j
@Service
@Transactional
public class WorkFlowModelInfoServiceImpl extends ServiceImpl<WorkFlowModelInfoMapper, WorkFlowModelInfo> implements WorkFlowModelInfoService {

    @Autowired
    private FlowableModelService flowableModelService;

    @Override
    public void insertOrUpdate(WorkFlowModelInfo workFlowModelInfo) {
        //新增需要初始化bpmn-关联act_de_model
        if (workFlowModelInfo.getId() == null) {

            //使用自建模型表存储
            WorkFlowModel model = flowableModelService.createInitBpmn(workFlowModelInfo);

            workFlowModelInfo.setModelId(model.getId());
            // workFlowModelInfo.setModelType(AbstractModel.MODEL_TYPE_BPMN);
            workFlowModelInfo.setStatus(ModelStatusEnum.CG.getStatus());
        }
        saveOrUpdate(workFlowModelInfo);
    }
}
