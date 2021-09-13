package com.workflow.process.center.service;

import com.workflow.process.center.api.domain.WorkFlowUserDTO;
import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.domain.dto.*;
import com.workflow.process.center.domain.vo.CommentInfoVO;
import com.workflow.process.center.domain.dto.ProcessInstanceDTO;
import com.workflow.process.center.domain.dto.TaskDTO;
import org.flowable.engine.runtime.ProcessInstance;

import java.util.List;

public interface FlowableWorkBenchService {

    ResultBean<List<ProcessInstanceDTO>> findMyProcessinstances(ProcessInstanceQueryDTO processInstanceQueryDTO);


    ResultBean<List<WorkFlowUserDTO>> findToDoUsers();

    ResultBean<List<TaskDTO>> findMyToDoTasks(TaskQueryDTO taskQueryDTO);

    ResultBean<List<TaskDTO>> findMyToDoGroupTasks(TaskQueryDTO taskQueryDTO);

    ResultBean<List<WorkFlowUserDTO>> findDoneUsers();

    ResultBean<List<TaskDTO>> findMyDoneTasks(TaskQueryDTO taskQueryDTO);

    List<CommentInfoVO> getCommentInfosByProcessInstanceId(String processInstanceId);

    ProcessInstance startProcessInstanceByKey(StartProcessInstanceByKeyDTO params);

    ProcessInstance startProcessService(StartProcessServiceDTO startProcessInstanceByProcDefIdDTO);

    boolean migrationValidationProcessService(MigrationValidationProcessServiceDTO migrationValidationProcessServiceDTO);

    ResultBean<List<TaskDTO>> findAllDueDateTasks(TaskQueryDTO taskQueryDTO);
}
