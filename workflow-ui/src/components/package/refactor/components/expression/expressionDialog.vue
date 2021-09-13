<!--
 * @Author: 薛严
 * @Date: 2021-09-02 10:43:53
 * @LastEditTime: 2021-09-02 11:06:35
 * @LastEditors: Please set LastEditors
 * @Description: 选择表达式弹窗
 * @FilePath: /flow-template-front/src/components/package/refactor/components/expressionDialog.vue
-->

<template>
  <div>
    <el-dialog :title="title" :visible.sync="dialogOpen" @close="cancel" width="800px" append-to-body>

      <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="90px">
        <el-form-item label="表达式名称" prop="expressionName">
          <el-input
            v-model="queryParams.expressionName"
            placeholder="请输入表达式名称"
            clearable
            size="small"
            @keyup.enter.native="handleQuery"
          />
        </el-form-item>
        <el-form-item label="表达式内容" prop="expressionValue">
          <el-input
            v-model="queryParams.expressionValue"
            placeholder="请输入表达式内容"
            clearable
            size="small"
            @keyup.enter.native="handleQuery"
          />
        </el-form-item>
        <el-form-item label="系统预设表达式" prop="systemExpression">
          <el-select v-model="queryParams.systemExpression" placeholder="请选择系统预设表达式" clearable size="small">
            <el-option v-for="item in dict.systemExpression" :key="item.value" :label="item.label" :value="item.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="描述信息" prop="desc">
          <el-input
            v-model="queryParams.desc"
            placeholder="请输入描述信息"
            clearable
            size="small"
            @keyup.enter.native="handleQuery"
          />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
          <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>

      <el-table ref="table" v-loading="loading" :data="processExpressionList" @select="handleSelection" @select-all="handleSelectionAll">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="主键id" align="center" prop="id" />
        <el-table-column label="表达式名称" align="center" prop="expressionName" />
        <el-table-column label="表达式内容" align="center" prop="expressionValue" />
        <el-table-column label="系统预设表达式" align="center" prop="systemExpression" :formatter="formatterSystemExpression" />
        <el-table-column label="描述信息" align="center" prop="desc" />
      </el-table>

      <pagination
        v-show="total>0"
        :total="total"
        :page.sync="queryParams.pageIndex"
        :limit.sync="queryParams.pageSize"
        @pagination="getList"
      />

      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submit">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>
<script>
import { listProcessExpression } from "@/api/processManagement/processExpression";
import dict from '../expression/dict'

export default {
  name: 'expressionDialog',
  props: {
    open: Boolean
  },
  mixins: [dict],

  data () {
    return {
      title: '选择流程表达式',
      dialogOpen: false,
      showSearch: true,
      loading: false,
      // 查询参数
      queryParams: {
        pageIndex: 1,
        pageSize: 10,
        expressionName: null,
        expressionValue: null,
        systemExpression: null,
        desc: null,
      },
      total: 0,
      processExpressionList: [],
      selectObj: {},
    }
  },
  watch: {
    open (val, oldVal) {
      this.dialogOpen = val;
      console.log('open', val)
      if (val) {
        this.handleQuery();
      }
    }
  },
  methods: {
    /** 查询流程达式列表 */
    getList() {
      this.loading = true;
      listProcessExpression(this.queryParams).then(response => {
        this.processExpressionList = response.data;
        this.total = response.totalNum;
        this.loading = false;
      });
    },
    cancel() {
      this.$emit('close');
      this.resetQuery();
    },
    submit () {
      this.$emit('submit', this.selectObj)
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageIndex = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    handleSelection (select, row) {
      this.$refs.table.clearSelection();
      this.selectObj = {};
      if (row) {
        this.selectObj = row;
        this.$refs.table.toggleRowSelection(row, true);
      }
    },
    handleSelectionAll (selectList) {
      this.selectObj = {};
      this.$refs.table.clearSelection();
    },

  }
}
</script>

