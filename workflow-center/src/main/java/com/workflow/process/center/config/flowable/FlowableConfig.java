package com.workflow.process.center.config.flowable;

import com.workflow.process.center.config.flowable.behavior.CustomActivityBehaviorFactory;
import com.workflow.process.center.config.flowable.converter.CustomBpmnJsonConverter;
import com.workflow.process.center.domain.entity.WorkFlowEmail;
import com.workflow.process.center.service.WorkFlowEmailService;
import com.workflow.process.center.utils.StringUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.flowable.bpmn.converter.BpmnXMLConverter;
import org.flowable.bpmn.model.FieldExtension;
import org.flowable.common.engine.api.delegate.event.FlowableEngineEventType;
import org.flowable.common.engine.api.delegate.event.FlowableEventListener;
import org.flowable.common.engine.impl.cfg.mail.MailServerInfo;
import org.flowable.common.engine.impl.de.odysseus.el.misc.TypeConverter;
import org.flowable.common.engine.impl.de.odysseus.el.misc.TypeConverterImpl;
import org.flowable.engine.ProcessEngineConfiguration;
import org.flowable.engine.impl.db.DbIdGenerator;
import org.flowable.spring.SpringProcessEngineConfiguration;
import org.flowable.spring.boot.EngineConfigurationConfigurer;
import org.flowable.validation.ProcessValidatorFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;


/**
*   @Author: 土豆仙
*   @Date: 2021/6/25 22:56
*   @Description: flowable配置类
*/
@Configuration
@Slf4j
public class FlowableConfig implements EngineConfigurationConfigurer<SpringProcessEngineConfiguration> {

    @Autowired
    private WorkFlowEmailService workFlowEmailService;

    @Bean
    public CustomBpmnJsonConverter createCustomBpmnJsonConverter() {
        return new CustomBpmnJsonConverter();
    }

    @Bean
    public BpmnXMLConverter createBpmnXMLConverter() {
        return new BpmnXMLConverter();
    }

    @Bean
    public ProcessValidatorFactory processValidator() {
        return new ProcessValidatorFactory();
    }

    @Bean
    public TypeConverter typeConverter() {
        return new TypeConverterImpl();
    }

    @Override
    public void configure(SpringProcessEngineConfiguration engineConfiguration) {


        //engineConfiguration.setDatabaseSchemaUpdate(ProcessEngineConfiguration.DB_SCHEMA_UPDATE_DROP_CREATE);

        //engineConfiguration.setDatabaseSchema()

        // 配置表达式
        initExpressFunction(engineConfiguration);

        //重写节点行为
        engineConfiguration.setActivityBehaviorFactory(new CustomActivityBehaviorFactory());

        // 更改ID 策略
        //engineConfiguration.setIdGenerator(new DbIdGenerator());

        initMailServers(engineConfiguration);
    }

    private void  initMailServers(SpringProcessEngineConfiguration engineConfiguration){
        log.info("初始化租户邮箱服务配置！");
        List<WorkFlowEmail> list = workFlowEmailService.list();
        if (CollectionUtils.isNotEmpty(list)){
            Map<String, MailServerInfo> collect = list.stream().collect(Collectors.toMap(WorkFlowEmail::getTennatId, workFlowEmail -> {
                MailServerInfo mailServerInfo = new MailServerInfo();
                //设置邮箱服务参数
                mailServerInfo.setMailServerDefaultFrom(workFlowEmail.getMailDefaultFrom());
                mailServerInfo.setMailServerHost(workFlowEmail.getMailServerHost());
                mailServerInfo.setMailServerPort(workFlowEmail.getMailServerPort());
                mailServerInfo.setMailServerUsername(workFlowEmail.getMailUsername());
                mailServerInfo.setMailServerPassword(workFlowEmail.getMailPassword());
                mailServerInfo.setMailServerUseSSL(workFlowEmail.getMailSsl());
                //mailServerInfo.setMailServerUseSSL();
                //mailServerInfo.setMailServerForceTo();
                //mailServerInfo.setMailServerUseTLS();

                return mailServerInfo;
            }));
            engineConfiguration.setMailServers(collect);

        }
    }


    /**
     * 配置扩展表达式解析方法
     *
     * @param springProcessEngineConfiguration
     */
    private void initExpressFunction(SpringProcessEngineConfiguration springProcessEngineConfiguration) {
        log.info("配置扩展表达式解析方法");
         }
}

