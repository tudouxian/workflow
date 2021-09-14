package com.workflow.form.center.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.workflow.form.center.domain.entity.WorkFlowFormModel;
import com.workflow.form.center.mapper.WorkFlowFormModelMapper;
import com.workflow.form.center.service.WorkFlowFormModelService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * 自定义表单模型表(WorkFlowFormModel)表服务实现类
 *
 * @author 土豆仙
 * @since 2021-07-29 10:54:57
 */
@Slf4j
@Service
public class WorkFlowFormModelServiceImpl extends ServiceImpl<WorkFlowFormModelMapper, WorkFlowFormModel> implements WorkFlowFormModelService {

}
