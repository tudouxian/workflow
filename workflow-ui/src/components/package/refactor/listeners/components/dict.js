export default {
  computed: {
    dict() {
      return {
        // 监听器类型
        listenerType: [
          {
            label: '执行监听器',
            value: 1
          },
          {
            label: '任务监听器',
            value: 2
          }
        ],
        // 事件类型
        eventType: [
          {
            label: '创建',
            value: 1
          },
          {
            label: '指派',
            value: 2
          },
          {
            label: '完成',
            value: 3
          },
          {
            label: '删除',
            value: 4
          },
          {
            label: '开始',
            value: 5
          },
          {
            label: '结束',
            value: 6
          },
          {
            label: '启用',
            value: 7
          }
        ],
        // 任务监听器事件类型
        taskEventType: [
          {
            label: '创建',
            value: 'create'
          },
          {
            label: '指派',
            value: 'assignment'
          },
          {
            label: '完成',
            value: 'complete'
          },
          {
            label: '删除',
            value: 'delete'
          }
        ],
        // 执行监听器事件类型
        implementEventType: [
          {
            label: '开始',
            value: 'start'
          },
          {
            label: '结束',
            value: 'end'
          },
          {
            label: '启用',
            value: 'take'
          }
        ],
        // 值类型
        valueType: [
          {
            label: '类',
            value: 'classListener',
            field: 'class'
          },
          {
            label: '表达式',
            value: 'expressionListener',
            field: 'expression'
          },
          {
            label: '委托表达式',
            value: 'delegateExpressionListener',
            field: 'delegateExpression'
          }
        ],
        // 是否是系统预设监听器
        systemListener: [
          {
            label: '是',
            value: 0
          },
          {
            label: '否',
            value: 1
          }
        ],
        // 参数配置
        // 字段类型
        paramType: [
          {
            label: '字符串',
            value: 0,
            field: 'string'
          },
          {
            label: '表达式',
            value: 1,
            field: 'expression'
          }
        ],
        required: [
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
    formatterListenerType(row, column, cellValue) {
      return this.dict.listenerType.find(item => item.value === Number(cellValue))?.label ?? ''
    },
    formatterEventType(row, column, cellValue) {
      return this.dict.eventType.find(item => item.value === Number(cellValue))?.label ?? ''
    },
    formatterTaskEventType(row, column, cellValue) {
      return this.dict.taskEventType.find(item => item.value === cellValue)?.label ?? ''
    },
    formatterImplementEventType(row, column, cellValue) {
      return this.dict.implementEventType.find(item => item.value === cellValue)?.label ?? ''
    },
    formatterValueType(row, column, cellValue) {
      return this.dict.valueType.find(item => item.value === cellValue)?.label ?? ''
    },
    formatterSystemListener(row, column, cellValue) {
      return this.dict.systemListener.find(item => item.value === Number(cellValue))?.label ?? ''
    },
    formatterParamType(row, column, cellValue) {
      return this.dict.paramType.find(item => item.value === Number(cellValue))?.label ?? ''
    },
    formatterRequired(row, column, cellValue) {
      return this.dict.required.find(item => item.value === Number(cellValue))?.label ?? ''
    },
  },
}