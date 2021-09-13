package com.workflow.process.center.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.workflow.process.center.domain.entity.WorkFlowListener;
import com.workflow.process.center.domain.entity.WorkFlowListenerParam;
import com.workflow.process.center.mapper.WorkFlowListenerMapper;
import com.workflow.process.center.mapper.WorkFlowListenerParamMapper;
import com.workflow.process.center.service.WorkFlowListenerService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 流程监听器(WorkFlowListener)表服务实现类
 *
 * @author 土豆仙
 * @since 2021-08-23 15:15:26
 */
@Slf4j
@Service
@Transactional
public class WorkFlowListenerServiceImpl extends ServiceImpl<WorkFlowListenerMapper, WorkFlowListener> implements WorkFlowListenerService {

    @Autowired
    private WorkFlowListenerParamMapper workFlowListenerParamMapper;

    @Override
    public boolean deleteByIds(List<Integer> idList) {

        //级联删除参数
        if (CollectionUtils.isNotEmpty(idList)){
            idList.stream()
                    .forEach(_id ->{
                        LambdaQueryWrapper<WorkFlowListenerParam> lambdaQueryWrapper = Wrappers.<WorkFlowListenerParam>lambdaQuery();
                        lambdaQueryWrapper.eq(WorkFlowListenerParam::getListenerId,_id);
                        workFlowListenerParamMapper.delete(lambdaQueryWrapper);

                    });
        }

        //删除
        boolean b = removeByIds(idList);

        return b;
    }
}
