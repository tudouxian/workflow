package com.workflow.system.service.idm;

import com.workflow.process.center.api.AreaService;
import com.workflow.process.center.api.domain.WorkFlowAreaDTO;
import com.workflow.process.center.common.ResultBean;
import com.workflow.system.mapper.ProcessIdmMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProcessAreaService implements AreaService {

/*    @Autowired
    private DistrictService districtService;*/


    @Autowired
    ProcessIdmMapper processIdmMapper;


    @Override
    public ResultBean<List<WorkFlowAreaDTO>> listAreas(WorkFlowAreaDTO workFlowAreaDTO) {
        List<WorkFlowAreaDTO> list = processIdmMapper.listAreas(workFlowAreaDTO);
        return ResultBean.ofSuccess(list);
    }

    @Override
    public ResultBean<WorkFlowAreaDTO> queryGroupByKey(String areaKey) {
        return ResultBean.ofSuccess(processIdmMapper.queryGroupByAreaKey(areaKey));
    }
}
