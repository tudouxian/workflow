/*
 * @Author: xueyan
 * @Date: 2021-07-16 10:54:58
 * @LastEditTime: 2021-08-23 11:28:36
 * @LastEditors: Please set LastEditors
 * @Description: 工作台-已发
 * @FilePath: /flow-template-front/src/api/workmenu/sentmission.js
 */
import request from '@/utils/request'
// 工作台首页-已发列表
export const getTableData = async (data) => {
  return request({
    url: '/flowable/workBench/findMyProcessinstances',
    method: 'post',
    data
  })
}

// 流程工作台-我发起的流程列表
export const getSentTableData = async (data) => {
  return request({
    url: '/flowable/management/findAllProcessinstances',
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
 export const getButton = async () => {
  return await request({
    url: '/flowable/task/findButtonsByTaskId',
    method: 'get',
    params: {
      buttonTypeEnum: 'PROCESS'
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

// 获取modelxml
export const getModelXml = async (processInstanceId) => {
  return await request({
    url: `/flowable/modeler/getHighLightedNodeVoByProcessInstanceId/${processInstanceId}`,
    method: 'get'
  })
}
// 获取model节点的信息
export const getModelNodeInfo = async (processInstanceId, activityId) => {
  return await request({
    url: `/flowable/modeler/getOneActivityVoByProcessInstanceIdAndActivityId/${processInstanceId}/${activityId}`,
    method: 'get'
  })
}
