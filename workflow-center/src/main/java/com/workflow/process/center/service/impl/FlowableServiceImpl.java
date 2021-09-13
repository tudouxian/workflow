package com.workflow.process.center.service.impl;

import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.domain.dto.ServiceReProcessDefinitionDTO;
import com.workflow.process.center.domain.vo.ProcessDefinitionVO;
import com.workflow.process.center.exception.BizException;
import com.workflow.process.center.mapper.FlowableQueryMapper;
import com.workflow.process.center.service.FlowableService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.ArrayUtils;
import org.flowable.bpmn.model.BpmnModel;
import org.flowable.engine.ProcessEngine;
import org.flowable.engine.repository.Deployment;
import org.flowable.engine.repository.ProcessDefinition;
import org.flowable.engine.repository.ProcessDefinitionQuery;
import org.flowable.image.impl.DefaultProcessDiagramGenerator;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import static com.workflow.process.center.common.contant.CommonContant.PROCESSDEFINITIONSTATEACTIVE;
import static com.workflow.process.center.common.contant.CommonContant.PROCESSDEFINITIONSTATESUSPEND;

/**
 * @Author: 土豆仙
 * @Date: 2021/6/22 9:23
 * @Description: flowable相关扩展
 */
@Slf4j
@Service
public class FlowableServiceImpl implements FlowableService {

    @Autowired
    private ProcessEngine processEngine;

    @Autowired
    private FlowableQueryMapper flowableQueryMapper;

    /**
     * 流程定义列表
     *
     * @param pageIndex 当前页码
     * @param pageSize  每页条数
     * @return 流程定义分页列表数据
     */
    @Override
    public ResultBean<List<ProcessDefinitionVO>> listDefinitions(Integer pageIndex, Integer pageSize) {
        ProcessDefinitionQuery processDefinitionQuery = processEngine.getRepositoryService()
                .createProcessDefinitionQuery();
        processDefinitionQuery.orderByProcessDefinitionId()
                .orderByProcessDefinitionVersion()
                .desc();
        List<ProcessDefinitionVO> dataList = new ArrayList<>();
        PageHelper.startPage(pageIndex, pageSize, true);
        List<ProcessDefinition> list = processDefinitionQuery.list();
        //组装结果视图
        list.stream()
                .forEach(_p -> {
                    ProcessDefinitionVO _processDefinitionVO = new ProcessDefinitionVO();
                    BeanUtils.copyProperties(_p, _processDefinitionVO);
                    //部署信息
                    String deploymentId = _p.getDeploymentId();
                    Deployment deployment = processEngine.getRepositoryService()
                            .createDeploymentQuery()
                            .deploymentId(deploymentId)
                            .singleResult();
                    // 流程定义部署时间
                    _processDefinitionVO.setDeploymentTime(deployment.getDeploymentTime());

                    //绑定启动表单信息 TODO
                   /* SysForm sysForm = sysDeployFormService.selectSysDeployFormByDeployId(deploymentId);
                    if (Objects.nonNull(sysForm)) {
                        reProcDef.setFormName(sysForm.getFormName());
                        reProcDef.setFormId(sysForm.getFormId());
                    }*/

                    dataList.add(_processDefinitionVO);
                });

        PageInfo<ProcessDefinition> pageInfo = new PageInfo<>(list);

        return ResultBean.ofSuccess(dataList, pageInfo.getTotal(), pageInfo.getPageNum(), pageInfo.getPageSize());
    }

    //配置服务关联流程定义枚举
    @Override
    public ResultBean<List<Map<String, Object>>> listDefinitionsCategory() {
        List<Map<String, Object>> maps = flowableQueryMapper.listDefinitionsCategory();
        return ResultBean.ofSuccess(maps);
    }

    @Override
    public ResultBean<List<Map<String, Object>>> listDefinitionsKeyAndName(String categoryId) {
        List<Map<String, Object>> maps = flowableQueryMapper.listDefinitionsKeyAndName(categoryId);
        return ResultBean.ofSuccess(maps);
    }

    @Override
    public ResultBean<List<ServiceReProcessDefinitionDTO>> listDefinitionsAll(ServiceReProcessDefinitionDTO serviceReProcessDefinitionDTO) {
        List<ServiceReProcessDefinitionDTO> list = flowableQueryMapper.listDefinitionsAll(serviceReProcessDefinitionDTO);
        return ResultBean.ofSuccess(list);
    }

    /**
     * @Description 上传bpmn文件，并部署流程定义
     * @Author 土豆仙
     * @Date 2021/6/22 9:35
     * @Param
     * @Return
     * @Exception
     */
    @Override
    public void uploadAndDeployment(MultipartFile file, String processName, String category, String[] tenantIds) {

        try {
            InputStream inputStream = file.getInputStream();
            if (ArrayUtils.isNotEmpty(tenantIds)) {
                for (String tenantId : tenantIds) {
                    Deployment deploy = processEngine.getRepositoryService()
                            .createDeployment()
                            .addInputStream(file.getOriginalFilename(), inputStream)//bpmn资源文件路径，bpmn资源流
                            .name(processName)//流程名称
                            .category(category)//分类
                            .tenantId(tenantId)//租户ID
                            .deploy();

                    //存储流程定义表中分类信息
                    ProcessDefinition definition = processEngine.getRepositoryService()
                            .createProcessDefinitionQuery()
                            .deploymentId(deploy.getId())
                            .singleResult();
                    processEngine.getRepositoryService()
                            .setProcessDefinitionCategory(definition.getId(), category);
                }
            }

        } catch (IOException e) {
            e.printStackTrace();
            throw new BizException("上传文件异常！");
        }
    }

    /**
     * 读取xml
     *
     * @param deployId
     * @return
     */
    @Override
    public ResultBean readXml(String deployId) {
        ProcessDefinition definition = processEngine.getRepositoryService()
                .createProcessDefinitionQuery()
                .deploymentId(deployId)
                .singleResult();
        InputStream inputStream = processEngine.getRepositoryService()
                .getResourceAsStream(definition.getDeploymentId(), definition.getResourceName());
        try {
            String result = IOUtils.toString(inputStream, String.valueOf(StandardCharsets.UTF_8));

            return ResultBean.ofSuccess(result);
        } catch (IOException e) {
            e.printStackTrace();
            throw new BizException("XML文件转换异常！");
        }

    }

    /**
     * 读取图片
     *
     * @param deployId
     * @return
     */
    @Override
    public InputStream readImage(String deployId) {
        ProcessDefinition processDefinition = processEngine.getRepositoryService()
                .createProcessDefinitionQuery()
                .deploymentId(deployId)
                .singleResult();
        //获得图片流
        DefaultProcessDiagramGenerator diagramGenerator = new DefaultProcessDiagramGenerator();
        BpmnModel bpmnModel = processEngine.getRepositoryService()
                .getBpmnModel(processDefinition.getId());
        //输出为图片
        return diagramGenerator.generateDiagram(
                bpmnModel,
                "png",
                Collections.emptyList(),
                Collections.emptyList(),
                "宋体",
                "宋体",
                "宋体",
                null,
                1.0,
                false);
    }

    /**
     * 根据流程定义ID启动流程实例
     *
     * @param procDefId 流程定义Id
     * @param variables 流程变量
     * @return
     */
   /* @Override
    public ResultBean startProcessInstanceById(String procDefId, Map<String, Object> variables) {
        ProcessDefinition processDefinition = processEngine.getRepositoryService()
                .createProcessDefinitionQuery()
                .processDefinitionId(procDefId)
                .latestVersion()
                .singleResult();

        if (Objects.nonNull(processDefinition) && processDefinition.isSuspended()) {
            return ResultBean.ofError("流程已被挂起,请先激活流程");
        }

        // 设置流程发起人Id到流程中
        processEngine.getIdentityService()
                .setAuthenticatedUserId(loginInfoService.getLoginUser().getUserid().toString());


        ProcessInstance processInstance = processEngine
                .getRuntimeService()
                //设置业务key
                .startProcessInstanceByKeyAndTenantId(processDefinition.getKey(), String.valueOf(snowIdUtils.nextId()), variables, processDefinition.getTenantId());

        // 给第一步申请人节点设置任务执行人和意见
        Task task = processEngine.getTaskService()
                .createTaskQuery()
                .processInstanceId(processInstance.getProcessInstanceId())
                .singleResult();
        if (Objects.nonNull(task) && task.getName().equals("申请人")) {
            processEngine.getTaskService()
                    .addComment(task.getId(), processInstance.getProcessInstanceId(), CommentTypeEnum.SQ.toString(), CommentTypeEnum.SQ.name());
            //设置任务领取人
            processEngine.getTaskService()
                    .setAssignee(task.getId(), loginInfoService.getLoginUser().getUserid().toString());
            processEngine.getTaskService()
                    .complete(task.getId(), variables);
        }
        return ResultBean.ofSuccess("流程启动成功");
    }*/

    /**
     * 激活或挂起流程定义
     *
     * @param state    状态
     * @param deployId 流程部署ID
     */
    @Override
    public void updateState(Integer state, String deployId) {
        ProcessDefinition procDef = processEngine.getRepositoryService()
                .createProcessDefinitionQuery()
                .deploymentId(deployId)
                .singleResult();

        if (state == PROCESSDEFINITIONSTATEACTIVE) {
            // 激活
            processEngine.getRepositoryService().activateProcessDefinitionById(procDef.getId(), true, null);
        } else if (state == PROCESSDEFINITIONSTATESUSPEND) {
            // 挂起
            processEngine.getRepositoryService().suspendProcessDefinitionById(procDef.getId(), true, null);
        } else {
            throw new BizException("无效的状态值！");
        }
    }

    /**
     * 删除流程定义
     *
     * @param deployId 流程部署ID act_ge_bytearray 表中 deployment_id值
     */
    @Override
    public void delete(String deployId) {
        // true 允许级联删除 ,不设置会导致数据库外键关联异常
        processEngine.getRepositoryService()
                .deleteDeployment(deployId, true);
    }


}
