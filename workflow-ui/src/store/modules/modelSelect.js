/*
 * @Author: your name
 * @Date: 2021-07-30 17:03:49
 * @LastEditTime: 2021-08-06 14:57:56
 * @LastEditors: Please set LastEditors
 * @Description: 流程模型编辑内人员选择
 * @FilePath: /flow-template-front/src/store/modules/modelSelect.js
 */
const modelSelect = {
  state: {
    isMultiple: false, // 是否多选
    variableSelect: [],
    variableSelectUserId: []
  },
  mutations: {
    SET_ISMULTIPLE: (state, data) => {
      state.isMultiple = data
    },
    SET_VARIABLESELECT: (state, list) => {
      state.variableSelect = [...new Set(list)]
    },
    DEL_VARIABLESELECT: (state, item) => {
      state.variableSelect.splice(state.variableSelect.indexOf(item), 1)
    },
    DEL_VARIABLESELECT_ALL: (state) => {
      state.variableSelect = []
    },
    SET_VARIABLESELECTUSERID: (state, list) => {
      state.variableSelectUserId = [...new Set(list)]
    },
    DEL_VARIABLESELECTUSERID: (state, id) => {
      state.variableSelectUserId.splice(state.variableSelectUserId.indexOf(id), 1)
    },
    DEL_VARIABLESELECTUSERID_ALL: (state) => {
      state.variableSelectUserId = []
    }

  },

}
export default modelSelect