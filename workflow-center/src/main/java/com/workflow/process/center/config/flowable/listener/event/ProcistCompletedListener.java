package com.workflow.process.center.config.flowable.listener.event;

import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.workflow.process.center.common.enums.ProcessStatusEnum;
import com.workflow.process.center.common.enums.entity.CommentTypeEnum;
import com.workflow.process.center.domain.entity.WorkFlowExtendHisprocinst;
import com.workflow.process.center.domain.entity.WorkFlowHiComment;
import com.workflow.process.center.service.AuthService;
import com.workflow.process.center.service.WorkFlowExtendHisprocinstService;
import com.workflow.process.center.service.WorkFlowHiCommentService;
import lombok.extern.slf4j.Slf4j;
import org.flowable.common.engine.api.delegate.event.FlowableEngineEntityEvent;
import org.flowable.engine.delegate.event.AbstractFlowableEngineEventListener;
import org.flowable.engine.delegate.event.FlowableProcessStartedEvent;
import org.flowable.engine.delegate.event.impl.FlowableEntityEventImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;

/**
*   @Author: 土豆仙
*   @Date: 2021/7/12 14:17
*   @Description: 流程实例事件
*/
@Component
@Slf4j
public class ProcistCompletedListener extends AbstractFlowableEngineEventListener {

    @Autowired
    private WorkFlowExtendHisprocinstService workFlowExtendHisprocinstService;

    @Autowired
    private WorkFlowHiCommentService workFlowHiCommentService;

    @Autowired
    private AuthService authService;


    //流程实例启动事件
    @Override
    protected void processStarted(FlowableProcessStartedEvent event) {

    }

    //流程实例结束事件
    @Override
    protected void processCompleted(FlowableEngineEntityEvent event) {
        FlowableEntityEventImpl flowableEntityEvent = (FlowableEntityEventImpl) event;
        String processInstanceId = flowableEntityEvent.getProcessInstanceId();

        //更新流程实例运行状态
        this.updateExtendInfoToHis(processInstanceId);

        //记录日志
        WorkFlowHiComment workFlowHiComment = new WorkFlowHiComment();
        workFlowHiComment.setCommentTypeEnum(CommentTypeEnum.BJ);
        workFlowHiComment.setProcessInsId( flowableEntityEvent.getProcessInstanceId());
        workFlowHiComment.setTime(new Date());
        workFlowHiComment.setUserId(authService.getLoginUser().getUserid().toString());
        workFlowHiComment.setUserName(authService.getLoginUser().getNickName());
        workFlowHiCommentService.save(workFlowHiComment);
    }

    private void updateExtendInfoToHis(String processInstanceId) {
        //1.更新历史的流程实例的扩展信息
        WorkFlowExtendHisprocinst workFlowExtendHisprocinst = workFlowExtendHisprocinstService.findExtendHisprocinstByProcessInstanceId(processInstanceId);
        if (workFlowExtendHisprocinst != null && !ProcessStatusEnum.BJ.toString().equals(workFlowExtendHisprocinst.getProcessStatus())) {
            //更新状态为办结
            LambdaUpdateWrapper<WorkFlowExtendHisprocinst> lambdaUpdateWrapper = new LambdaUpdateWrapper();
            lambdaUpdateWrapper.set(WorkFlowExtendHisprocinst::getProcessStatus,ProcessStatusEnum.BJ.toString())
            .eq(WorkFlowExtendHisprocinst::getProcessInstanceId,processInstanceId);
            workFlowExtendHisprocinstService.update(lambdaUpdateWrapper);
        }
    }
}
