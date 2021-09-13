package com.workflow.process.center.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.workflow.process.center.domain.entity.WorkFlowExtendHisprocinst;

/**
 * 流程引擎扩展表-主要记录流程实例运行状态(WorkFlowExtendHisprocinst)表服务接口
 *
 * @author 土豆仙
 * @since 2021-07-12 14:07:37
 */
public interface WorkFlowExtendHisprocinstService extends IService<WorkFlowExtendHisprocinst> {

    /**
     * 通过流程实例获取历史时的扩展信息
     *
     * @param processInstanceId 流程实例id
     * @return
     */
    WorkFlowExtendHisprocinst findExtendHisprocinstByProcessInstanceId(String processInstanceId);
}
