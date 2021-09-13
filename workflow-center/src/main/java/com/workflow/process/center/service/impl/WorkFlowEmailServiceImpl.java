package com.workflow.process.center.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.workflow.process.center.domain.entity.WorkFlowEmail;
import com.workflow.process.center.mapper.WorkFlowEmailMapper;
import com.workflow.process.center.service.WorkFlowEmailService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * 租户邮箱服务配置(WorkFlowEmail)表服务实现类
 *
 * @author 土豆仙
 * @since 2021-09-06 10:58:04
 */
@Slf4j
@Service
public class WorkFlowEmailServiceImpl extends ServiceImpl<WorkFlowEmailMapper, WorkFlowEmail> implements WorkFlowEmailService {

}
