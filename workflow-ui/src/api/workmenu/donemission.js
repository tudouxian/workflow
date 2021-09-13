/*
 * @Author: xueyan
 * @Date: 2021-07-16 10:33:41
 * @LastEditTime: 2021-08-23 10:58:36
 * @LastEditors: Please set LastEditors
 * @Description: 工作台已办
 * @FilePath: /flow-template-front/src/api/workmenu/doneMission.js
 */
import request from '@/utils/request'
// 工作台首页-获取列表
export const getTableData = async (data) => {
  return await request({
    url: '/flowable/workBench/findMyDoneTasks',
    method: 'post',
    data
  })
}
// 流程工作台-获取已办列表
export const getDoneTableData = async (data) => {
  return await request({
    url: '/flowable/management/findAllDoneTasks',
    method: 'post',
    data
  })
}
// 撤回
export const revoke = async (data) => {
  return await request({
    url: '/flowable/task/rollback',
    method: 'post',
    data
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
      buttonTypeEnum: 'DONE'
    }
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

export const handleActions = async ({ url, params }) => {
  return await request({
    url: `/${url}`,
    method: 'post',
    data: params
  })
}

export const getProcessImg = async (id) => {
  return await request({
    url: `/flowable/task/image/${id}`,
    method: 'get',
    responseType: 'arraybuffer',
  })
}
