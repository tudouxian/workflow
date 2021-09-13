export default {
  computed: {
    dict() {
      return {
        tenant: this.$store.state.dict.tenant,
        category: this.$store.state.dict.category,
        todoUsers: this.$store.state.dict.todoUsers
      }
    }
  },
  methods: {
    formatterFlowStatus(row, column, cellValue) {
      return this.dict.flowStatus.find(item => item.value === cellValue).name
    },
    formatterTenant(row, column, cellValue) {
      return this.dict.tenant.find(item => item.value === cellValue).name
    },
  },
}