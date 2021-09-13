import request from '@/utils/request'

// 查询流程表单列表
export function listForm(query) {
  return request({
    url: '/workFlowFormModelInfo/selectAll',
    method: 'get',
    params: query
  })
}

// 查询流程表单详细
export function getForm(formId) {
  return request({
    url: '/workFlowFormModelInfo/' + formId,
    method: 'get'
  })
}

// 新增流程表单
export function addForm(data) {
  return request({
    url: '/workFlowFormModelInfo/insert',
    method: 'post',
    data: data
  })
}

// 修改流程表单
export function updateForm(data) {
  return request({
    url: '/workFlowFormModelInfo/update',
    method: 'put',
    data: data
  })
}
