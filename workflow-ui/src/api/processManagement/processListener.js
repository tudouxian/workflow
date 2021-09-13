/*
 * @Author: xueyan
 * @Date: 2021-08-24 10:25:19
 * @LastEditTime: 2021-08-26 17:05:34
 * @LastEditors: Please set LastEditors
 * @Description: 流程监听器API
 * @FilePath: /flow-template-front/src/api/processManagement/processListener.js
 */
import request from '@/utils/request'

// 查询流程监听器列表
export function listProcessListener(query) {
  return request({
    url: '/workFlowListener/list',
    method: 'get',
    params: query
  })
}
// 查询流程监听器详细
export function getProcessListener(id) {
  return request({
    url: '/workFlowListener/' + id,
    method: 'get'
  })
}

// 新增流程监听器
export function addProcessListener(data) {
  return request({
    url: '/workFlowListener/insert',
    method: 'post',
    data: data
  })
}

// 修改流程监听器
export function updateProcessListener(data) {
  return request({
    url: '/workFlowListener/update',
    method: 'put',
    data: data
  })
}

// 删除流程监听器
export function delProcessListener(data) {
  return request({
    url: '/workFlowListener/delete',
    method: 'delete',
    data
  })
}

// 配置项
// 分页查询配置项列表
export function getConfigureList (params) {
  return request({
    url: '/workFlowListenerParam/selectAll',
    method: 'get',
    params
  })
}
// 查询配置项所有数据-不分页
// /workFlowListenerParam/list
export function getConfigureAll (params) {
  return request({
    url: '/workFlowListenerParam/list',
    method: 'get',
    params
  })
}
// 通过主键查询单条数据
export function getConfigureById (id) {
  return request({
    url: `/workFlowListenerParam/${id}`,
    method: 'get'
  })
}
// 添加配置项
export function addConfigure (data) {
  return request({
    url: '/workFlowListenerParam/insert',
    method: 'post',
    data
  })
}
// 编辑配置项
export function updateConfigure (data) {
  return request({
    url: '/workFlowListenerParam/update',
    method: 'put',
    data
  })
}
// 删除配置项
export function deleteConfigure (data) {
  return request({
    url: '/workFlowListenerParam/delete',
    method: 'delete',
    data
  })
}
