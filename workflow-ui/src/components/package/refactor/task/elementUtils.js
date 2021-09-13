/*
 * @Author: xueyan
 * @Date: 2021-08-05 16:02:01
 * @LastEditTime: 2021-08-05 16:55:01
 * @LastEditors: Please set LastEditors
 * @Description: 任务模块element更新
 * @FilePath: /flow-template-front/src/components/package/refactor/task/elementUtils.js
 */
// 更新元素附加扩展属性
/**
 * 
 * @param {*} element 
 * @param {string} data 
 * @param {*} key 
 */
export function updateElementExecutionListener(element, data, key) {
  // console.log('开始更新', element)
  let elExtensionElements = element.businessObject.get("extensionElements") || window.bpmnInstances.moddle.create("bpmn:ExtensionElements", { values: [] });
  // console.log('elExtensionElements', elExtensionElements)
  let spliceKey = `flowable:${key}`;
  
  const newElement = window.bpmnInstances.moddle.create(`flowable:${key}`, {body: data});
  // console.log('newElement', newElement)
  // 防止覆盖其他属性
  let values = [];
  values = elExtensionElements.values.filter((item, index) => {
    return item.$type !== `flowable:${key}`
  })
  values.push(newElement);

  window.bpmnInstances.modeling.updateModdleProperties(element, elExtensionElements, { values: values});
  // console.log('更新结束')
}

// 获取扩展属性
export function getElementExecutionListener(element, key) {
  let elExtensionElements = element.businessObject.get("extensionElements") || window.bpmnInstances.moddle.create("bpmn:ExtensionElements", { values: [] });
  console.log('查询', key)
  let newElement =
    elExtensionElements?.values?.filter(ex => ex.$type === `flowable:${key}`)?.[0]
  console.log('查询2', newElement)
    
  return newElement?.body ?? '';
}