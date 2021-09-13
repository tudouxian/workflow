export default {
  computed: {
    dict() {
      return {
        category: this.$store.state.dict.category,
      }
    }
  },
  methods: {
    formatterCategoryId(row, column, cellValue) {
      console.log(cellValue);
      const findDict = this.dict.category.find(item => item.value == cellValue)
      return findDict ? findDict.name : "未找到字典项"
    }
  },
}
