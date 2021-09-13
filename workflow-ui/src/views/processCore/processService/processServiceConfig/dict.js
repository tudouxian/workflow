import { getTypeList, getDefinitionList, getVersionList } from '@/api/processManagement/processServiceConfig'
const dictRequestArr = [
  async () => {
    const { data } = await getTypeList()
    return data.map(item => ({
      label: item.category,
      value: item.categoryId,
      leaf: false
    }))
  },
  async (id) => {
    const { data } = await getDefinitionList(id)
    return data.map(item => ({
      label: item.name,
      value: item.key,
      leaf: false
    }))
  },
  async (id) => {
    const { data } = await getVersionList(id)
    return data.map(item => ({
      label: `${item.name} 版本：v${item.version}`,
      value: item.id,
      leaf: true
    }))
  },
]
export default {
  computed: {
    dict() {
      return {
        type: [
          {
            name: '内部表单服务',
            value: 1
          },
          {
            name: '外部调用服务',
            value: 2
          },
        ],
        publish: [
          {
            name: '是',
            value: 1
          },
          {
            name: '否',
            value: 0
          },
        ],
        open: [
          {
            name: '当前页面',
            value: 0
          },
          {
            name: '新窗口打开',
            value: 1
          }
        ],
        tenant: this.$store.state.dict.tenant,
        difinition: {
          lazy: true,
          emitPath: false,
          lazyLoad(node, resolve) {
            const { level } = node
            const id = node.data ? node.data.value : null
            dictRequestArr[level](id).then((data) => {
              console.log(data);
              resolve(data)
            })
          }
        }
      }
    }
  },
  methods: {
    formatterType(row, column, cellValue) {
      return this.dict.type.find(item => item.value === cellValue)?.name ?? ''
    },
    formatterPublish(row, column, cellValue) {
      return this.dict.publish.find(item => item.value === cellValue).name
    },
    formatterOpen(row, column, cellValue) {
      return this.dict.open.find(item => item.value === cellValue).name
    },
    formatterTenantId(row, column, cellValue) {
      return this.dict.tenant.find(item => item.value === cellValue).name
    },
  },
}
