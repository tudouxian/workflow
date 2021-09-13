export default {
  computed: {
    dict() {
      return {
        modelType: this.$store.state.dict.modelType,
        status: this.$store.state.dict.status,
        category: this.$store.state.dict.category,
        dept: this.$store.state.dict.dept,
        tenant: this.$store.state.dict.tenant,
      }
    }
  },
  methods: {
    formatterModelType(row, column, cellValue) {
      return this.dict.modelType.find(item => item.value === cellValue).name
    },
    formatterCategoryId(row, column, cellValue) {
      return this.dict.category.find(item => item.value === cellValue).name
    },
    formatterStatus(row, column, cellValue) {
      return this.dict.status.find(item => item.value === cellValue).name
    },
    formatterOwnDeptName(row, column, cellValue) {
      return this.dict.dept.find(item => item.value === cellValue).name
    },
    formatterTenantId(row, column, cellValue) {
      return this.dict.tenant.find(item => item.value === cellValue).name
    },
  },
}
