import request from '@/utils/request'

// 查询运行时变量信息列表
export function listRuVariable(query) {
  return request({
    url: '/workFlowVariable/selectAll',
    method: 'get',
    params: query
  })
}

// 查询运行时变量信息详细
export function getRuVariable(id) {
  return request({
    url: '/workFlowVariable/' + id,
    method: 'get'
  })
}

// 新增运行时变量信息
export function addRuVariable(data) {
  return request({
    url: '/workFlowVariable/insert',
    method: 'post',
    data: data
  })
}

// 修改运行时变量信息
export function updateRuVariable(data) {
  return request({
    url: '/workFlowVariable/update',
    method: 'put',
    data: data
  })
}

// 删除运行时变量信息
export function delRuVariable(data) {
  return request({
    url: '/workFlowVariable/delete',
    method: 'delete',
    data: data
  })
}
