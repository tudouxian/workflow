package com.workflow.process.center.domain.dto.task;

import com.workflow.process.center.domain.dto.CandidateGroupDTO;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
@ApiModel("修改候选组")
public class UpdateCandidateTaskDTO extends BaseTaskDTO{

    @NotEmpty(message = "候选组不能为空！")
    @ApiModelProperty(value = "候选组")
   private List<CandidateGroupDTO> candidateGroupDTOS;

}
