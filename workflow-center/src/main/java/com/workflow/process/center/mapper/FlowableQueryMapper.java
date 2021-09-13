package com.workflow.process.center.mapper;

import com.workflow.process.center.domain.dto.ProcessInstanceQueryDTO;
import com.workflow.process.center.domain.dto.TaskQueryDTO;
import com.workflow.process.center.domain.dto.ProcessInstanceDTO;
import com.workflow.process.center.domain.dto.ServiceReProcessDefinitionDTO;
import com.workflow.process.center.domain.dto.TaskDTO;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
*   @Author: 土豆仙
*   @Date: 2021/6/27 22:30
*   @Description: flowable 原生相关查询
*/
public interface FlowableQueryMapper {

    List<ProcessInstanceDTO> findMyProcessinstances(ProcessInstanceQueryDTO processInstanceQueryDTO);

    List<String> findToDoUsers();

    List<TaskDTO> findMyToDoTasks(TaskQueryDTO taskQueryDTO);

    List<TaskDTO> findAllDueDateTasks(TaskQueryDTO taskQueryDTO);

    List<TaskDTO> findMyToDoGroupTasks(TaskQueryDTO taskQueryDTO);

    List<String> findDoneUsers();

    List<TaskDTO> findMyDoneTasks(TaskQueryDTO taskQueryDTO);

    List<ServiceReProcessDefinitionDTO> listDefinitionsAll(ServiceReProcessDefinitionDTO serviceReProcessDefinitionDTO);

    List<Map<String,Object>> listDefinitionsCategory();

    List<Map<String,Object>> listDefinitionsKeyAndName(@Param("categoryId") String categoryId);

}
