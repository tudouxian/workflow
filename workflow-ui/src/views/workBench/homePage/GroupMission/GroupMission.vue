<!--
 * @Author: your name
 * @Date: 2021-07-15 16:11:07
 * @LastEditTime: 2021-08-23 10:09:11
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /flow-template-front/src/views/workBench/homePage/GroupMission/GroupMission.vue
-->
<!--
 * @Author: xueyan
 * @Date: 2021-07-15 16:11:07
 * @LastEditTime: 2021-07-20 09:49:30
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /flow-template-front/src/views/workBench/homePage/DoneMission/DoneMission.vue
-->
<template>
  <div class="group-mission">
    
    <el-form class="search-form" :model="queryParams" ref="queryForm" inline label-width="68px" v-show="showSearch">
      <el-form-item label="业务主键" prop="businessKey">
        <el-input
          v-model="queryParams.businessKey"
          placeholder="请输入业务主键"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="流程名称" prop="processName">
        <el-input
          v-model="queryParams.processName"
          placeholder="请输入流程名称"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="节点名称" prop="taskName">
        <el-input
          v-model="queryParams.taskName"
          placeholder="请输入节点名称"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="待办人" prop="assignee">
        <el-select
          v-model="queryParams.assignee"
          placeholder="请选择待办人"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        >
          <el-option v-for="item in dict.todoUsers" :key="item.value" :value="item.value" :label="item.name"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="时间范围">
        <el-date-picker
          v-model="dateRange"
          type="daterange"
          range-separator="至"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
          clearable
          size="small"
          value-format="yyyy-MM-dd"
          @keyup.enter.native="handleQuery"
          @change="onRangeChange"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
        >发起流程</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>
    <el-table
      v-loading="loading"
      :data="personalMissionList"
      row-key="categoryCode"
    >
      <el-table-column label="业务编号" align="center" prop="businessKey" />
      <el-table-column label="流程名称" align="center" prop="processDefName" />
      <el-table-column label="流程启动人" align="center" prop="startUserName" />
      <el-table-column label="流程总耗时" align="center" prop="totalTime" />
      <el-table-column label="流程实例状态名称" align="center" prop="processStatusName" />
      <el-table-column label="当前任务名称" align="center" prop="taskName" />
      <el-table-column label="任务创建时间" align="center" prop="taskCreateTime" />
      <el-table-column label="任务停留时间" align="center" prop="taskStayHour" />
      <el-table-column label="审批人" align="center" prop="assigneeName" />
      <el-table-column label="租户名称" align="center" prop="tenantName" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-finished"
            @click="handleView(scope.row)"
          >签收任务</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-guide"
            @click="handleViewFlow(scope.row)"
          >流程图</el-button>
        </template>
      </el-table-column>
    </el-table>
    <pagination
      v-show="total > 0"
      :total="total"
      :page.sync="queryParams.pageIndex"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />
    <!-- <el-dialog title="流程图" :visible.sync="processOpen" width="900px" append-to-body>
      <img :src="processImg">
    </el-dialog> -->
    <el-dialog title="流程图" :visible.sync="processOpen" width="900px" append-to-body>
      <BpmnViewer :processInstanceId="modelProcessInstanceId" />
    </el-dialog>
  </div>
</template>
<script>
import dict from './dict'
import { getTableData, claimTask, getProcessImg } from '@/api/workmenu/groupmission'
import BpmnViewer from '@/components/package/bpmnViewer/index.vue'

export default {
  name: 'GroupMission',
  mixins: [dict],
  components: {
    BpmnViewer
  },
  data() {
    return {
      showSearch: true,
      dateRange: null,
      queryParams: {
        pageIndex: 1,
        pageSize: 10,
        businessKey: null,
        processName: null,
        taskName: null,
        startTime: null,
        endTime: null,
      },
      total: 0,
      loading: true,
      personalMissionList: [],
      processOpen: false,
      processImg: '',
      modelProcessInstanceId: '',
    }
  },
  created() {
    this.getList();
  },
  methods: {
    async getList() {
      this.loading = true;
      const { data, totalNum } = await getTableData(this.queryParams)
      this.personalMissionList = data;
      this.total = totalNum;
      this.loading = false;
    },
    onRangeChange(val) {
      this.queryParams.startTime = val ? val[0] : null
      this.queryParams.endTime = val ? val[1] : null
    },
    resetQuery() {
      this.resetForm("queryForm");
      this.queryParams = {
        pageIndex: 1,
        pageSize: 10,
        businessKey: null,
        processName: null,
        taskName: null,
        startTime: null,
        endTime: null,
      }
      this.dateRange = null
    },
    handleQuery() {
      this.queryParams.pageIndex = 1;
      this.getList();
    },
    async handleAdd() {
      this.$router.push({ path: 'homePageAdd'})
      
      // this.open = true;
      // this.title = "发起流程";
      // const { data } = await getFlowType()
      // this.treeData = this.handleTree(data)
    },
    async handleView(row) {

      this.$alert('确定领取该任务吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        beforeClose: (action, instance, done) => {
          if (action === 'confirm') {
            instance.confirmButtonLoading = true;
            instance.confirmButtonText = '执行中...';
            this.claim(row, instance, done)
          } else {
            done();
            instance.confirmButtonLoading = false;
          }
        }
      });
    },
    async claim (row, instance, done) {
      let data = {
        processInstanceId: row.processInstId,
        taskId: row.taskId
      }
      const res = await claimTask(data);
      done();
      instance.confirmButtonLoading = false;
      if (res.success) {
        this.$message({
          message: '操作成功',
          type: 'success'
        });
        this.getList()
      } else {
        this.$message.error(res.msg);
      }
      
    },
    async handleViewFlow (row) {
      this.processOpen = true
      this.$nextTick(() => {
        this.modelProcessInstanceId = row.processInstId
      })
      console.log(row)
    }
  },
}
</script>
<style lang="scss" scoped>
</style>