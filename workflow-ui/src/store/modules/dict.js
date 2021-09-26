import * as dictArr from '@/api/dict'
const requestArr = Object.values(dictArr)
export default {
  state: {
    modelType: [
      {
        name: '自定义流程',
        value: 0
      },
      {
        name: '业务流程',
        value: 1
      },
    ],
    status: [
      {
        name: '草稿',
        value: 1
      },
      {
        name: '待发布',
        value: 2
      },
      {
        name: '已发布',
        value: 3
      },
      {
        name: '停用',
        value: 4
      },
    ],
    flag: [
      {
        name: '关闭',
        value: 0
      },
      {
        name: '开启',
        value: 1
      }
    ],
    category: [],
    dept: [],
    tenant: [],
    todoUsers: []
  },
  mutations: {
    SET_DICT(state, dictData) {
      state.category = dictData[0]?.data?.map(item => ({
        name: item.categoryName,
        value: item.id
      }))
      state.dept = dictData[1]?.data?.map(item => ({
        name: item.deptName,
        value: item.deptId
      }))
      state.tenant = dictData[2]?.data?.map(item => ({
        name: item.tenantName,
        value: item.tennatId
      }))
      state.todoUsers = dictData[3]?.data?.map(item => ({
        name: item.nickName,
        value: item.userId
      }))
    }
  },
  actions: {
    async getDictData({ commit }) {
      console.log("=====初始化字典")
      const data = await Promise.all(requestArr.map(item => item()))
      console.log("=====初始化字典",data)
      commit('SET_DICT', data)
    }
  }
}
