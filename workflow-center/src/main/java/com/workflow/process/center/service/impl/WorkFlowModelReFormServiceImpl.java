package com.workflow.process.center.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.workflow.process.center.domain.entity.WorkFlowModelReForm;
import com.workflow.process.center.mapper.WorkFlowModelReFormMapper;
import com.workflow.process.center.service.WorkFlowModelReFormService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * 流程模型关联表单（先只控制到表级读写权限=》后期再扩展到表内字段的读写权限）(WorkFlowModelReForm)表服务实现类
 *
 * @author 土豆仙
 * @since 2021-07-29 09:59:11
 */
@Slf4j
@Service
public class WorkFlowModelReFormServiceImpl extends ServiceImpl<WorkFlowModelReFormMapper, WorkFlowModelReForm> implements WorkFlowModelReFormService {

}
