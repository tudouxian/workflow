package com.workflow.process.center.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.workflow.process.center.domain.entity.WorkFlowModel;
import com.workflow.process.center.exception.BizException;
import com.workflow.process.center.mapper.WorkFlowModelMapper;
import com.workflow.process.center.service.WorkFlowModelService;
import lombok.extern.slf4j.Slf4j;
import org.flowable.bpmn.converter.BpmnXMLConverter;
import org.flowable.bpmn.model.BpmnModel;
import org.flowable.engine.repository.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamReader;
import java.io.ByteArrayInputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;

/**
 * 流程模型信息(WorkFlowModel)表服务实现类
 *
 * @author 土豆仙
 * @since 2021-08-26 14:17:52
 */
@Slf4j
@Service
public class WorkFlowModelServiceImpl extends ServiceImpl<WorkFlowModelMapper, WorkFlowModel> implements WorkFlowModelService {

    @Autowired
    private BpmnXMLConverter bpmnXMLConverter;

    @Override
    public BpmnModel getBpmnModel(String modelId) {

        WorkFlowModel wfModel = getById(modelId);

        ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(wfModel.getModelXml().getBytes());

        XMLInputFactory xif = XMLInputFactory.newInstance();
        InputStreamReader xmlIn = new InputStreamReader(byteArrayInputStream, StandardCharsets.UTF_8);
        XMLStreamReader xtr = null;
        try {
            xtr = xif.createXMLStreamReader(xmlIn);
        } catch (XMLStreamException e) {
            e.printStackTrace();
            throw new BizException("XML读取异常！！！");
        }
        //1.XML转BpmnModel
        BpmnModel bpmnModel = bpmnXMLConverter.convertToBpmnModel(xtr);
        return bpmnModel;
    }
}
