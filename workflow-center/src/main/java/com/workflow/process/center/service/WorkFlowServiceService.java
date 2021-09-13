package com.workflow.process.center.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.workflow.process.center.domain.entity.WorkFlowService;

import java.util.List;

/**
 * 服务表(WorkFlowService)表服务接口
 *
 * @author 土豆仙
 * @since 2021-07-03 09:18:06
 */
public interface WorkFlowServiceService extends IService<WorkFlowService> {

    List<WorkFlowService> listAllServiceUnderCategory(WorkFlowService workFlowService);

    List<WorkFlowService> listAll(WorkFlowService workFlowService);
}
