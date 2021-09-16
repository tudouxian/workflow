export default {
  computed: {
    dict() {
      return {
        // 是否上线
        systemListener: [
          {
            label: '上线',
            value: 0
          },
          {
            label: '下线',
            value: 1
          }
        ],
      }
    }
  },
  methods: {

    formatterStatus(row, column, cellValue) {
      return this.dict.systemListener.find(item => item.value === cellValue)?.label ?? ''
    },
  },
}
