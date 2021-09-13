/*
 * @Author: xueyan
 * @Date: 2021-07-19 10:06:13
 * @LastEditTime: 2021-08-23 10:49:16
 * @LastEditors: Please set LastEditors
 * @Description: 工作台-组任务
 * @FilePath: /flow-template-front/src/api/workmenu/groupmission.js
 */
import request from '@/utils/request'
// 工作台首页-组任务列表获取
export const getTableData = async (data) => {
  return request({
    url: '/flowable/workBench/findMyToDoGroupTasks',
    method: 'post',
    data
  })
}
// 流程工作台-组任务列表获取
export const getGroupTableData = async (data) => {
  return request({
    url: '/flowable/management/findAllToDoGroupTasks',
    method: 'post',
    data
  })
}

export const claimTask = async (data) => {
  return request({
    url: '/flowable/task/claimTask',
    method: 'post',
    data
  })
}

export const getProcessImg = async (id) => {
  return await request({
    url: `/flowable/task/image/${id}`,
    method: 'get',
    responseType: 'arraybuffer',
  })
}
