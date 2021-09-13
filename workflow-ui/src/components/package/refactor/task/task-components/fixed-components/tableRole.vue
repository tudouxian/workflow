<!--
 * @Author: xueyan
 * @Date: 2021-07-28 15:04:47
 * @LastEditTime: 2021-08-04 11:29:45
 * @LastEditors: Please set LastEditors
 * @Description: 弹窗tab内 角色表格
 * @FilePath: /flow-template-front/src/components/package/refactor/task/task-components/tableRole.vue
-->
<template>
  <div class="table-role">
    <el-row  :gutter="20">
      <el-col :span="6">
        <el-tree class="tree" :data="treeData" :props="defaultProps" @node-click="handleNodeClick"></el-tree>
      </el-col>
      <el-col :span="18">
        <el-table :data="tableData" :height="500" tooltip-effect="dark" ref="multipleTable" @select="handleSelectionChange" @select-all="handleSelectionChange">
          <el-table-column
            type="selection"
            width="55">
          </el-table-column>
          <el-table-column prop="nickName" label="名称"></el-table-column>
          <el-table-column prop="userId" label="变量名"></el-table-column>
        </el-table>
        <pagination
          v-show="total>0"
          :total="total"
          :page.sync="queryParams.pageNum"
          :limit.sync="queryParams.pageSize"
          @pagination="getList"
        />
      </el-col>
    </el-row>
  </div>
</template>
<script>
import { getRoleList, getUserByRoleKey } from "@/api/processCenter/model.js";

export default {
  name: 'tableRole',
  data () {
    return {
      treeData: [],
      defaultProps: {
        children: 'children',
        label: 'roleName'
      },
      tableData: [],
      multipleSelection: [],
      // 查询参数
      total: 0,
      queryParams: {
        pageNum: 1,
        pageSize: 10
      },
      roleKey: '',
    }
  },
  methods: {
    async getRoleTree () {
      // 获取角色tree  暂无数据
      const res = await getRoleList();
      this.treeData = res.data;
      this.queryParams = {
        pageNum: 1,
        pageSize: 10
      }
      this.getList();
    },
    async getList () {
      let params = {
        ...this.queryParams,
        pageIndex: this.queryParams.pageNum
      }
      const res = await getUserByRoleKey(this.roleKey ? [this.roleKey] : [], params);
      this.tableData = res.data;
      this.total = res.totalNum;
      this.setSelectState();
    },
    handleNodeClick(data) {
      console.log(data);
    },
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    handleSelectionChange(val) {
      this.$store.commit('DEL_VARIABLESELECT_ALL');
      val.length && this.$store.commit('SET_VARIABLESELECT', [val[val.length - 1]])
      this.$store.commit('DEL_VARIABLESELECTUSERID_ALL');
      val.length && this.$store.commit('SET_VARIABLESELECTUSERID', [val[val.length - 1].userId])
      this.setSelectState();
    },
    // 更新表格选中状态,bug
    setSelectState () {
      this.$nextTick(() => {
        this.tableData.forEach((item, index) => {
          if (this.$store.getters.modelSelect.variableSelectUserId.indexOf(item.userId) !== -1) {
            this.$refs.multipleTable.toggleRowSelection(this.tableData[index], true)
          } else {
            this.$refs.multipleTable.toggleRowSelection(this.tableData[index], false)
          }
        })
      })
    },
    handleNodeClick(data) {
      console.log(data);
      this.roleKey = data.roleKey;
      this.queryParams.pageNum = 1;
      this.getList();
    }
  }
}
</script>
<style lang="scss">
.table-role {
  .tree {
    overflow: scroll;
  }
}
</style>
