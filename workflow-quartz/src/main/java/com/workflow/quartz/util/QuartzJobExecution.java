package com.workflow.quartz.util;

import org.quartz.JobExecutionContext;
import com.workflow.quartz.domain.entity.SysJob;

/**
 * 定时任务处理（允许并发执行）
 * 
 * @author workflow
 *
 */
public class QuartzJobExecution extends AbstractQuartzJob
{
    @Override
    protected void doExecute(JobExecutionContext context, SysJob sysJob) throws Exception
    {
        JobInvokeUtil.invokeMethod(sysJob);
    }
}
