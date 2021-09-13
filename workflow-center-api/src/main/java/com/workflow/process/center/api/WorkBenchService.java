package com.workflow.process.center.api;

import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.domain.dto.*;

import java.util.List;

public interface WorkBenchService {

    /**
     * 发起服务
     *
     *  @param startProcessInstanceByProcDefIdDTO
     */
    void startProcessService(StartProcessServiceDTO startProcessInstanceByProcDefIdDTO);

    /**
     * 查询我发起的
     *
     */
    ResultBean<List<ProcessInstanceDTO>> findMyProcessinstances(ProcessInstanceQueryDTO processInstanceQueryDTO);

    /**
     * 查询待办
     *
     */
    ResultBean<List<TaskDTO>> findMyToDoTasks(TaskQueryDTO taskQueryDTO);

    /**
     * 查询待办组任务
     *
     */
    ResultBean<List<TaskDTO>> findMyToDoGroupTasks(TaskQueryDTO taskQueryDTO);

    /**
     * 查询已办任务
     *
     */
    ResultBean<List<TaskDTO>> findMyDoneTasks(TaskQueryDTO taskQueryDTO);
}
