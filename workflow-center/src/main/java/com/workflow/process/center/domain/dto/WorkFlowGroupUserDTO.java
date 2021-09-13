package com.workflow.process.center.domain.dto;

import com.workflow.process.center.api.domain.WorkFlowUserDTO;
import lombok.Data;

import java.util.List;

@Data
public class WorkFlowGroupUserDTO {

    //组类型=》角色、部门、区域
    private String groupType;

    //组名称
    private String groupName;

    //组key
    private String groupKey;

    //对应用户集合
    private List<WorkFlowUserDTO> workFlowUserDTOS;
}
