import request from '@/utils/request'

// 查询租户邮箱配置列表
export function listEmail(query) {
  return request({
    url: '/workFlowEmail/selectAll',
    method: 'get',
    params: query
  })
}

// 查询租户邮箱配置详细
export function getEmail(id) {
  return request({
    url: '/workFlowEmail/' + id,
    method: 'get'
  })
}

// 新增租户邮箱配置
export function addEmail(data) {
  return request({
    url: '/workFlowEmail/insert',
    method: 'post',
    data: data
  })
}

// 修改租户邮箱配置
export function updateEmail(data) {
  return request({
    url: '/workFlowEmail/update',
    method: 'put',
    data: data
  })
}

// 删除租户邮箱配置
export function delEmail(id) {
  const idList = id.toString().split(',')
  return request({
    url: '/workFlowEmail/delete',
    method: 'delete',
    data: idList
  })
}
