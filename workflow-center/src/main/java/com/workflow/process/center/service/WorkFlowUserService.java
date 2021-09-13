package com.workflow.process.center.service;

import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.api.domain.WorkFlowUserDTO;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

public interface WorkFlowUserService {

    ResultBean<List<WorkFlowUserDTO>> listUsers(WorkFlowUserDTO workFlowUserDTO);

    ResultBean<List<WorkFlowUserDTO>> selectAll(WorkFlowUserDTO workFlowUserDTO, Integer pageIndex, Integer pageSize);

     List<WorkFlowUserDTO> selectUserByUserIds(List<String> idList);

     ResultBean<List<WorkFlowUserDTO>> selectUserByRoleKeys(List<String> keyList, Integer pageIndex, Integer pageSize);

    ResultBean<List<WorkFlowUserDTO>> selectAllByDeptKeys(List<String> keyList, Integer pageIndex, Integer pageSize);

    ResultBean<List<WorkFlowUserDTO>> selectAllByAreaKeys(List<String> keyList, Integer pageIndex, Integer pageSize);

    WorkFlowUserDTO selectUserByUserId(String userId);


}
