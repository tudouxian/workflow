import request from '@/utils/request'
// 字典项-分类
export function getCategoryDict() {
  return request({
    url: '/workFlowCategory/list',
    method: 'get'
  })
}

// 字典项-部门
export function getDeptDict() {
  return request({
    url: '/workFlowDepts/selectAll',
    method: 'get'
  })
}

// 字典项-租户
export function getTenantDict() {
  return request({
    url: '/workFlowTenant/list',
    method: 'get'
  })
}

// 字典项-待办人列表
export const getToDoUsers = () => {
  return request({
    url: '/flowable/workBench/findToDoUsers',
    method: 'get'
  })
}
