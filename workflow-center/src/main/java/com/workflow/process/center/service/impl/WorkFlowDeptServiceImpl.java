package com.workflow.process.center.service.impl;

import com.workflow.process.center.api.DeptService;
import com.workflow.process.center.api.domain.WorkFlowDeptDTO;
import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.exception.BizException;
import com.workflow.process.center.service.WorkFlowDeptService;
import com.workflow.process.center.utils.tree.TreeUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class WorkFlowDeptServiceImpl implements WorkFlowDeptService {


    @Autowired
    private DeptService deptService;

    /*@Autowired
    private RemoteDeptService deptService;*/

    @Override
    public ResultBean<List<WorkFlowDeptDTO>> listDepts(WorkFlowDeptDTO workFlowDeptDTO) {

        return deptService.listDepts(workFlowDeptDTO);
    }

    @Override
    public List<WorkFlowDeptDTO> deptTree(WorkFlowDeptDTO workFlowDeptDTO) {
        ResultBean<List<WorkFlowDeptDTO>> listResultBean = deptService.listDepts(workFlowDeptDTO);
        if (listResultBean != null && CollectionUtils.isNotEmpty(listResultBean.getData())) {
            List<WorkFlowDeptDTO> workFlowDeptDTOS = TreeUtils.generateTrees(listResultBean.getData());

            return workFlowDeptDTOS;
        }

        return null;
    }

    /**
     * 根据部门key获取部门信息
     */
    public WorkFlowDeptDTO queryDeptByDeptKey(String deptKey){
        ResultBean<WorkFlowDeptDTO> deptResultBean = deptService.queryGroupByKey(deptKey);
        if (deptResultBean != null && deptResultBean.getData() != null) {
            return deptResultBean.getData();
        }
        return null;
    }

    @Override
    public WorkFlowDeptDTO queryUpDept(String deptId, Integer stepSize) {

        WorkFlowDeptDTO targetDept = queryDeptByDeptKey(deptId);
        if (stepSize ==null || stepSize <= 0){
          return   targetDept;
        }else {

            for (int i =0;i < stepSize;i++){
                //如果当前已经是顶级-策略执行
                if (targetDept.root()){
                    //TODO 策略待定
                    throw new BizException("部门递归越界！");
                }else {
                    targetDept = queryDeptByDeptKey(targetDept.getParentKey());
                }
            }
        }
        return targetDept;
    }


}
