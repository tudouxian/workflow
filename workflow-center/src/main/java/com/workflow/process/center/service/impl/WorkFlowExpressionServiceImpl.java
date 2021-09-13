package com.workflow.process.center.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.workflow.process.center.domain.entity.WorkFlowExpression;
import com.workflow.process.center.mapper.WorkFlowExpressionMapper;
import com.workflow.process.center.service.WorkFlowExpressionService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * 流程表达式(WorkFlowExpression)表服务实现类
 *
 * @author 土豆仙
 * @since 2021-08-23 16:24:55
 */
@Slf4j
@Service
public class WorkFlowExpressionServiceImpl extends ServiceImpl<WorkFlowExpressionMapper, WorkFlowExpression> implements WorkFlowExpressionService {

}
