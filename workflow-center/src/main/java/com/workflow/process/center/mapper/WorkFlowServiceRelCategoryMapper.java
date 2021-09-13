package com.workflow.process.center.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.workflow.process.center.domain.entity.WorkFlowServiceRelCategory;

/**
 * 服务与服务分类关联表-服务可以配置在多个分类下(WorkFlowServiceRelCategory)表数据库访问层
 *
 * @author 土豆仙
 * @since 2021-07-03 09:35:23
 */
public interface WorkFlowServiceRelCategoryMapper extends BaseMapper<WorkFlowServiceRelCategory> {

}
