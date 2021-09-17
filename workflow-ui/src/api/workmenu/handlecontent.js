/*
 * @Author: your name
 * @Date: 2021-07-20 15:37:09
 * @LastEditTime: 2021-07-21 10:35:43
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /flow-template-front/src/api/workmenu/handlecontent.js
 */
import request from '@/utils/request'

export const getStepList = async (processInstanceId, taskId) => {
  return request({
    url: `/flowable/task/getBackNodesByProcessInstanceId/${processInstanceId}/${taskId}`,
    method: 'get'
  })
}

export const getUserList = async (params) => {
  return request({
    url: `/workFlowUsers/selectAll`,
    method: 'get',
    params
  })
}

export const handleActions = async ({ url, params }) => {

  return await request({
    url: `${url}`,
    method: 'post',
    data: params
  })
}
