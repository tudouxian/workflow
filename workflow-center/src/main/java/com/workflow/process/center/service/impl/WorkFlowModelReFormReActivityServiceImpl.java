package com.workflow.process.center.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.workflow.process.center.domain.entity.WorkFlowModelReFormReActivity;
import com.workflow.process.center.mapper.WorkFlowModelReFormReActivityMapper;
import com.workflow.process.center.service.WorkFlowModelReFormReActivityService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * 节点对流程模型关联的表单的权限(WorkFlowModelReFormReActivity)表服务实现类
 *
 * @author 土豆仙
 * @since 2021-07-29 09:59:36
 */
@Slf4j
@Service
public class WorkFlowModelReFormReActivityServiceImpl extends ServiceImpl<WorkFlowModelReFormReActivityMapper, WorkFlowModelReFormReActivity> implements WorkFlowModelReFormReActivityService {

}
