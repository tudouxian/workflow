package com.workflow.process.center.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.workflow.process.center.api.domain.WorkFlowUserDTO;
import com.workflow.process.center.common.enums.ModelStatusEnum;
import com.workflow.process.center.common.enums.NodeStatusEnum;
import com.workflow.process.center.common.enums.NodeTypeEnum;
import com.workflow.process.center.config.flowable.converter.CustomBpmnJsonConverter;
import com.workflow.process.center.domain.dto.ModelInfoDTO;
import com.workflow.process.center.domain.entity.WorkFlowModel;
import com.workflow.process.center.domain.entity.WorkFlowModelInfo;
import com.workflow.process.center.domain.vo.ActivityVO;
import com.workflow.process.center.domain.vo.HighLightedNodeVO;
import com.workflow.process.center.exception.BizException;
import com.workflow.process.center.service.*;
import com.fasterxml.jackson.databind.node.ObjectNode;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.flowable.bpmn.constants.BpmnXMLConstants;
import org.flowable.bpmn.converter.BpmnXMLConverter;
import org.flowable.bpmn.model.*;
import org.flowable.common.engine.impl.de.odysseus.el.misc.TypeConverter;
import org.flowable.editor.language.json.converter.BaseBpmnJsonConverter;
import org.flowable.editor.language.json.converter.util.CollectionUtils;
import org.flowable.engine.ProcessEngine;
import org.flowable.engine.history.HistoricActivityInstance;
import org.flowable.engine.history.HistoricProcessInstance;
import org.flowable.engine.impl.bpmn.behavior.SequentialMultiInstanceBehavior;
import org.flowable.engine.repository.Deployment;
import org.flowable.engine.repository.ProcessDefinition;
import org.flowable.engine.runtime.ProcessInstance;
import org.flowable.task.api.history.HistoricTaskInstance;
import org.flowable.validation.ProcessValidator;
import org.flowable.validation.ProcessValidatorFactory;
import org.flowable.validation.ValidationError;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamReader;
import java.io.ByteArrayInputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

import static com.workflow.process.center.common.contant.CommonContant.BPMN_EXTENSION;
import static com.workflow.process.center.common.contant.CommonContant.NODE_TYPE;
import static com.workflow.process.center.common.enums.ModelStatusEnum.DFB;
import static com.workflow.process.center.common.enums.ModelStatusEnum.YFB;
import static com.workflow.process.center.utils.date.DateUtils.getDatePoor;
import static com.workflow.process.center.utils.date.DateUtils.getDuration;

@Slf4j
@Service
@Transactional
public class FlowableModelServiceImpl implements FlowableModelService {

    @Autowired
    private ProcessEngine processEngine;

   /* @Autowired
    private ModelService modelService;*/

    @Autowired
    WorkFlowModelService workFlowModelService;

    @Autowired
    protected BpmnXMLConverter bpmnXMLConverter;

    @Autowired
    private ProcessValidatorFactory processValidatorFactory;

    @Autowired
    protected CustomBpmnJsonConverter bpmnJsonConverter;

    @Autowired
    private WorkFlowModelInfoService workFlowModelInfoService;

    //????????????
    @Autowired
    private FlowableBpmnModelService flowableBpmnModelService;

    @Autowired
    private FlowableExpressionService flowableExpressionService;

    @Autowired
    private AuthService authService;

    @Autowired
    private WorkFlowUserService workFlowUserService;

    @Autowired
    private WorkFlowGroupService workFlowGroupService;

    @Autowired
    private TypeConverter typeConverter;

    @Autowired
    private ExpressionService expressionService;

    @Override
    public WorkFlowModel createInitBpmn(WorkFlowModelInfo workFlowModelInfo) {
        WorkFlowModel workFlowModel = new WorkFlowModel();
        workFlowModel.setModelKey(workFlowModelInfo.getModelKey());
        workFlowModel.setModelName(workFlowModelInfo.getName());
        //????????????xml??????
        workFlowModelService.saveOrUpdate(workFlowModel);

        return workFlowModel;
    }

    @Override
    public ModelInfoDTO loadBpmnXmlByModelId(String modelId) {
        WorkFlowModel wfModel = workFlowModelService.getById(modelId);
        ModelInfoDTO modelInfoVo = new ModelInfoDTO();
        if (wfModel != null) {
            String modelXml = wfModel.getModelXml();
            modelInfoVo.setModelId(modelId);
            modelInfoVo.setModelName(wfModel.getModelName());
            modelInfoVo.setModelKey(wfModel.getModelKey());
            //modelInfoVo.setFileName(model.getName());
            modelInfoVo.setModelXml(modelXml);
        }

        return modelInfoVo;
    }


    @Override
    public String importBpmnModel(ModelInfoDTO modelInfoDTO) {
        WorkFlowModel wfModel = workFlowModelService.getById(modelInfoDTO.getModelId());
        String fileName = modelInfoDTO.getFileName();
        if (StringUtils.isBlank(modelInfoDTO.getFileName())) {
            fileName = wfModel.getModelKey() + BPMN_EXTENSION;
        }

        //??????????????????????????????xml
        XMLInputFactory xif = XMLInputFactory.newInstance();
        ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(modelInfoDTO.getModelXml().getBytes());
        InputStreamReader xmlIn = new InputStreamReader(byteArrayInputStream, StandardCharsets.UTF_8);
        XMLStreamReader xtr = null;
        try {
            xtr = xif.createXMLStreamReader(xmlIn);
        } catch (XMLStreamException e) {
            e.printStackTrace();
            throw new BizException("XML?????????????????????");
        }
        //1.XML???BpmnModel
        BpmnModel bpmnModel = bpmnXMLConverter.convertToBpmnModel(xtr);
        bpmnModel.getMainProcess().setId(wfModel.getModelKey());
        bpmnModel.setTargetNamespace(BaseBpmnJsonConverter.NAMESPACE);
        if (CollectionUtils.isEmpty(bpmnModel.getProcesses())) {
            throw new BizException("?????????????????????????????? " + fileName);
        }
        if (bpmnModel.getLocationMap().size() == 0) {
            throw new BizException("?????????????????????????????? BPMN DI ?????? ??????" + fileName);
        }
        ProcessValidator processValidator = processValidatorFactory.createDefaultProcessValidator();
        //????????????
        List<ValidationError> validationErrors = processValidator.validate(bpmnModel);
        if (CollectionUtils.isNotEmpty(validationErrors)) {
            StringBuffer message = new StringBuffer();
            validationErrors.forEach(validationError -> message.append(validationErrors.toString()));
            throw new BizException(message.toString());
        }


        //??????Json????????????
        WorkFlowModel workFlowModel = new WorkFlowModel();

        //??????????????????????????????????????????
        LambdaQueryWrapper<WorkFlowModelInfo> lambdaQueryWrapper = new LambdaQueryWrapper();
        lambdaQueryWrapper.eq(WorkFlowModelInfo::getModelId, modelInfoDTO.getModelId());
        WorkFlowModelInfo orginModelInfo = workFlowModelInfoService.getOne(lambdaQueryWrapper);


        if (orginModelInfo.getStatus() != YFB.getStatus()) {
            //??????
            workFlowModel.setId(modelInfoDTO.getModelId());
        } else {
            //??????-?????????
            workFlowModel.setVersion(wfModel.getVersion() + 1);
        }

        workFlowModel.setModelKey(wfModel.getModelKey());
        workFlowModel.setModelName(wfModel.getModelName());
        workFlowModel.setModelXml(modelInfoDTO.getModelXml());
        workFlowModel.setFileName(fileName);

        //????????????xml??????
        workFlowModelService.saveOrUpdate(workFlowModel);


        //???????????????????????????????????????????????????ID
        LambdaUpdateWrapper<WorkFlowModelInfo> modelInfoLambdaUpdateWrapper = new LambdaUpdateWrapper<>();
        modelInfoLambdaUpdateWrapper
                .set(WorkFlowModelInfo::getStatus, DFB.getStatus())
                .set(WorkFlowModelInfo::getModelId, workFlowModel.getId())
                .eq(WorkFlowModelInfo::getId, orginModelInfo.getId());
        workFlowModelInfoService.update(modelInfoLambdaUpdateWrapper);
        return workFlowModel.getId();

    }

    @Override
    public void publishBpmn(String modelId) {
        //??????????????????id????????????????????????
        LambdaQueryWrapper<WorkFlowModelInfo> modelInfoLambdaQueryWrapper = new LambdaQueryWrapper<>();
        modelInfoLambdaQueryWrapper.eq(WorkFlowModelInfo::getModelId, modelId);
        WorkFlowModelInfo modelInfo = workFlowModelInfoService
                .getOne(modelInfoLambdaQueryWrapper);
        if (modelInfo != null) {
            Boolean canPub = ModelStatusEnum.checkActive(modelInfo.getStatus());
            if (canPub) {
                //??????????????????
                this.deployBpmn(modelInfo);

                //??????????????????
                modelInfo.setStatus(ModelStatusEnum.YFB.getStatus());
                workFlowModelInfoService.updateById(modelInfo);
            } else {
                throw new BizException("?????????????????????????????????");
            }
        } else {
            throw new BizException("?????????id????????????????????????");
        }
    }

    @Override
    public void stopBpmn(String modelId) {
        LambdaUpdateWrapper<WorkFlowModelInfo> modelInfoLambdaUpdateWrapper = new LambdaUpdateWrapper<>();
        modelInfoLambdaUpdateWrapper.eq(WorkFlowModelInfo::getModelId, modelId)
                .set(WorkFlowModelInfo::getStatus, ModelStatusEnum.TY.getStatus());
        boolean update = workFlowModelInfoService.update(modelInfoLambdaUpdateWrapper);
        if (!update) {
            throw new BizException("???????????????????????????");
        }
    }

    @Override
    public Deployment deployBpmn(WorkFlowModelInfo modelInfo) {
        //Model model = modelService.getModel(modelInfo.getModelId());
        WorkFlowModel wfModel = workFlowModelService.getById(modelInfo.getModelId());

        BpmnModel bpmnModel = workFlowModelService.getBpmnModel(modelInfo.getModelId());
        Deployment deploy = processEngine.getRepositoryService()
                .createDeployment()
                .name(wfModel.getModelName())
                .key(wfModel.getModelKey())
                .category(modelInfo.getCategoryId().toString())
                .tenantId(modelInfo.getTenantId())
                .addBpmnModel(wfModel.getModelKey() + BPMN_EXTENSION, bpmnModel)
                .deploy();
        //????????????????????????????????????
        ProcessDefinition definition = processEngine.getRepositoryService()
                .createProcessDefinitionQuery()
                .deploymentId(deploy.getId())
                .singleResult();

        processEngine.getRepositoryService()
                .setProcessDefinitionCategory(definition.getId(), modelInfo.getCategoryId().toString());
        return deploy;
    }

    @Override
    public HighLightedNodeVO getHighLightedNodeVoByProcessInstanceId(String processInstanceId) {

        ProcessInstance processInstance = processEngine.getRuntimeService()
                .createProcessInstanceQuery()
                .processInstanceId(processInstanceId)
                .singleResult();
        //??????????????????Ids
        List<String> activeActivityIds;
        //????????????
        List<String> highLightedFlows = new ArrayList<>();
        List<HistoricActivityInstance> historicSquenceFlows = processEngine.getHistoryService()
                .createHistoricActivityInstanceQuery()
                .processInstanceId(processInstanceId)
                .activityType(BpmnXMLConstants.ELEMENT_SEQUENCE_FLOW)
                .list();
        historicSquenceFlows
                .forEach(historicActivityInstance -> highLightedFlows.add(historicActivityInstance.getActivityId()));
        String processDefinitionId = null;
        String ProcessInstanceName = null;
        if (processInstance == null) {
            HistoricProcessInstance historicProcessInstance = processEngine.getHistoryService()
                    .createHistoricProcessInstanceQuery()
                    .processInstanceId(processInstanceId)
                    .singleResult();
            processDefinitionId = historicProcessInstance.getProcessDefinitionId();
            ProcessInstanceName = historicProcessInstance.getName();
            List<HistoricActivityInstance> historicEnds = processEngine.getHistoryService()
                    .createHistoricActivityInstanceQuery()
                    .processInstanceId(processInstanceId)
                    .activityType(BpmnXMLConstants.ELEMENT_EVENT_END)
                    .list();
            activeActivityIds = historicEnds.stream().map(HistoricActivityInstance::getActivityId)
                    .collect(Collectors.toList());

        } else {
            processDefinitionId = processInstance.getProcessDefinitionId();
            activeActivityIds = processEngine.getRuntimeService()
                    .getActiveActivityIds(processInstanceId);
            ProcessInstanceName = processInstance.getName();
        }
        BpmnModel bpmnModel = processEngine.getRepositoryService()
                .getBpmnModel(processDefinitionId);

        BpmnXMLConverter xmlConverter = new BpmnXMLConverter();
        byte[] bpmnXML = xmlConverter.convertToXML(bpmnModel);
        // byte[] bpmnXML = modelService.getBpmnXML(bpmnModel);
        String modelXml = new String(bpmnXML, StandardCharsets.UTF_8);
        HighLightedNodeVO highLightedNodeVO = new HighLightedNodeVO(highLightedFlows, activeActivityIds, modelXml, ProcessInstanceName);
        return highLightedNodeVO;
    }

    @Override
    public ActivityVO getOneActivityVoByProcessInstanceIdAndActivityId(String processInstanceId, String activityId) {

        if (StringUtils.isBlank(processInstanceId) && StringUtils.isBlank(activityId)) {
            throw new BizException("????????????Id???????????????Id??????????????????");
        }
        //??????????????????ID?????????ID??????????????????
        List<HistoricTaskInstance> historicTaskInstances = processEngine.getHistoryService()
                .createHistoricTaskInstanceQuery()
                .processInstanceId(processInstanceId)
                .taskDefinitionKey(activityId)
                .orderByTaskCreateTime()
                .desc()
                .list();
        //??????????????????ID????????????????????????
        HistoricProcessInstance historicProcessInstance = processEngine.getHistoryService()
                .createHistoricProcessInstanceQuery()
                .processInstanceId(processInstanceId)
                .singleResult();

        //??????????????????????????????
        HistoricTaskInstance historicTaskInstance = null;
        if (CollectionUtils.isNotEmpty(historicTaskInstances)) {

            //???????????????
            for (HistoricTaskInstance hisTask : historicTaskInstances) {
                if (hisTask.getEndTime() == null) {
                    historicTaskInstance = hisTask;
                    break;
                }
            }
            //??????????????????????????????
            if (historicTaskInstance == null) {
                historicTaskInstance = historicTaskInstances.get(0);
            }
        }
        //??????????????????
        BpmnModel bpmnModel = flowableBpmnModelService.getBpmnModelByProcessDefId(historicProcessInstance.getProcessDefinitionId());

        //??????????????????
        Activity activity = flowableBpmnModelService.findActivityByBpmnModelAndId(bpmnModel, activityId);

        //????????????
        //??????????????????
        if (activity instanceof UserTask) {
            UserTask userTask = (UserTask) activity;

            //1.???????????????
            if (historicTaskInstance == null) {
                ActivityVO vo = setUnStartTaskNodeInfo(userTask, bpmnModel, historicProcessInstance);
                vo.setStatus(NodeStatusEnum.PENDING.getDescription());
                return vo;
            } else {
                //2.??????????????????
                ActivityVO vo = setUserTask(historicTaskInstances, historicTaskInstance, userTask, bpmnModel, historicProcessInstance);
                return vo;
            }
        } else if (activity instanceof ServiceTask) {
            //??????????????????

            return null;

        } else {
            return null;
        }
    }

    @Override
    public List<ActivityVO> getProcessActivityVosByProcessInstanceId(String processInstanceId) {

        List<ActivityVO> datas = new ArrayList<>();
        HistoricProcessInstance historicProcessInstance = processEngine.getHistoryService()
                .createHistoricProcessInstanceQuery()
                .processInstanceId(processInstanceId)
                .singleResult();

        BpmnModel bpmnModel = flowableBpmnModelService.getBpmnModelByProcessDefId(historicProcessInstance.getProcessDefinitionId());
        List<UserTask> userTasks = flowableBpmnModelService.findUserTasksByBpmnModel(bpmnModel);
        if (CollectionUtils.isNotEmpty(userTasks)) {
            List<HistoricTaskInstance> historicTaskInstances = processEngine.getHistoryService()
                    .createHistoricTaskInstanceQuery()
                    .processInstanceId(processInstanceId)
                    .list();
            Map<String, HistoricTaskInstance> historicTaskInstanceMap = new HashMap<>();
            if (CollectionUtils.isNotEmpty(historicTaskInstances)) {
                historicTaskInstanceMap = historicTaskInstances.stream().collect(Collectors.toMap(HistoricTaskInstance::getTaskDefinitionKey, Function.identity(), (key1, key2) -> key2));
            }
            for (UserTask userTask : userTasks) {
                ActivityVO vo = null;
                if (!historicTaskInstanceMap.containsKey(userTask.getId())) {
                    vo = this.setUnStartTaskNodeInfo(userTask, bpmnModel, historicProcessInstance);
                    vo.setStatus(NodeStatusEnum.PENDING.getDescription());
                } else {
                    HistoricTaskInstance historicTaskInstance = historicTaskInstanceMap.get(userTask.getId());
                    vo = this.setUserTask(historicTaskInstances, historicTaskInstance, userTask, bpmnModel, historicProcessInstance);
                }
                datas.add(vo);
            }
        }
        return datas;
    }

    //????????????????????????-??????key ????????????process_id???processid???
    private void setProcessPropertiesToKey(ObjectNode modelNode, String key) {
        ObjectNode objectNode = (ObjectNode) modelNode.get("properties");
        objectNode.put("process_id", key);
        objectNode.put("processid", key);
    }

    //???????????????????????????
    private ActivityVO setUnStartTaskNodeInfo(UserTask userTask, BpmnModel bpmnModel,
                                              HistoricProcessInstance historicProcessInstance) {
        ActivityVO vo = setXYWH(userTask, bpmnModel, historicProcessInstance);
        if (StringUtils.isNotBlank(userTask.getAssignee())) {

            MultiInstanceLoopCharacteristics loopCharacteristics = userTask.getLoopCharacteristics();
            if (loopCharacteristics == null) {
                //??????????????????
                String processInstanceId = historicProcessInstance.getId();

                String expressionValue = null;
                try {
                    expressionValue = flowableExpressionService.getStrValue(processInstanceId, userTask.getAssignee());
                } catch (Exception e) {
                    vo.setApprover("???????????????" + userTask.getAssignee() + "??? ???????????????");
                }
                if (StringUtils.isNotBlank(expressionValue)) {
                    List<WorkFlowUserDTO> personals = null;
                    if (StringUtils.contains(expressionValue, ",")) {
                        //??????????????????
                        String[] assignees = expressionValue.split(",");
                        List<String> as = Arrays.asList(assignees);
                        if (CollectionUtils.isNotEmpty(as)) {
                            personals = workFlowUserService.selectUserByUserIds(as);
                        }
                    } else {
                        personals = new ArrayList<>();
                        WorkFlowUserDTO personal = workFlowUserService.selectUserByUserId(expressionValue);
                        if (personal != null) {
                            personals.add(personal);
                        }
                    }
                    this.getApplyNames(personals, vo);
                }
            } else {
                //?????????
                String inputDataItem = loopCharacteristics.getInputDataItem();
                String processInstanceId = historicProcessInstance.getSuperProcessInstanceId();
                Object value = expressionService.getValue(processInstanceId, inputDataItem);
                List<String> userCodes = null;
                if (value instanceof ArrayList) {
                    userCodes = typeConverter.convert(value, ArrayList.class);
                } else if (value instanceof HashSet) {
                    HashSet hashSet = typeConverter.convert(value, HashSet.class);
                    userCodes = new ArrayList<String>(hashSet);
                }
                if (CollectionUtils.isNotEmpty(userCodes)) {
                    if (CollectionUtils.isNotEmpty(userCodes)) {
                        List<WorkFlowUserDTO> personals = workFlowUserService.selectUserByUserIds(userCodes);
                        this.getApplyNames(personals, vo);
                    }
                }
            }
        } else {
            //??????????????????
            List<String> candidateUsers = userTask.getCandidateUsers();
            List<String> candidateGroups = userTask.getCandidateGroups();
            if (CollectionUtils.isNotEmpty(candidateUsers)) {
                List<WorkFlowUserDTO> personals = workFlowUserService.selectUserByUserIds(candidateUsers);
                this.getApplyNames(personals, vo);
            } else if (CollectionUtils.isNotEmpty(candidateGroups)) {
                //???????????????
                if (CollectionUtils.isNotEmpty(candidateGroups)) {
                    Set<WorkFlowUserDTO> workFlowUserDTOS = workFlowGroupService.queryUsersByGroupKeys(candidateGroups);
                    ArrayList<WorkFlowUserDTO> personals = new ArrayList<>(workFlowUserDTOS);
                    this.getApplyNames(personals, vo);

                }
            }
        }
        return vo;
    }

    private ActivityVO setXYWH(UserTask userTask, BpmnModel bpmnModel, HistoricProcessInstance extendHisprocinst) {
        GraphicInfo graphicInfo = flowableBpmnModelService.getGraphicInfo(bpmnModel, userTask.getId());
        ActivityVO vo = new ActivityVO();
        vo.setId(userTask.getId());
        vo.setX(graphicInfo.getX());
        vo.setY(graphicInfo.getY());
        vo.setWidth(graphicInfo.getWidth());
        vo.setHeight(graphicInfo.getHeight());
        vo.setDocumentation(userTask.getDocumentation());
        vo.setName(userTask.getName());
        vo.setProceInsId(extendHisprocinst.getId());
        vo.setProceDefId(extendHisprocinst.getProcessDefinitionId());
        vo.setTaskDefKey(userTask.getId());
        try {
            String taskType = flowableBpmnModelService.getSingleCustomProperty(userTask.getId(), bpmnModel, NODE_TYPE);
            if (StringUtils.isNotBlank(taskType)) {
                if (taskType.equals(NodeTypeEnum.NOTIFY.getType())) {
                    vo.setNodeType(NodeTypeEnum.NOTIFY.getDescription());
                } else if (taskType.equals(NodeTypeEnum.NOAPPROVE.getType())) {
                    vo.setNodeType(NodeTypeEnum.NOAPPROVE.getDescription());
                } else if (taskType.equals(NodeTypeEnum.COORDINATION.getType())) {
                    vo.setNodeType(NodeTypeEnum.COORDINATION.getDescription());
                } else if (taskType.equals(NodeTypeEnum.REVIEW.getType())) {
                    vo.setNodeType(NodeTypeEnum.REVIEW.getDescription());
                } else if (taskType.equals(NodeTypeEnum.APPLYING.getType())) {
                    vo.setNodeType(NodeTypeEnum.APPLYING.getDescription());
                } else {
                    vo.setNodeType(NodeTypeEnum.APPLY.getDescription());
                }
            } else {
                vo.setNodeType(NodeTypeEnum.APPLY.getDescription());
            }
        } catch (Exception e) {
            log.error("????????????????????????", e);
            e.printStackTrace();
        }
        return vo;
    }

    private ActivityVO setUserTask(List<HistoricTaskInstance> historicTaskInstances, HistoricTaskInstance historicTaskInstance, UserTask userTask, BpmnModel bpmnModel, HistoricProcessInstance historicProcessInstance) {
        ActivityVO vo = null;
        //???????????????
        if (historicTaskInstance != null && historicTaskInstance.getEndTime() == null) {
            vo = this.setUnStartTaskNodeInfo(userTask, bpmnModel, historicProcessInstance);
            List<Date> createTimes = new ArrayList<>();
            historicTaskInstances.forEach(hisTask -> createTimes.add(hisTask.getCreateTime()));
            vo.setStartDate(Collections.min(createTimes));
            vo.setStatus(NodeStatusEnum.PROCESSING.getDescription());
        } else {
            //???????????????
            vo = setXYWH(userTask, bpmnModel, historicProcessInstance);
            List<String> personalCodes = new ArrayList<>();
            List<Date> createTimes = new ArrayList<>();
            List<Date> endTimes = new ArrayList<>();

            historicTaskInstances.forEach(hisTask -> {
                createTimes.add(hisTask.getCreateTime());
                endTimes.add(hisTask.getEndTime());
                String assignee = hisTask.getAssignee();
                if (StringUtils.isNotBlank(assignee)) {
                    personalCodes.add(assignee);
                }
            });

            //?????????id?????????
            if (CollectionUtils.isNotEmpty(personalCodes)) {
                List<WorkFlowUserDTO> workFlowUserDTOS = workFlowUserService.selectUserByUserIds(personalCodes);
                if (CollectionUtils.isNotEmpty(workFlowUserDTOS)) {
                    this.getApplyNames(workFlowUserDTOS, vo);
                }
            }
            if (CollectionUtils.isNotEmpty(createTimes) && createTimes.size() > 0) {
                vo.setStartDate(Collections.min(createTimes));
            }
            if (CollectionUtils.isNotEmpty(endTimes) && endTimes.size() > 0) {
                vo.setEndDate(Collections.max(endTimes));
            }
            vo.setStatus(NodeStatusEnum.FINISH.getDescription());
            long duration = 0;
            if (userTask.getBehavior() instanceof SequentialMultiInstanceBehavior) {
                //???????????????=?????????????????????
                for (HistoricTaskInstance taskInstance : historicTaskInstances) {
                    if (taskInstance.getDurationInMillis() != null) {
                        duration += taskInstance.getDurationInMillis();
                    }
                }
            } else {
                //????????????
                duration = historicTaskInstance.getDurationInMillis();
            }
            vo.setDuration(getDatePoor(vo.getEndDate(),vo.getStartDate()));
        }
        return vo;
    }

    private void getApplyNames(List<WorkFlowUserDTO> personals, ActivityVO vo) {
        StringBuilder names = new StringBuilder("");
        if (CollectionUtils.isNotEmpty(personals)) {
            for (WorkFlowUserDTO personal : personals) {
                if (personal != null) {
                    names.append(personal.getNickName()).append(";");
                }
            }
        }
        if (names.length() > 0) {
            names = names.deleteCharAt(names.length() - 1);
        }
        vo.setApprover(names.toString());
    }

}
