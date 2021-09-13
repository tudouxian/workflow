<!--
 * @Author: your name
 * @Date: 2021-07-29 14:35:14
 * @LastEditTime: 2021-07-29 14:36:01
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /flow-template-front/src/components/package/refactor/task/task-components/identity-components/tableCompanyMatrix.vue
-->

<template>
  <div class="identityTableCompanyMatrix">
    <el-table :data="tableData" :height="500" tooltip-effect="dark" ref="multipleTable" @selection-change="handleSelectionChange">
      <el-table-column prop="type" label="名称"></el-table-column>
      <el-table-column prop="date" label="变量名"></el-table-column>
    </el-table>
    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />
  </div>
</template>
<script>
export default {
  name: 'identityTableCompanyMatrix',
  data () {
    return {
      tableData: [],
      // 查询参数
      total: 0,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        buttonName: null,
        buttonCode: null,
        buttonType: null,
        systemButton: null,
      },
    }
  },
  methods: {
    getList () {},
    handleSelectionChange(val) {
      this.multipleSelection = val;
    }
  }
}
</script>