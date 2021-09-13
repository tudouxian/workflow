package com.workflow.process.center.service.impl;

import com.workflow.process.center.api.UserService;
import com.workflow.process.center.api.domain.WorkFlowUserDTO;
import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.service.WorkFlowUserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author: 土豆仙
 * @Date: 2021/6/23 15:26
 * @Description: RPC调用查询用户信息，及当前登录用户
 */
@Slf4j
@Service
public class WorkFlowUserServiceImpl implements WorkFlowUserService {

    @Autowired
    private UserService userService;

   /* @Autowired
    private RemoteUserService userService;*/

    @Override
    public ResultBean<List<WorkFlowUserDTO>> listUsers(WorkFlowUserDTO workFlowUserDTO) {
        ResultBean<List<WorkFlowUserDTO>> resultBean = userService.listUsers(workFlowUserDTO);

        return resultBean;
    }

    @Override
    public ResultBean<List<WorkFlowUserDTO>> selectAll(WorkFlowUserDTO workFlowUserDTO, Integer pageIndex, Integer pageSize) {
        ResultBean<List<WorkFlowUserDTO>> resultBean = userService.selectAll(workFlowUserDTO, pageIndex, pageSize);

        return resultBean;
    }

    @Override
    public List<WorkFlowUserDTO> selectUserByUserIds(List<String> idList) {
        ResultBean<List<WorkFlowUserDTO>> listResultBean = userService.selectUserByUserIds(idList);
        if (listResultBean != null && listResultBean.getData() != null) {
            return listResultBean.getData();
        }
        return null;

    }

    @Override
    public ResultBean<List<WorkFlowUserDTO>> selectUserByRoleKeys(List<String> keyList, Integer pageIndex, Integer pageSize) {
        ResultBean<List<WorkFlowUserDTO>> listResultBean = userService.selectUserByRoleKeys(keyList, pageIndex, pageSize);

        return listResultBean;
    }

    @Override
    public ResultBean<List<WorkFlowUserDTO>> selectAllByDeptKeys(List<String> keyList, Integer pageIndex, Integer pageSize) {
        ResultBean<List<WorkFlowUserDTO>> listResultBean = userService.selectUserByDeptKeys(keyList, pageIndex, pageSize);
        return listResultBean;
    }

    @Override
    public ResultBean<List<WorkFlowUserDTO>> selectAllByAreaKeys(List<String> keyList, Integer pageIndex, Integer pageSize) {
        ResultBean<List<WorkFlowUserDTO>> listResultBean = userService.selectUserByAreaKeys(keyList, pageIndex, pageSize);
        return listResultBean;
    }

    @Override
    public WorkFlowUserDTO selectUserByUserId(String userId) {
        ResultBean<WorkFlowUserDTO> listResultBean = userService.selectUserByUserId(userId);
        if (listResultBean != null && listResultBean.getData() != null) {
            return listResultBean.getData();
        }
        return null;
    }


}
