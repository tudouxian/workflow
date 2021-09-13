/*
 * @Author: xueyan
 * @Date: 2021-07-22 16:54:05
 * @LastEditTime: 2021-07-23 10:43:48
 * @LastEditors: Please set LastEditors
 * @Description: 发起流程API
 * @FilePath: /flow-template-front/src/api/workmenu/add.js
 */
import request from '@/utils/request'

// 查询服务分类，按树型结构
export const getTreeByCateGroyName = async (params) => {
  return await request({
    url: '/workFlowServiceCategory/treeByCateGroyName',
    method: 'get',
    params
  })
}

// 查询所有服务信息
export const listAllServiceUnderCategory = async (data) => {
  return await request({
    url: '/workFlowService/listAllServiceUnderCategory',
    method: 'post',
    data
  })
}

// 根据流程定义id启动流程实例，立即申请
export const startProcessService = async (data) => {
  return await request({
    url: '/flowable/workBench/startProcessService',
    method: 'post',
    data
  })
}
