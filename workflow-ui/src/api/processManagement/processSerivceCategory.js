import request from '@/utils/request'

// 查询服务分类列表
export function listProcessSerivceCategory(query) {
  return request({
    url: '/workFlowServiceCategory/list',
    method: 'get',
    params: query
  })
}

// 查询服务分类详细
export function getProcessSerivceCategory(id) {
  return request({
    url: '/workFlowServiceCategory/' + id,
    method: 'get'
  })
}

// 新增服务分类
export function addProcessSerivceCategory(data) {
  return request({
    url: '/workFlowServiceCategory/insert',
    method: 'post',
    data: data
  })
}

// 修改服务分类
export function updateProcessSerivceCategory(data) {
  return request({
    url: '/workFlowServiceCategory/update',
    method: 'put',
    data: data
  })
}

// 删除服务分类
export function delProcessSerivceCategory(id) {
  const idList = id.toString().split(',')

  return request({
    url: '/workFlowServiceCategory/delete',
    method: 'delete',
   /* params: {
      idList: id.join(',')
    }*/
    data: idList
  })
}
