<!--
 * @Author: 薛严
 * @Date: 2021-08-26 10:32:29
 * @LastEditTime: 2021-09-02 11:00:00
 * @LastEditors: Please set LastEditors
 * @Description: 执行监听器-选择弹窗
 * @FilePath: /flow-template-front/src/components/package/refactor/listeners/components/selectListenerDialog.vue
-->

<template>
  <div>
    <el-dialog :title="title" :visible.sync="dialogOpen" @close="cancel" width="800px" append-to-body>
      <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="98px">
        <el-form-item label="监听器名称" prop="listenerName">
          <el-input
            v-model="queryParams.listenerName"
            placeholder="请输入监听器名称"
            clearable
            size="small"
            @keyup.enter.native="handleQuery"
          />
        </el-form-item>
        <el-form-item label="监听器类型" prop="listenerType">
          <el-select v-model="queryParams.listenerType" disabled placeholder="请选择监听器类型" clearable size="small">
            <el-option v-for="item in dict.listenerType" :key="item.value" :label="item.label" :value="item.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="事件类型" prop="eventType">
          <el-select v-model="queryParams.eventType" placeholder="请选择事件类型" clearable size="small">
            <el-option v-for="item in dict.eventType" :key="item.value" :label="item.label" :value="item.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="值类型" prop="valueType">
          <el-select v-model="queryParams.valueType" placeholder="请选择值类型" clearable size="small">
            <el-option v-for="item in dict.valueType" :key="item.value" :label="item.label" :value="item.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="是否是系统预设监听器" prop="systemListener">
          <el-select v-model="queryParams.systemListener" placeholder="请选择是否是系统预设监听器" clearable size="small">
            <el-option v-for="item in dict.systemListener" :key="item.value" :label="item.label" :value="item.value" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
          <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>

      <el-table v-loading="loading" ref="table" :data="tableList" @select="handleSelection" @select-all="handleSelectionAll">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="主键" align="center" prop="id" />
        <el-table-column label="监听器名称" align="center" prop="listenerName" />
        <el-table-column label="监听器类型" align="center" prop="listenerType" :formatter="formatterListenerType" />
        <el-table-column label="事件类型" align="center" prop="eventType" :formatter="formatterEventType" />
        <el-table-column label="值类型" align="center" prop="valueType" :formatter="formatterValueType" />
        <el-table-column label="监听器值" align="center" prop="listenerValue" />
        <el-table-column label="是否是系统预设监听器" align="center" prop="systemListener" :formatter="formatterSystemListener" />
        <el-table-column label="备注-描述" align="center" prop="desc" />
      </el-table>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submit">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>
<script>
import { listProcessListener } from '@/api/processManagement/processListener.js'
import dict from './dict'
export default {
  name: 'SelectListenerDialog',
  props: {
    open: Boolean,
    listenerType: Number, // 1 执行监听器  2 任务监听器
  },
  mixins: [dict],
  watch: {
    open (val, oldVal) {
      this.dialogOpen = val;
      if (val) {
        this.getList();
      }
    }
  },
  data() {
    return {
      title: this.listenerType === 1 ? '选择执行监听器' : '选择任务监听器',
      dialogOpen: false,
      // 查询参数
      queryParams: {
        pageIndex: 1,
        pageSize: 10,
        listenerName: null,
        listenerType: this.listenerType,
        eventType: null,
        valueType: null,
        systemListener: null,
      },
      total: 0,
      loading: false,
      tableList: [],
      selectObj: {}
    }
  },
  methods: {
    async getList () {
      this.loading = true;
      const res = await listProcessListener(this.queryParams);
      this.loading = false;
      this.tableList = res.data;
      this.total = res.totalNum;
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
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageIndex = 1;
      this.getList();
    },
    submit () {
      if (this.selectObj) {
        this.$emit('submit', this.selectObj)
      }
      this.cancel()
    },
    cancel () {
      this.$emit('close');
    },
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
  }
}
</script>
