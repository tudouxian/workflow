package com.workflow.process.center.service.dubbo;

import com.workflow.process.center.api.WorkBenchService;
import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.domain.dto.*;
import com.workflow.process.center.service.FlowableWorkBenchService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Component;

import java.util.List;

//@DubboService
@Component
public class WorkBenchServiceImpl implements WorkBenchService {

    @Lazy
    @Autowired
    private FlowableWorkBenchService flowableWorkBenchService;

    @Override
    public void startProcessService(StartProcessServiceDTO startProcessServiceDTO) {

        flowableWorkBenchService.startProcessService(startProcessServiceDTO);
    }

    @Override
    public ResultBean<List<ProcessInstanceDTO>> findMyProcessinstances(ProcessInstanceQueryDTO processInstanceQueryDTO) {
        ResultBean<List<ProcessInstanceDTO>> myProcessinstances = flowableWorkBenchService.findMyProcessinstances(processInstanceQueryDTO);

        return myProcessinstances;
    }

    @Override
    public ResultBean<List<TaskDTO>> findMyToDoTasks(TaskQueryDTO taskQueryDTO) {

        ResultBean<List<TaskDTO>> myToDoTasks = flowableWorkBenchService.findMyToDoTasks(taskQueryDTO);

        return myToDoTasks;
    }

    @Override
    public ResultBean<List<TaskDTO>> findMyToDoGroupTasks(TaskQueryDTO taskQueryDTO) {

        ResultBean<List<TaskDTO>> myToDoGroupTasks = flowableWorkBenchService.findMyToDoGroupTasks(taskQueryDTO);

        return myToDoGroupTasks;
    }

    @Override
    public ResultBean<List<TaskDTO>> findMyDoneTasks(TaskQueryDTO taskQueryDTO) {

        ResultBean<List<TaskDTO>> myDoneTasks = flowableWorkBenchService.findMyDoneTasks(taskQueryDTO);

        return myDoneTasks;
    }
}
