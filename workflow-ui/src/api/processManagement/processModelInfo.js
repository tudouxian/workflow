import request from '@/utils/request'

// 查询流程模型基本信息列表
export function listProcessModelInfo(query) {
  return request({
    url: '/workFlowModelInfo/selectAll',
    method: 'get',
    params: query
  })
}

// 查询流程模型基本信息详细
export function getProcessModelInfo(id) {
  return request({
    url: '/workFlowModelInfo/' + id,
    method: 'get'
  })
}

// 新增流程模型基本信息
export function addProcessModelInfo(data) {
  return request({
    url: '/workFlowModelInfo/insertOrUpdate',
    method: 'post',
    data: data
  })
}

// 修改流程模型基本信息
export function updateProcessModelInfo(data) {
  return request({
    url: '/workFlowModelInfo/insertOrUpdate',
    method: 'post',
    data: data
  })
}

// 删除流程模型基本信息
export function delProcessModelInfo(id) {
  return request({
    url: '/workFlowModelInfo/delete',
    method: 'delete',
    params: {
      idList: id.join(',')
    }
  })
}

// 发布流程模型基本信息
export function publishBpmn(deployId) {
  return request({
    url: '/flowable/modeler/publishBpmn/' + deployId,
    method: 'post'
  })
}

// 停用流程模型基本信息
export function stopBpmn(deployId) {
  return request({
    url: '/flowable/modeler/stopBpmn/' + deployId,
    method: 'post'
  })
}

// 读取xml文件
export function readXml(deployId) {
  return request({
    url: '/flowable/modeler/getBpmnByModelId/' + deployId,
    method: 'get'
  })
}

// 保存模型设计器bpmn
export function saveXml(data) {
  console.log(data);
  return request({
    url: '/flowable/modeler/saveBpmnModel',
    method: 'post',
    data: data
  })
}
