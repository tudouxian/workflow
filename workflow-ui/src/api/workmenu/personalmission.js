/*
 * @Author: xueyan
 * @Date: 2021-07-19 18:00:18
 * @LastEditTime: 2021-08-24 10:12:49
 * @LastEditors: Please set LastEditors
 * @Description: 个人待办任务相关接口
 * @FilePath: /flow-template-front/src/api/workmenu/personalmission.js
 */
import request from '@/utils/request'
// 工作台首页-个人待办任务列表获取
export const getTableData = async (params) => {
  return request({
    url: '/flowable/workBench/findMyToDoTasks',
    method: 'post',
    data: params
  })
}
// 流程工作台-个人待办任务列表获取
export const getTodoTabelData = async (params) => {
  return request({
    url: '/flowable/management/findAllToDoTasks',
    method: 'post',
    data: params
  })
}

export const getFlowType = async () => {
  return request({
    url: '/workFlowServiceCategory/list',
    method: 'get',
  })
}

export const getTimelineList = async (id) => {
  return await request({
    url: '/flowable/workBench/getCommentInfosByProcessInstanceId',
    method: 'get',
    params: {
      processInstanceId: id
    }
  })
}
/**
 * 获取按钮列表
 * @param { string } taskId - 任务id
 * @param { string } buttonTypeEnum -
 * TODO("TODO","待办按钮"),
 * DONE("DONE","已办按钮"),
 * PROCESS("PROCESS","流程按钮");
 * @param {*} params
 * @returns
 */
export const getButton = async (taskId) => {
  return await request({
    url: '/flowable/task/findButtonsByTaskId',
    method: 'get',
    params: {
      taskId,
      buttonTypeEnum: 'TODO'
    }
  })
}

export const getProcessImg = async (id) => {
  return await request({
    url: `/flowable/task/image/${id}`,
    method: 'get',
    responseType: 'arraybuffer',
  })
}

// 已经延时的任务
export const getDueTaskList = async (params) => {
  return request({
    url: '/flowable/management/findAllDueDateTasks',
    method: 'post',
    data: params
  })
}
