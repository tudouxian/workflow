package com.workflow.process.center.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.workflow.process.center.domain.entity.WorkFlowService;
import com.workflow.process.center.domain.entity.WorkFlowServiceCategory;
import com.workflow.process.center.mapper.WorkFlowServiceMapper;
import com.workflow.process.center.service.WorkFlowServiceCategoryService;
import com.workflow.process.center.service.WorkFlowServiceService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

import static com.workflow.process.center.common.contant.CommonContant.PUBLISH;

/**
 * 服务表(WorkFlowService)表服务实现类
 *
 * @author 土豆仙
 * @since 2021-07-03 09:18:06
 */
@Slf4j
@Service
public class WorkFlowServiceServiceImpl extends ServiceImpl<WorkFlowServiceMapper, WorkFlowService> implements WorkFlowServiceService {

    @Autowired
    private WorkFlowServiceCategoryService workFlowServiceCategoryService;

    @Autowired
    private WorkFlowServiceMapper workFlowServiceMapper;

    @Override
    public List<WorkFlowService> listAllServiceUnderCategory(WorkFlowService workFlowService) {

        List<Integer> categoryIds = new ArrayList<>();
        if (workFlowService != null && workFlowService.getServiceCategoryId() != null) {
            categoryIds.add(workFlowService.getServiceCategoryId());
        }
        //查询出目录下所有分类ID
        List<WorkFlowServiceCategory> categorylist = workFlowServiceCategoryService.listAllCategoryUnderCategoryId(workFlowService.getServiceCategoryId());
        if (CollectionUtils.isNotEmpty(categorylist)) {
            categorylist.stream().forEach(_c -> {
                categoryIds.add(_c.getId());
            });
        }
        LambdaQueryWrapper<WorkFlowService> lambdaQuery = Wrappers.<WorkFlowService>lambdaQuery();
        lambdaQuery.in(WorkFlowService::getServiceCategoryId, categoryIds);
        lambdaQuery.eq(WorkFlowService::getStatus, PUBLISH);
        List<WorkFlowService> list = list(lambdaQuery);
        return list;
    }

    @Override
    public List<WorkFlowService> listAll(WorkFlowService workFlowService) {

        List<WorkFlowService> list =  workFlowServiceMapper.listAll(workFlowService);
        return list;
    }
}
