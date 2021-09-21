<!--
 * @Author: xueyan
 * @Date: 2021-07-28 15:50:52
 * @LastEditTime: 2021-08-06 11:10:30
 * @LastEditors: Please set LastEditors
 * @Description: 弹窗tab内 部门
 * @FilePath: /flow-template-front/src/components/package/refactor/task/task-components/tableDepartment.vue
-->
<template>
  <div class="table-department">
    <el-row  :gutter="20">
      <el-col :span="6">
        <el-tree class="tree" :data="treeData" :props="defaultProps" @node-click="handleNodeClick"></el-tree>
      </el-col>
      <el-col :span="18">
        <el-table :data="tableData" :height="500" tooltip-effect="dark" ref="multipleTable" @select="handleSelectionChange" @select-all="handleSelectionChange">
          <el-table-column
            type="selection"
            label="选择"
            prop="1"
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
import { getDeptTree, getUserByDeptKey } from "@/api/processCenter/model.js";
export default {
  name: 'tableDepartment',
  data () {
    return {
      treeData: [],
      defaultProps: {
        children: 'children',
        label: 'deptName'
      },
      tableData: [],
      // 查询参数
      total: 0,
      queryParams: {
        pageNum: 1,
        pageSize: 10
      },
      deptKey: '', // 部门key筛选,通过key搜人员
    }
  },

//利用计算属性
  computed: {
    idlist() {
      return this.$store.getters.modelSelect.variableSelectUserId;
    }
  },
  watch: {
    'idlist': {
      handler () {
        this.setSelectState()
      },
      deep: true
    }
  },
  created () {
    console.log('created');
  },
  methods: {
    async getDeptTree () {
      // 获取部门tree
      const res = await getDeptTree();
      this.treeData = res.data;
      this.queryParams = {
        pageNum: 1,
        pageSize: 10
      }
      this.getList();
    },
    async getList() {
      let params = {
        ...this.queryParams,
        pageIndex: this.queryParams.pageNum
      }
      const res = await getUserByDeptKey(this.deptKey ? [this.deptKey] : [], params);
      this.tableData = res.data;
      this.total = res.totalNum
      this.setSelectState();
    },
    handleSelectionChange(val, data) {
      // 多选,不考虑全选的情况
      if (this.$store.getters.modelSelect.isMultiple) {
        let variableSelect = this.$store.getters.modelSelect.variableSelect;
        let variableSelectUserId = this.$store.getters.modelSelect.variableSelectUserId;
        if (!data) {
          // 全选,或者清空当前页选择
          // 防止用户信息被修改
          if (val.length) {
            // 全选
            val.forEach((item, index) => {
              if (variableSelectUserId.indexOf(item.userId) === -1) {
                variableSelectUserId.push(item.userId)
                variableSelect.push(item)
              }
            })
          } else {
            // 清空当前页选择
            this.tableData.forEach((item, index) => {
              let delIndex = variableSelectUserId.indexOf(item.userId)

              if (delIndex > -1) {
                variableSelect.splice(delIndex, 1)
                variableSelectUserId.splice(delIndex, 1)
              }
            })
          }

        } else if (this.$store.getters.modelSelect.variableSelectUserId.indexOf(data.userId) === -1) {
          // 普通选择
          variableSelect.push(data);
          variableSelectUserId.push(data.userId)
        } else {
          // 普通取消选择
          variableSelect.splice(variableSelectUserId.indexOf(data.userId), 1);
          variableSelectUserId.splice(variableSelectUserId.indexOf(data.userId), 1);
        }

        this.$store.commit('SET_VARIABLESELECT', variableSelect)
        this.$store.commit('SET_VARIABLESELECTUSERID', variableSelectUserId)
      } else {
        // 单选
        this.$store.commit('DEL_VARIABLESELECT_ALL');
        val.length && this.$store.commit('SET_VARIABLESELECT', [val[val.length - 1]])
        this.$store.commit('DEL_VARIABLESELECTUSERID_ALL');
        val.length && this.$store.commit('SET_VARIABLESELECTUSERID', [val[val.length - 1].userId])
      }

      this.setSelectState();
    },
    // 更新表格选中状态
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
      this.deptKey = data.deptKey;
      this.queryParams.pageNum = 1;
      this.getList();
    }
  }
}
</script>
