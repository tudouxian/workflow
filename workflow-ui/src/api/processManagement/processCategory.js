/*
 * @Author: your name
 * @Date: 2021-08-11 17:52:26
 * @LastEditTime: 2021-08-12 16:54:33
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /flow-template-front/src/api/processmanager/processCategory.js
 */


import request from '@/utils/request'

// 查询流程分类列表
export function listProcessCategory(query) {
  return request({
    // /workFlowCategory/selectAll
    url: '/workFlowCategory/selectAll',
    method: 'get',
    params: query
  })
}

// 查询流程分类详细
export function getProcessCategory(id) {
  return request({
    url: '/workFlowCategory/' + id,
    method: 'get'
  })
}

// 新增流程分类
export function addProcessCategory(data) {
  return request({
    url: '/workFlowCategory/insert',
    method: 'post',
    data: data
  })
}

// 修改流程分类
export function updateProcessCategory(data) {
  return request({
    url: '/workFlowCategory/update',
    method: 'put',
    data: data
  })
}

// 删除流程分类
export function delProcessCategory(id) {
  const idList = id.toString().split(',')

  return request({
    url: '/workFlowCategory/delete',
    method: 'delete',
    data: idList
  })
}
