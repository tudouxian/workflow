<!--
 * @Author: xueyan
 * @Date: 2021-07-28 15:50:52
 * @LastEditTime: 2021-08-20 11:01:40
 * @LastEditors: Please set LastEditors
 * @Description: 弹窗tab内 矩阵
 * @FilePath: /flow-template-front/src/components/package/refactor/task/task-components/tableCompanyMatrix.vue
-->
<template>
  <div class="table-company-matrix">
    <el-row  :gutter="20">
      <el-col :span="4">
        <!-- 暂无数据  暂时放在这里，后面再有数据再写逻辑 -->
        <el-tree class="tree" :data="areaTreeData" :props="areaDefaultProps" @node-click="areaHandleNodeClick"></el-tree>
      </el-col>
      <el-col :span="4">
        <el-tree class="tree" :data="deptTreeData" :props="deptDefaultProps" @node-click="deptHandleNodeClick"></el-tree>
      </el-col>
      <el-col :span="16">
        <el-select v-model="roleKey" clearable @change="roleChange" placeholder="请选择角色">
          <el-option
            v-for="item in roleList"
            :key="item.roleId"
            :label="item.roleName"
            :value="item.roleKey">
          </el-option>
        </el-select>
        <el-table :data="tableData" :height="460" tooltip-effect="dark" ref="multipleTable" @select="handleSelectionChange" @select-all="handleSelectionChange">
          <el-table-column
            type="selection"
            width="55">
          </el-table-column>
          <el-table-column prop="nickName" label="名称"></el-table-column>
          <el-table-column prop="email" label="邮箱"></el-table-column>
          <el-table-column prop="phonenumber" label="手机号"></el-table-column>
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
import { getAreaList, getDeptTree, getRoleList, getUsersByGroupKey } from "@/api/processCenter/model.js";
export default {
  name: 'tableCompanyMatrix',
  data () {
    return {
      tableData: [],
      areaTreeData: [],
      areaDefaultProps: {
        children: 'children',
        label: 'areaName'
      },
      areaKey: '',
      deptTreeData: [],
      deptDefaultProps: {
        children: 'children',
        label: 'deptName'
      },
      deptKey: '',
      roleList: [],
      roleKey: '',
      // 查询参数
      total: 0,
      queryParams: {
        pageNum: 1,
        pageSize: 10
      },
    }
  },
  methods: {
    // 区域
    async getArea () {
      const res = await getAreaList()
      this.areaTreeData = res.data;
    },
    // 部门
    async getdept () {
      const res = await getDeptTree()
      this.deptTreeData = res.data;
    },
    // 角色
    async getRole () {
      const res = await getRoleList()
      this.roleList = res.data;
    },
    async getList () {
      let params = {
        groupKey: `${this.areaKey}+${this.deptKey}+${this.roleKey}`,
        ...this.queryParams,
        pageIndex: this.queryParams.pageNum
      }
      const res = await getUsersByGroupKey(params);
      this.tableData = res.data.resultBean.data
      this.total = res.data.resultBean.totalNum
      this.setSelectState()
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
    areaHandleNodeClick(data) {
      // 字段待确定
      this.areaKey = data.areaKey;
      this.queryParams.pageNum = 1;
      this.getList();
    },
    deptHandleNodeClick(data) {
      this.deptKey = data.deptKey;
      this.queryParams.pageNum = 1;
      this.getList();
    },
    roleChange () {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    // 留给父组件的方法
    async getData () {
      this.areaTreeData && this.getArea()
      this.deptTreeData && this.getdept()
      this.roleList && this.getRole()
      this.queryParams = {
        pageNum: 1,
        pageSize: 10
      }
      await this.getList()
      this.setSelectState()
    }
  }
}
</script>
