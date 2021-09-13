import request from '@/utils/request'

// 查询服务列表
export function listProcessService(query) {
  return request({
    url: '/workFlowService/selectAll',
    method: 'get',
    params: query
  })
}

// 查询服务详细
export function getProcessService(id) {
  return request({
    url: '/workFlowService/' + id,
    method: 'get'
  })
}

// 新增服务
export function addProcessService(data) {
  return request({
    url: '/workFlowService/insert',
    method: 'post',
    data: data
  })
}

// 修改服务
export function updateProcessService(data) {
  return request({
    url: '/workFlowService/update',
    method: 'put',
    data: data
  })
}

// 删除服务
export function delProcessService(id) {
  let idList = id.toString().split(',')
  return request({
    url: '/workFlowService/delete',
    method: 'delete',
    data: idList
  })
}

// 流程定义分类
export const getTypeList = async () => {
  return request({
    url: '/flowable/definition/listDefinitionsCategory',
    method: 'get'
  })
}

// 流程定义
export const getDefinitionList = async (id) => {
  return request({
    url: '/flowable/definition/listDefinitionsKeyAndName',
    method: 'get',
    params: {
      categoryId: id
    }
  })
}

// 流程定义版本
export const getVersionList = async (id) => {
  return request({
    url: '/flowable/definition/listDefinitionsAll',
    method: 'get',
    params: {
      key: id
    }
  })
}
