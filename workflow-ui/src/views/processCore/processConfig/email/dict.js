export default {
  computed: {
    dict() {
      return {
        tenant: this.$store.state.dict.tenant,
      }
    }
  },
  methods: {
    formatterTenantId(row, column, cellValue) {
      return this.dict.tenant.find(item => item.value === cellValue).name
    },
  },
}
