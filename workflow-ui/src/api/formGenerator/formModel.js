import request from '@/utils/request'

// 查询流程表单列表
export function listForm(query) {
  return request({
    url: '/workFlowFormModel/selectAll',
    method: 'get',
    params: query
  })
}

// 查询流程表单详细
export function getForm(formId) {
  return request({
    url: '/workFlowFormModel/' + formId,
    method: 'get'
  })
}

export function listFormModelByKeyAndVersion(formKey,version) {
  return request({
    url: '/workFlowFormModel/listFormModelByKeyAndVersion/'+formKey+"/"+version,
    method: 'get'
  })
}

// 新增流程表单
export function addForm(data) {
  return request({
    url: '/workFlowFormModel/insert',
    method: 'post',
    data: data
  })
}

// 修改流程表单
export function updateForm(data) {
  return request({
    url: '/workFlowFormModel/update',
    method: 'put',
    data: data
  })
}
