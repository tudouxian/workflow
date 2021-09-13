package com.workflow.process.center.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.flowable.engine.runtime.ActivityInstance;

import java.util.Date;
import java.util.List;

public interface FlowableExtensionMapper {

    List<ActivityInstance> queryActivityInstance(@Param("disActivityId") String disActivityId,
                                                 @Param("processInstanceId")  String processInstanceId,
                                                 @Param("endTime") Date endTime );

    List<ActivityInstance> queryActivityInstanceByType(@Param("processInstanceId") String processInstanceId,
                                                       @Param("actType")  String actType);

    List<ActivityInstance> queryActivityInstanceByTypeAndRemoveDuplicates(@Param("processInstanceId") String processInstanceId,
                                                       @Param("actId")  String actId,
                                                       @Param("actType")  String actType);
    /**
     * 删除运行节点表信息
     * @param runActivityIds
     */
    void deleteRunActinstsByIds(List<String> runActivityIds);

    /**
     * 删除历史节点表信息
     * @param runActivityIds
     */
    void deleteHisActinstsByIds(List<String> runActivityIds);

    int querySubTaskByParentTaskId(@Param("parentTaskId")  String parentTaskId);

    @Delete("DELETE FROM act_hi_actinst WHERE id_ = #{id}")
    int deleteHistoryActivityInstance(@Param("id") String id);

    @Select("select ID_ from act_ru_task where PARENT_TASK_ID_ = #{parentTaskId} and SCOPE_TYPE_ = #{synergy}")
    List<String> querySubTaskByParentTaskIdAndScopeType(@Param("synergy")String synergy,@Param("parentTaskId") String parentTaskId);

    @Delete("DELETE FROM act_ru_identitylink WHERE TASK_ID_ = #{taskId} and TYPE_ = 'candidate' and GROUP_ID_ is not null")
    int deleteCandidateGroupByTaskId(@Param("taskId") String taskId);
}
