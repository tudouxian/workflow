package com.workflow.process.center.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.workflow.process.center.domain.entity.WorkFlowServiceCategory;

import java.util.List;

/**
 * 服务分类表(WorkFlowServiceCategory)表服务接口
 *
 * @author 土豆仙
 * @since 2021-07-03 09:34:00
 */
public interface WorkFlowServiceCategoryService extends IService<WorkFlowServiceCategory> {

    List<WorkFlowServiceCategory> treeByCateGroyName(WorkFlowServiceCategory workFlowServiceCategory);

    List<WorkFlowServiceCategory> listAllCategoryUnderCategoryId(Integer serviceCategoryId);
}
