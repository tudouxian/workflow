export default {
  computed: {
    dict() {
      return {
        flag: this.$store.state.dict.flag,
      }
    }
  },
  methods: {
    formatterFlag(row, column, cellValue) {
      return this.dict.flag.find(item => item.value === cellValue).name
    },
  },
}