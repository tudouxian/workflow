package com.workflow.process.center.controller;

import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.domain.dto.WorkFlowGroupPageUserDTO;
import com.workflow.process.center.domain.dto.WorkFlowGroupUserDTO;
import com.workflow.process.center.service.WorkFlowGroupService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * @Author: 土豆仙
 * @Date: 2021/6/23 14:43
 * @Description: 流程组管理-即各租户系统角色
 */
@Api(tags = "流程用户组管理")
@RestController
@RequestMapping("/workFlowGroups")
public class WorkFlowGroupController {

    @Autowired
    private WorkFlowGroupService workFlowGroupService;


    @ApiOperation(value = "更具组key查询对应组信息及组下人员（组规则：区域key_部门key_角色key）")
    @GetMapping("/queryUsersByGroupKey")
    public ResultBean<WorkFlowGroupUserDTO> queryUsersByGroupKey(@RequestParam("groupKey") String groupKey) {
        WorkFlowGroupUserDTO workFlowGroupUserDTO = workFlowGroupService.queryUsersByGroupKey(groupKey);
        return ResultBean.ofSuccess(workFlowGroupUserDTO);
    }

    @ApiOperation(value = "更具组key查询对应组信息及组下人员（组规则：区域key_部门key_角色key）")
    @GetMapping("/queryPageUsersByGroupKey")
    public ResultBean<WorkFlowGroupPageUserDTO> queryPageUsersByGroupKey(@RequestParam("groupKey") String groupKey,
                                                                     @RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
                                                                     @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) {
        WorkFlowGroupPageUserDTO workFlowGroupUserDTO = workFlowGroupService.queryPageUsersByGroupKey(groupKey,pageIndex,pageSize);
        return ResultBean.ofSuccess(workFlowGroupUserDTO);
    }

}
