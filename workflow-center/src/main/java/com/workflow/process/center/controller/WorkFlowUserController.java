package com.workflow.process.center.controller;

import com.workflow.process.center.api.domain.WorkFlowUserDTO;
import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.service.WorkFlowUserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @Author: 土豆仙
 * @Date: 2021/6/23 14:41
 * @Description: 流程用户管理
 */
@Api(tags = "流程用户管理")
@RestController
@RequestMapping("/workFlowUsers")
public class WorkFlowUserController {

    @Autowired
    private WorkFlowUserService workFlowUserService;


    /**
     * 查询所有数据
     *
     * @param workFlowUserDTO 查询实体
     * @return 所有数据
     */
    @ApiOperation("查询所有用户数据")
    @GetMapping("/list")
    public ResultBean<List<WorkFlowUserDTO>> list(WorkFlowUserDTO workFlowUserDTO) {

        ResultBean<List<WorkFlowUserDTO>> resultBean = workFlowUserService.listUsers(workFlowUserDTO);
        return resultBean;

    }

    /**
     * 分页查询所有用户数据
     *
     * @param workFlowUserDTO 查询实体
     * @return 所有数据
     */
    @ApiOperation("分页查询所有用户数据")
    @GetMapping("/selectAll")
    public ResultBean<List<WorkFlowUserDTO>> selectAll( WorkFlowUserDTO workFlowUserDTO,
                                                       @RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
                                                       @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) {

        ResultBean<List<WorkFlowUserDTO>> resultBean = workFlowUserService.selectAll(workFlowUserDTO,pageIndex,pageSize);
        return resultBean;

    }

    /**
     * 根据用户ID查询用户
     *
     * @param userId 查询实体
     * @return 所有数据
     */
    @ApiOperation("根据用户ID查询用户")
    @GetMapping("/selectProcessUserByUserId")
    public ResultBean<WorkFlowUserDTO> selectProcessUserByUserId( @RequestParam("userId") String userId ) {

        WorkFlowUserDTO workFlowUserDTO = workFlowUserService.selectUserByUserId(userId);
        return ResultBean.ofSuccess(workFlowUserDTO);

    }

    /**
     * 分页根据角色Key查询所有用户数据
     *
     * @param keyList 角色keys
     * @return 所有数据
     */
    @ApiOperation("分页根据角色Key查询所有用户数据")
    @PostMapping("/selectAllByRoleKeys")
    public ResultBean<List<WorkFlowUserDTO>> selectAllByRoleKeys(@RequestBody List<String> keyList,
                                                                 @RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
                                                                 @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) {

        ResultBean<List<WorkFlowUserDTO>> resultBean = workFlowUserService.selectUserByRoleKeys(keyList,pageIndex,pageSize);
        return resultBean;

    }

    /**
     * 分页根据部门Key查询所有用户数据
     *
     * @param keyList 部门keys
     * @return 所有数据
     */
    @ApiOperation("分页根据部门Key查询所有用户数据")
    @PostMapping("/selectAllByDeptKeys")
    public ResultBean<List<WorkFlowUserDTO>> selectAllByDeptKeys(@RequestBody List<String> keyList,
                                                                 @RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
                                                                 @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) {

        ResultBean<List<WorkFlowUserDTO>> resultBean = workFlowUserService.selectAllByDeptKeys(keyList,pageIndex,pageSize);
        return resultBean;

    }

    /**
     * 分页根据区域Key查询所有用户数据
     *
     * @param keyList 区域keys
     * @return 所有数据
     */
    @ApiOperation("分页根据部门Key查询所有用户数据")
    @PostMapping("/selectAllByAreaKeys")
    public ResultBean<List<WorkFlowUserDTO>> selectAllByAreaKeys(@RequestBody List<String> keyList,
                                                                 @RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
                                                                 @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) {

        ResultBean<List<WorkFlowUserDTO>> resultBean = workFlowUserService.selectAllByAreaKeys(keyList,pageIndex,pageSize);
        return resultBean;

    }


}
