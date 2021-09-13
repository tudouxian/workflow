package com.workflow.process.center.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.workflow.process.center.domain.entity.WorkFlowServiceCategory;
import com.workflow.process.center.mapper.WorkFlowServiceCategoryMapper;
import com.workflow.process.center.service.WorkFlowServiceCategoryService;
import com.workflow.process.center.utils.tree.TreeUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 服务分类表(WorkFlowServiceCategory)表服务实现类
 *
 * @author 土豆仙
 * @since 2021-07-03 09:34:00
 */
@Slf4j
@Service
public class WorkFlowServiceCategoryServiceImpl extends ServiceImpl<WorkFlowServiceCategoryMapper, WorkFlowServiceCategory> implements WorkFlowServiceCategoryService {

    @Autowired
    private WorkFlowServiceCategoryMapper workFlowServiceCategoryMapper;

    @Override
    public List<WorkFlowServiceCategory> treeByCateGroyName(WorkFlowServiceCategory workFlowServiceCategory) {
        List<WorkFlowServiceCategory> allList = list(Wrappers
                .<WorkFlowServiceCategory>lambdaQuery(workFlowServiceCategory)
                .orderByAsc(WorkFlowServiceCategory::getOrderNum));

        List<WorkFlowServiceCategory> workFlowServiceCategoryTree = TreeUtils.generateTrees(allList);

        return workFlowServiceCategoryTree;
    }

    @Override
    public List<WorkFlowServiceCategory> listAllCategoryUnderCategoryId(Integer serviceCategoryId) {
        return workFlowServiceCategoryMapper.listAllCategoryUnderCategoryId(serviceCategoryId);
    }
}
