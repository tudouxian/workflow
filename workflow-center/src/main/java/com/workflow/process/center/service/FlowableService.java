package com.workflow.process.center.service;

import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.domain.dto.ServiceReProcessDefinitionDTO;
import com.workflow.process.center.domain.vo.ProcessDefinitionVO;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.List;
import java.util.Map;

public interface FlowableService {

    ResultBean<List<ProcessDefinitionVO>> listDefinitions( Integer pageIndex, Integer pageSize);

    ResultBean<List<ServiceReProcessDefinitionDTO>> listDefinitionsAll(ServiceReProcessDefinitionDTO serviceReProcessDefinitionDTO);

    void uploadAndDeployment(MultipartFile file,String processName, String category, String[] tenantIds);

    ResultBean readXml(String deployId);

    InputStream readImage(String deployId);

   // ResultBean startProcessInstanceById(String procDefId, Map<String, Object> variables);

    void updateState(Integer state, String deployId);

    void delete(String deployId);

    ResultBean<List<Map<String, Object>>> listDefinitionsCategory();

    ResultBean<List<Map<String, Object>>> listDefinitionsKeyAndName(String categoryId);
}
