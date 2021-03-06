package com.workflow.process.center.service.impl;

import com.workflow.process.center.api.AreaService;
import com.workflow.process.center.api.domain.WorkFlowAreaDTO;
import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.exception.BizException;
import com.workflow.process.center.service.WorkFlowAreaService;
import com.workflow.process.center.utils.tree.TreeUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class WorkFlowAreaServiceImpl implements WorkFlowAreaService {

    //@DubboReference
    @Autowired
    AreaService remoteAreaService;

   /* @Autowired
    private RemoteAreaService remoteAreaService;*/

    @Override
    public ResultBean<List<WorkFlowAreaDTO>> listAreas(WorkFlowAreaDTO workFlowAreaDTO) {
        ResultBean<List<WorkFlowAreaDTO>> listResultBean = remoteAreaService.listAreas(workFlowAreaDTO);

        return listResultBean;
    }

    @Override
    public List<WorkFlowAreaDTO> deptTree(WorkFlowAreaDTO workFlowAreaDTO) {
        ResultBean<List<WorkFlowAreaDTO>> listResultBean = remoteAreaService.listAreas(workFlowAreaDTO);
        if (listResultBean != null && CollectionUtils.isNotEmpty(listResultBean.getData())) {
            List<WorkFlowAreaDTO> workFlowAreaDTOS = TreeUtils.generateTrees(listResultBean.getData());

            return workFlowAreaDTOS;
        }

        return null;
    }

    public WorkFlowAreaDTO queryAreaByAreaKey(String areaKey) {
        ResultBean<WorkFlowAreaDTO> workFlowAreaDTOResultBean = remoteAreaService.queryGroupByKey(areaKey);

        if (workFlowAreaDTOResultBean != null && workFlowAreaDTOResultBean.getData() != null) {
            return workFlowAreaDTOResultBean.getData();
        }
        return null;
    }

    @Override
    public WorkFlowAreaDTO queryUpArea(String areaId, Integer stepSize) {
        WorkFlowAreaDTO targetArea = queryAreaByAreaKey(areaId);
        if (stepSize == null || stepSize <= 0) {
            return targetArea;
        } else {

            for (int i = 0; i < stepSize; i++) {
                //???????????????????????????-????????????
                if (targetArea.root()) {
                    //TODO ????????????
                    throw new BizException("?????????????????????");
                } else {
                    targetArea = queryAreaByAreaKey(targetArea.getParentKey());
                }
            }
        }
        return targetArea;
    }
}
