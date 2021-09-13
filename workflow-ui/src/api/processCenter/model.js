/*
 * @Author: your name
 * @Date: 2021-07-30 10:38:29
 * @LastEditTime: 2021-08-20 10:43:19
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /flow-template-front/src/api/model.js
 */
import request from '@/utils/request'
// /workFlowAreas/selectAll
/** getDeptTree​ */
// getDeptTree​
// 获取部门tree
export function getDeptTree (params) {
  return request({
    url: '/workFlowDepts/deptTree',
    method: 'get',
    params
  })
}
// 获取人员   groupKey   组规则：区域key_部门key_角色key
export function getUserByDeptKey (keyList, params) {
  return request({
    url: `/workFlowUsers/selectAllByDeptKeys?pageIndex=${params.pageIndex}&pageSize=${params.pageSize}`,
    method: 'post',
    data: keyList
  })
}

// 获取角色列表
export function getRoleList (params) {
  return request({
    url: `/workFlowRoles/selectAll`,
    method: 'get',
    params
  })
}

// 通过角色key获取用户列表
export function getUserByRoleKey (keyList, params) {
  return request({
    url: `/workFlowUsers/selectAllByRoleKeys?pageIndex=${params.pageIndex}&pageSize=${params.pageSize}`,
    method: 'post',
    data: keyList
  })
}

// 获取区域
export function getAreaList () {
  return request({
    // url: `/workFlowAreas/selectAll`,
    url: `/workFlowAreas/areaTree`,

    method: 'get'
  })
}

// 查询用户 组规则：区域key_部门key_角色key
export function getUsersByGroupKey (params) {
  return request({
    url: `/workFlowGroups/queryPageUsersByGroupKey`,
    method: 'get',
    params
  })
}
