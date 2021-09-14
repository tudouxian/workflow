import request from '@/utils/request'

// 查询表单分类列表
export function listFormCategory(query) {
  return request({
    url: '/workFlowFormCategory/selectAll',
    method: 'get',
    params: query
  })
}

// 查询表单分类详细
export function getFormCategory(id) {
  return request({
    url: '/workFlowFormCategory/' + id,
    method: 'get'
  })
}

// 新增表单分类
export function addFormCategory(data) {
  return request({
    url: '/workFlowFormCategory/insert',
    method: 'post',
    data: data
  })
}

// 修改表单分类
export function updateFormCategory(data) {
  return request({
    url: '/workFlowFormCategory/update',
    method: 'put',
    data: data
  })
}

// 删除表单分类
export function delFormCategory(data) {
  return request({
    url: '/workFlowFormCategory/delete',
    method: 'delete',
    data: data
  })
}
