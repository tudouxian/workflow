package com.workflow.process.center.domain.dto;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.io.Serializable;

@Data
@ApiModel("修改候选组")
public class CandidateGroupDTO implements Serializable {

    private String areaKey;

    private String deptKey;

    private String roleKey;
}
