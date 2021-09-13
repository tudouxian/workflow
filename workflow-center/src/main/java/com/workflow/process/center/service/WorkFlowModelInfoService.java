package com.workflow.process.center.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.workflow.process.center.domain.entity.WorkFlowModelInfo;

/**
 * (WorkFlowModelInfo)表服务接口
 *
 * @author 土豆仙
 * @since 2021-06-26 22:25:20
 */
public interface WorkFlowModelInfoService extends IService<WorkFlowModelInfo> {

    void insertOrUpdate(WorkFlowModelInfo workFlowModelInfo);
}
