<!--
 * @Author: xueyan
 * @Date: 2021-07-16 10:52:29
 * @LastEditTime: 2021-08-19 17:08:45
 * @LastEditors: Please set LastEditors
 * @Description: 工作台-已发
 * @FilePath: /flow-template-front/src/views/workBench/homePage/SentMission/SentMission.vue
-->
<template>
  <div class="done-mission">
    
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
      <el-form-item label="服务名" prop="serviceName">
        <el-input
          v-model="queryParams.serviceName"
          placeholder="请输入服务名"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="流程名称" prop="processInstanceName">
        <el-input
          v-model="queryParams.processInstanceName"
          placeholder="请输入流程名称"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
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
      <el-table-column label="服务号" align="center" prop="serviceName" />
      <el-table-column label="流程名称" align="center" prop="processInstanceName" />
      <el-table-column label="租户名称" align="center" prop="tenantName" />
      <el-table-column label="流程实例状态名称" align="center" prop="processStatusName" />
      <el-table-column label="流程总耗时" align="center" prop="totalTime" />
      <el-table-column label="当前办理人" align="center" prop="currentAssignees" width="180">
        <template slot-scope="scope">
          <el-popover trigger="hover" placement="top" v-for="(item, index) in scope.row.currentAssignees" :key="index">
            <p>姓名: {{ item.name }}</p>
            <p>手机: {{ item.mobile }}</p>
            <div slot="reference" class="name-wrapper">
              <el-tag size="medium">{{ item.name }}</el-tag>
            </div>
          </el-popover>
        </template>
      </el-table-column>
      <el-table-column label="指定候选人" align="center" prop="currentCandidateUsers" width="180">
        <template slot-scope="scope">
          <el-popover trigger="hover" placement="top" v-for="(item, index) in scope.row.currentCandidateUsers" :key="index">
            <p>姓名: {{ item.name }}</p>
            <p>手机: {{ item.mobile }}</p>
            <div slot="reference" class="name-wrapper">
              <el-tag size="medium">{{ item.name }}</el-tag>
            </div>
          </el-popover>
        </template>
      </el-table-column>
      <el-table-column label="指定候选组" align="center" prop="currentCandidate" width="180">
        <template slot-scope="scope">
          <el-tag v-for="(item, index) in scope.row.currentCandidate" :key="index" size="medium">{{ item }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="任务创建时间" align="center" prop="startTime" />
      <el-table-column label="任务结束时间" align="center" prop="endTime" />

      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-view"
            @click="handleView(scope.row)"
          >查看</el-button>
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



    <!-- 处理弹窗 -->
    <el-dialog :title="dialogTitle" :visible.sync="viewOpen" width="900px" append-to-body>
      <div class="flow-view">
        <!-- <el-skeleton class="mb10" :rows="10" /> -->
        <div class="flow-timeline" v-if="timelineList && timelineList.length > 0">
          <div class="flow-view-title mb10">审核记录</div>
          <el-timeline>
            <el-timeline-item v-for="item in timelineList" :key="item.id" :timestamp="`${item.taskName}  ${item.createTime}`" placement="top">
              <el-card>
                <label v-if="item.userName" style="font-weight: normal;margin-right: 30px;">办理人： {{item.userName}}
                  <el-tag type="info" size="mini">办理人部门：{{item.deptName}}</el-tag>
                  <el-tag v-if="item.claimTime" type="info" size="mini">签收时间：{{item.claimTime}}</el-tag>
                </label>
                <label style="font-weight: normal">接收时间： </label><label style="color:#8a909c;font-weight: normal">{{item.createTime}}</label>
                <label v-if="item.endTime" style="margin-left: 30px;font-weight: normal">办结时间： </label><label style="color:#8a909c;font-weight: normal">{{item.endTime}}</label>
                <label v-if="item.durationInMillisView" style="margin-left: 30px;font-weight: normal">耗时： </label><label style="color:#8a909c;font-weight: normal">{{item.durationInMillisView}}</label>

                <div v-for="subItem in item.comments" :key="subItem.time">
                  <p v-if="subItem.type" >操作：
                    <el-tag type="success" >
                      {{ subItem.type }}
                    </el-tag>
                  </p>
                  <p v-if="subItem.fullMessage" >意见：
                    <el-tag type="success" >
                      {{ subItem.fullMessage }}
                    </el-tag>
                  </p>
                  <p v-if="subItem.action" >操作详细：
                    <el-tag type="success" >
                      {{ subItem.action }}
                    </el-tag>
                  </p>
                </div>
              </el-card>
            </el-timeline-item>
          </el-timeline>
        </div>
        <HandleContent ref="HandleContent" :buttonCode="this.buttonCode" :taskId="this.adviceForm.taskId" :processInstanceId="this.adviceForm.processInstanceId" :title="dialogTitle" @off="viewClose" />
      </div>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" class="mb10" v-for="item in buttonList" :key="item.id" @click="handleButtons(item)">{{ item.buttonName }}</el-button>
        <!-- <el-button type="primary" @click="agreeAdvice">同 意</el-button>
        <el-button type="danger" @click="refuseAdvice">拒 绝</el-button> -->
      </div>
    </el-dialog>
    <el-dialog title="流程图" :visible.sync="processOpen" width="900px" append-to-body>
      <BpmnViewer :processInstanceId="modelProcessInstanceId" />
    </el-dialog>
  </div>
</template>
<script>
import dict from './dict'
import { getTableData, getTimelineList, getButton, getProcessImg } from '@/api/workmenu/sentmission'
import HandleContent from '../components/handlecontent.vue'
import BpmnViewer from '@/components/package/bpmnViewer/index.vue'

export default {
  name: 'SentMission',
  mixins: [dict],
  components: {
    HandleContent,
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
        serviceName: null,
        processInstanceName: null,
        startTime: null,
        endTime: null,
      },
      total: 0,
      loading: true,
      personalMissionList: [],
      dialogTitle: '',
      viewOpen: false,
      timelineList: [],
      adviceForm: {
        message: null,
        processInstanceId: null,
        // taskId: null,
      },
      buttonList: [],
      processImg: '',
      processOpen: false,
      // 处理弹窗内当前按钮的状态
      buttonCode: '',
      modelProcessInstanceId: ''
    }
  },
  created() {
    this.getList();
  },
  methods: {
    async getList() {
      this.loading = true;
      const { data, totalNum } = await getTableData(this.queryParams)
      // let currentCandidate = Object.keys(data.currentCandidateGroups);
      
      this.personalMissionList = data;
      this.personalMissionList && this.personalMissionList.forEach((item, index) => {
        item.currentCandidate = item.currentCandidateGroups ? Object.keys(item.currentCandidateGroups) : []
      })
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
        serviceName: null,
        processInstanceName: null,
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
      this.dialogTitle = row.processInstanceName
      this.viewOpen = true
      const { data } = await getTimelineList(row.processInstanceId)
      const res = await getButton()
      this.adviceForm.processInstanceId = row.processInstanceId
      // this.adviceForm.taskId = row.taskId
      this.timelineList = data || []
      this.buttonList = res.data
      console.log(this.buttonList)
    },
    viewClose () {
      this.viewOpen = false
      this.getList()
    },
    async handleButtons(item) {
      const url = item.requestUrl
      if (url) {
        this.$refs.HandleContent.openDialog(item)
        this.buttonCode = item.buttonCode
      } else {
        this.$message.error('无方法名！')
      }
    },
    async handleViewFlow (row) {
      this.processOpen = true
      this.$nextTick(() => {
        this.modelProcessInstanceId = row.processInstanceId
      })
      console.log(row)
    }
  },
}
</script>
<style lang="scss" scoped>
.done-mission {
  .name-wrapper {
    display: inline;
    margin: 3px;
  }
}
</style>