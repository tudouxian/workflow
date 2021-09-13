package com.workflow.process.center.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.workflow.process.center.domain.entity.WorkFlowExtendHisprocinst;
import com.workflow.process.center.mapper.WorkFlowExtendHisprocinstMapper;
import com.workflow.process.center.service.WorkFlowExtendHisprocinstService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * 流程引擎扩展表-主要记录流程实例运行状态(WorkFlowExtendHisprocinst)表服务实现类
 *
 * @author 土豆仙
 * @since 2021-07-12 14:07:37
 */
@Slf4j
@Service
public class WorkFlowExtendHisprocinstServiceImpl extends ServiceImpl<WorkFlowExtendHisprocinstMapper, WorkFlowExtendHisprocinst> implements WorkFlowExtendHisprocinstService {

    @Override
    public WorkFlowExtendHisprocinst findExtendHisprocinstByProcessInstanceId(String processInstanceId) {
        LambdaQueryWrapper<WorkFlowExtendHisprocinst> extendHisprocinstLambdaQueryWrapper = new LambdaQueryWrapper<>();
        extendHisprocinstLambdaQueryWrapper.eq(WorkFlowExtendHisprocinst::getProcessInstanceId, processInstanceId);
        return this.getOne(extendHisprocinstLambdaQueryWrapper);
    }
}
