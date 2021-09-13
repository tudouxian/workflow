package com.workflow.process.center.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.workflow.process.center.domain.entity.WorkFlowServiceRelCategory;
import com.workflow.process.center.mapper.WorkFlowServiceRelCategoryMapper;
import com.workflow.process.center.service.WorkFlowServiceRelCategoryService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * 服务与服务分类关联表-服务可以配置在多个分类下(WorkFlowServiceRelCategory)表服务实现类
 *
 * @author 土豆仙
 * @since 2021-07-03 09:35:24
 */
@Slf4j
@Service
public class WorkFlowServiceRelCategoryServiceImpl extends ServiceImpl<WorkFlowServiceRelCategoryMapper, WorkFlowServiceRelCategory> implements WorkFlowServiceRelCategoryService {

}
