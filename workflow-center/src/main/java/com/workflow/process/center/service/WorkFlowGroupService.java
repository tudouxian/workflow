package com.workflow.process.center.service;

import com.workflow.process.center.api.domain.WorkFlowUserDTO;
import com.workflow.process.center.domain.dto.WorkFlowGroupPageUserDTO;
import com.workflow.process.center.domain.dto.WorkFlowGroupUserDTO;

import java.util.List;
import java.util.Set;

public interface WorkFlowGroupService {


    WorkFlowGroupUserDTO queryUsersByGroupKey(String groupKey);

     Set<WorkFlowUserDTO> queryUsersByGroupKeys(List<String> groupKeys);

    WorkFlowGroupPageUserDTO queryPageUsersByGroupKey(String groupKey, Integer pageIndex, Integer pageSize);

     Set<String> generatorGroupKeys(Set<String> areaKeys,Set<String> deptKeys,Set<String> roles);

    String generatorGroupKey(String areaKey, String deptKey, String roleKey);
}
