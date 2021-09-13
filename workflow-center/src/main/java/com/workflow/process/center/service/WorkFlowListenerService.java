package com.workflow.process.center.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.workflow.process.center.domain.entity.WorkFlowListener;

import java.util.List;

/**
 * 流程监听器(WorkFlowListener)表服务接口
 *
 * @author 土豆仙
 * @since 2021-08-23 15:15:26
 */
public interface WorkFlowListenerService extends IService<WorkFlowListener> {

    boolean deleteByIds(List<Integer> idList);
}
