package com.workflow.system.mapper;


import com.workflow.process.center.api.domain.WorkFlowAreaDTO;
import com.workflow.process.center.api.domain.WorkFlowDeptDTO;
import com.workflow.process.center.api.domain.WorkFlowRoleDTO;
import com.workflow.process.center.api.domain.WorkFlowUserDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;


@Mapper
public interface ProcessIdmMapper {
    List<WorkFlowAreaDTO> listAreas(WorkFlowAreaDTO workFlowAreaDTO);

    WorkFlowAreaDTO queryGroupByAreaKey(@Param("areaKey") String areaKey);

    List<WorkFlowDeptDTO> listDepts(WorkFlowDeptDTO workFlowDeptDTO);

    WorkFlowDeptDTO queryGroupByDeptKey(@Param("deptKey")String deptKey);


    List<WorkFlowRoleDTO> listRoles(WorkFlowRoleDTO workFlowRoleDTO);

    WorkFlowRoleDTO queryGroupByRoleKey(@Param("roleKey")String roleKey);

    //用户查询
    List<WorkFlowUserDTO> listUsers(WorkFlowUserDTO workFlowUserDTO);

    List<WorkFlowUserDTO> selectUserByUserIds(@Param("idList") List<String> idList);

    WorkFlowUserDTO selectUserByUserId(@Param("userId") String userId);

    List<WorkFlowUserDTO> selectUserByRoleKeys(@Param("keyList")List<String> keyList);

    List<WorkFlowUserDTO> selectUserByDeptKeys(@Param("keyList")List<String> keyList);

    List<WorkFlowUserDTO> selectUserByAreaKeys(@Param("keyList")List<String> keyList);

    List<WorkFlowUserDTO> selectUserByAreaDeptRoleKeys(@Param("area")String area,
                                                       @Param("dept")String dept,
                                                       @Param("role")String role);


}




