/*
 * @Author: your name
 * @Date: 2021-08-25 13:51:53
 * @LastEditTime: 2021-09-01 15:44:18
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /flow-template-front/src/api/processManagement/processExpression.js
 */
import request from '@/utils/request'

// /workFlowExpression/selectAll
// 查询流程达式列

export function listProcessExpression(query) {
  return request({
    url: '/workFlowExpression/selectAll',
    method: 'get',
    params: query
  })
}

// 查询流程达式详细
export function getProcessExpression(id) {
  return request({
    url: '/workFlowExpression/' + id,
    method: 'get'
  })
}

// 新增流程达式
export function addProcessExpression(data) {
  return request({
    url: '/workFlowExpression/insert',
    method: 'post',
    data: data
  })
}

// 修改流程达式
export function updateProcessExpression(data) {
  return request({
    url: '/workFlowExpression/update',
    method: 'put',
    data: data
  })
}

// 删除流程达式
export function delProcessExpression(data) {
  return request({
    url: '/workFlowExpression/delete',
    method: 'delete',
    data
  })
}
