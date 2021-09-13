/*
 * @Author: your name
 * @Date: 2021-08-11 17:52:26
 * @LastEditTime: 2021-08-12 17:21:49
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /flow-template-front/src/api/processmanager/processTenant.js
 */
// /workFlowTenant/{id}
import request from '@/utils/request'

// 查询租户管理列表
export function listProcessTenant(query) {
  return request({
    // /workFlowTenant/selectAll
    url: '/workFlowTenant/selectAll',
    method: 'get',
    params: query
  })
}

// 查询租户管理详细
export function getProcessTenant(id) {
  return request({
    url: '/workFlowTenant/' + id,
    method: 'get'
  })
}

// 新增租户管理
export function addProcessTenant(data) {
  return request({
    // /workFlowTenant/insert
    url: '/workFlowTenant/insert',
    method: 'post',
    data: data
  })
}

// 修改租户管理
export function updateProcessTenant(data) {
  return request({
    url: '/workFlowTenant/update',
    method: 'put',
    data: data
  })
}

// 删除租户管理
export function delProcessTenant(id) {
  const idList = id.toString().split(',')
  return request({
    url: '/workFlowTenant/delete',
    method: 'delete',
    data: idList
  })
}
