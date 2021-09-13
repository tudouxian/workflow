package com.workflow.process.center.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.workflow.process.center.domain.entity.WorkFlowModelReForm;

/**
 * 流程模型关联表单（先只控制到表级读写权限=》后期再扩展到表内字段的读写权限）(WorkFlowModelReForm)表数据库访问层
 *
 * @author 土豆仙
 * @since 2021-07-29 09:59:10
 */
public interface WorkFlowModelReFormMapper extends BaseMapper<WorkFlowModelReForm> {

}
