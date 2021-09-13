package com.workflow.process.center.config.flowable.expression.idm;

import com.workflow.process.center.api.domain.WorkFlowDeptDTO;
import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.domain.dto.WorkFlowGroupUserDTO;
import com.workflow.process.center.service.WorkFlowDeptService;
import com.workflow.process.center.service.WorkFlowGroupService;
import com.workflow.process.center.service.WorkFlowUserService;
import com.workflow.process.center.utils.StringUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @Author: 土豆仙
 * @Date: 2021/8/23 16:04
 * @Description: 用于表达式设置（解决设置部门|区域领导、部门|区域排除某人等需求）=>不太好默认配置化=》表达式不能动态传参数
 * java8 方法优化 TODO
 */
@Component
@Slf4j
public class FlowableIdmService {

    @Autowired
    private WorkFlowDeptService workFlowDeptService;

    @Autowired
    private WorkFlowUserService workFlowUserService;

    @Autowired
    private WorkFlowGroupService workFlowGroupService;


    /**
    * @Description 表达式设置部门领导
    * @Author  土豆仙
    * @Date   2021/8/25 15:32
    * @Param 部门key
    *
    */
    public String filterDeptLeaderByDeptKey(String key) {
        WorkFlowDeptDTO deptResultBean = workFlowDeptService.queryDeptByDeptKey(key);
        if (deptResultBean != null) {
            return deptResultBean.getLeader();
        }

        return null;
    }

    /**
     * @Description 根据用户组Key过滤出执行人ID集合
     * @Author  土豆仙
     * @Date   2021/8/25 15:32
     * @Param 条件-用户组key标识
     *
     */
    public List<String> filterAssigneeList(String groupKey) {
        WorkFlowGroupUserDTO workFlowGroupUserDTO = workFlowGroupService.queryUsersByGroupKey(groupKey);
        if (workFlowGroupUserDTO !=null && CollectionUtils.isNotEmpty(workFlowGroupUserDTO.getWorkFlowUserDTOS())){
            List<String> collect = workFlowGroupUserDTO.getWorkFlowUserDTOS().stream()
                    .map(_workFlowUserDTO -> {
                        return _workFlowUserDTO.getUserId();
                    }).collect(Collectors.toList());

            return collect;
        }

        return null;
    }


    /**
     * @Description 根据字符串解析出执行人ID集合
     * @Author  土豆仙
     * @Date   2021/8/25 15:32
     * @Param 条件-用户组key标识
     *
     */
    public List<String> parseAssigneeList(String assignees) {
     if (StringUtils.isNotEmpty(assignees)){
         List<String> list = Arrays.asList(assignees.split(","));
         return list;
     }
        return null;
    }
}
