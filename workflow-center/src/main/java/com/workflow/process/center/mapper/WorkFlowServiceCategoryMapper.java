package com.workflow.process.center.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.workflow.process.center.domain.entity.WorkFlowServiceCategory;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 服务分类表(WorkFlowServiceCategory)表数据库访问层
 *
 * @author 土豆仙
 * @since 2021-07-03 09:34:00
 */
public interface WorkFlowServiceCategoryMapper extends BaseMapper<WorkFlowServiceCategory> {

    List<WorkFlowServiceCategory> listAllCategoryUnderCategoryId(@Param("serviceCategoryId") Integer serviceCategoryId);
}
