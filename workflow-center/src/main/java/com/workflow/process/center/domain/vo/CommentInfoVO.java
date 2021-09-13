package com.workflow.process.center.domain.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.flowable.task.api.history.HistoricTaskInstance;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

import static com.workflow.process.center.utils.date.DateUtils.getDatePoor;
import static com.workflow.process.center.utils.date.DateUtils.getDuration;

@ApiModel(value = "CommentInfoVO", description = "审批流程流转信息")
@Data
public class CommentInfoVO {

    //任务审批记录
    public CommentInfoVO(HistoricTaskInstance historicTaskInstance, CommentVO comments) {
        this.taskName = historicTaskInstance.getName();
        this.claimTime = historicTaskInstance.getClaimTime();
        this.createTime = comments.getTime();
        this.durationInMillis = historicTaskInstance.getDurationInMillis();
        this.durationInMillisView = historicTaskInstance.getEndTime()!=null?getDatePoor(historicTaskInstance.getEndTime(),historicTaskInstance.getCreateTime()):getDuration(historicTaskInstance.getDurationInMillis());
        this.endTime = historicTaskInstance.getEndTime();
        this.workTimeInMillis = historicTaskInstance.getWorkTimeInMillis();
        this.workTimeInMillisView = getDuration(historicTaskInstance.getWorkTimeInMillis());
        this.processInstanceId = historicTaskInstance.getProcessInstanceId();
        this.taskId = historicTaskInstance.getId();
        this.userId = historicTaskInstance.getAssignee();
        List<CommentVO> collect = Arrays.asList(comments);
        this.comments = collect;
    }

    //启动事件记录
    public CommentInfoVO() {
    }

    @ApiModelProperty("用户编号")
    private String userId;

    @ApiModelProperty("用户名")
    private String userName;

    @ApiModelProperty("角色信息")
    private String groupName;

    @ApiModelProperty("部门信息")
    private String deptName;


    @ApiModelProperty("任务创建时间")
    private Date createTime;

    @ApiModelProperty("任务结束时间")
    private Date endTime;

    @ApiModelProperty("任务签收时间")
    private Date claimTime;

    @ApiModelProperty("任务耗时-开始至结束")
    private Long durationInMillis;

    @ApiModelProperty("任务耗时-开始至结束-视图")
    private String durationInMillisView;

    @ApiModelProperty("工作耗时-签收后至结束")
    private Long workTimeInMillis;

    @ApiModelProperty("工作耗时-签收后至结束-视图")
    private String workTimeInMillisView;

    @ApiModelProperty("任务流程编号")
    private String processInstanceId;

    @ApiModelProperty("任务编号")
    private String taskId;

    @ApiModelProperty("任务名称")
    private String taskName;

    @ApiModelProperty("任务节点审核意见")
    private List<CommentVO> comments;

}
