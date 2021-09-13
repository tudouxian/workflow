package com.workflow.process.center.api;

import com.workflow.process.center.api.domain.WorkFlowUserDTO;
import com.workflow.process.center.common.ResultBean;

import java.util.List;

public interface UserService {

    /**
     * 获取用户列表
     */
    ResultBean<List<WorkFlowUserDTO>> listUsers(WorkFlowUserDTO workFlowUserDTO);


    /**
     * 获取用户列表-分页
     */
    ResultBean<List<WorkFlowUserDTO>> selectAll(WorkFlowUserDTO workFlowUserParam, Integer pageIndex, Integer pageSize);

    /**
     * 用户ids获取用户信息
     *
     * @return 结果
     */
    ResultBean<List<WorkFlowUserDTO>> selectUserByUserIds(List<String> idList);

    /**
     * 用户id获取用户信息
     *
     * @return 结果
     */
    ResultBean<WorkFlowUserDTO> selectUserByUserId(String userId);

    /**
     * 获取角色Key获取用户信息
     *
     * @return 结果
     */
    ResultBean<List<WorkFlowUserDTO>> selectUserByRoleKeys(List<String> keyList, Integer pageIndex, Integer pageSize);

    /**
     * 获取部门Key获取用户信息
     *
     * @return 结果
     */
    ResultBean<List<WorkFlowUserDTO>> selectUserByDeptKeys(List<String> keyList, Integer pageIndex, Integer pageSize);


    /**
     * groupKey获取用户信息
     *
     * @return 结果
     */
    ResultBean<List<WorkFlowUserDTO>> selectUserByAreaDeptRoleKeys(String area, String dept, String role);

    /**
     * groupKey获取用户信息-分页
     *
     * @return 结果
     */
    ResultBean<List<WorkFlowUserDTO>> selectPageUserByAreaDeptRoleKeys(String area, String dept, String role, Integer pageIndex, Integer pageSize);

    /**
     * groupKey获取用户信息-分页
     *
     * @return 结果
     */
    ResultBean<List<WorkFlowUserDTO>> selectUserByAreaKeys(List<String> keyList, Integer pageIndex, Integer pageSize);
}
