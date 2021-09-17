/*
 * @Author: your name
 * @Date: 2021-07-14 16:48:31
 * @LastEditTime: 2021-07-23 09:26:45
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /flow-template-front/src/api/processmanager/processButton.js
 */
import request from '@/utils/request'

// 查询流程审核按钮管理列表
export function listProcessButton(query) {
  return request({
    url: '/workFlowButton/selectAll',
    method: 'get',
    params: query
  })
}

// 查询流程审核按钮管理详细
export function getProcessButton(id) {
  return request({
    url: `/workFlowButton/${id}`,
    method: 'get'
  })
}

// 新增流程审核按钮管理
export function addProcessButton(data) {
  return request({
    url: '/workFlowButton/insert',
    method: 'post',
    data: data
  })
}

// 修改流程审核按钮管理
export function updateProcessButton(data) {
  return request({
    url: '/workFlowButton/update',
    method: 'put',
    data: data
  })
}

// 删除流程审核按钮管理
export function delProcessButton(data) {
  return request({
    url: '/workFlowButton/delete',
    method: 'delete',
    data
  })
}
