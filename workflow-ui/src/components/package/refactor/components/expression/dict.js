/*
 * @Author: xueyan
 * @Date: 2021-09-01 14:32:17
 * @LastEditTime: 2021-09-01 14:35:23
 * @LastEditors: Please set LastEditors
 * @Description: 流程表达式字典
 * @FilePath: /flow-template-front/src/views/processManagement/processExpression/dict.js
 */

export default {
  computed: {
    dict() {
      return {
        systemExpression: [
          {
            label: '是',
            value: 0
          },
          {
            label: '否',
            value: 1
          }
        ]
      }
    }
  },
  methods: {
    formatterSystemExpression(row, column, cellValue) {
      return this.dict.systemExpression.find(item => item.value === cellValue)?.label ?? ''
    },
  }
}
