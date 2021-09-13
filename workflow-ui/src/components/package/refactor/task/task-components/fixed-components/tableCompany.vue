<!--
 * @Author: xueyan
 * @Date: 2021-07-28 15:50:52
 * @LastEditTime: 2021-08-03 15:08:32
 * @LastEditors: Please set LastEditors
 * @Description: 弹窗tab内 公司
 * @FilePath: /flow-template-front/src/components/package/refactor/task/task-components/tableCompany.vue
-->
<template>
  <div class="table-company">
    <el-row  :gutter="20">
      <el-col :span="6">
        <el-tree class="tree" :data="treeData" :props="defaultProps" @node-click="handleNodeClick"></el-tree>
      </el-col>
      <el-col :span="18">
        <el-table :data="tableData" :height="500" tooltip-effect="dark" ref="multipleTable" @selection-change="handleSelectionChange">
          <el-table-column prop="type" label="名称"></el-table-column>
          <el-table-column prop="date" label="变量名"></el-table-column>
          <el-table-column prop="date" label="备注"></el-table-column>
        </el-table>
      </el-col>
    </el-row>
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
  name: 'tableCompany',
  data () {
    return {
      treeData: [],
      defaultProps: {
        children: 'children',
        label: 'label'
      },
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
    getList () {
      
    },
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    handleNodeClick(data) {
      console.log(data);
    },
  }
}
</script>