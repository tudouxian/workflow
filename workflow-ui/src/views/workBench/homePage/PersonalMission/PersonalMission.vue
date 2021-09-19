<template>
  <div class="personal-mission">
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
      <el-table-column label="流程服务名称" align="center" prop="serviceName" />
      <el-table-column label="流程服务发起人" align="center" prop="startUserName" />
      <el-table-column label="流程名称" align="center" prop="processDefName" />
      <el-table-column label="流程总耗时" align="center" prop="totalTime" />
      <el-table-column label="流程实例状态" align="center" prop="processStatusName" />
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
            icon="el-icon-more-outline"
            @click="handleView(scope.row)"
          >处理</el-button>
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

    <el-dialog :title="dialogTitle" :visible.sync="viewOpen" width="900px" append-to-body>
      <div class="flow-view">
        <el-card class="form-card" style="min-height:600px;height:auto;" >
          <div class="flow-view-title mb10">
            表单信息
            <el-button style="float: right;" type="primary" @click="saveFormData">暂存表单</el-button>
          </div>
          <!--初始化流程加载表单信息-->
          <el-col :span="16" :offset="4" v-if="formConfOpen">
            <div class="test-form">
              <parser :key="new Date().getTime()"  :form-conf="formConf"  ref="parser" @getData="getFormDataList" />
            </div>
          </el-col>
        </el-card>
        <!-- <el-skeleton class="mb10" :rows="10" /> -->
        <el-card class="form-card" >
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
        </el-card>
      </div>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" class="mb10 btn" v-for="item in buttonList" :key="item.id" @click="handleButtons(item)">{{ item.buttonName }}</el-button>
        <!-- <el-button type="primary" @click="agreeAdvice">同 意</el-button>
        <el-button type="danger" @click="refuseAdvice">拒 绝</el-button> -->
      </div>
    </el-dialog>

    <el-dialog title="流程图" :visible.sync="processOpen" width="900px" append-to-body>
      <BpmnViewer :processInstanceId="modelProcessInstanceId" />
    </el-dialog>

    <HandleContent ref="HandleContent" :buttonCode="this.buttonCode" :taskId="this.adviceForm.taskId" :processInstanceId="this.adviceForm.processInstanceId" :title="dialogTitle" @off="viewClose" />
  </div>
</template>
<script>
import { getTableData, getFlowType, getTimelineList, getButton, getProcessImg } from '@/api/workmenu/personalmission'
import dict from './dict'
import HandleContent from '../components/handlecontent.vue'
import BpmnViewer from '@/components/package/bpmnViewer/index.vue'
export default {
  name: 'PersonalMission',
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
        processName: null,
        taskName: null,
        startTime: null,
        endTime: null,
      },
      total: 0,
      loading: true,
      personalMissionList: [],
      open: false,
      title: '',
      form: {},
      currentStep: 0,
      treeData: [],
      viewOpen: false,
      dialogTitle: '',
      timelineList: [],
      adviceForm: {
        message: null,
        processInstanceId: null,
        taskId: null,
      },
      buttonList: [],
      processOpen: false,
      processImg: '',
      // 处理弹窗内当前按钮的状态
      buttonCode: '',
      modelProcessInstanceId: '',
      formConf:'',
      formConfOpen: false, // 是否加载默认表单数据
    }
  },
  created() {
    this.getList();
  },
  methods: {
    onRangeChange(val) {
      this.queryParams.startTime = val[0]
      this.queryParams.endTime = val[1]
    },
    async getList() {
      this.loading = true;
      const { data, totalNum } = await getTableData(this.queryParams)
      this.personalMissionList = data;
      this.total = totalNum;
      this.loading = false;
    },
    handleQuery() {
      this.queryParams.pageIndex = 1;
      this.getList();
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
    async handleAdd() {
      this.$router.push({ path: 'homePageAdd'})

      // this.open = true;
      // this.title = "发起流程";
      // const { data } = await getFlowType()
      // this.treeData = this.handleTree(data)
    },
    saveFormData(procInsId) {

    },
    /** 接收子组件传的值 */
    getFormDataList(data) {
      if (data) {
        const variables = [];
        data.fields.forEach(item => {
          let variableData = {};
          variableData.label = item.__config__.label
          // 表单值为多个选项时
          if (item.__config__.defaultValue instanceof Array) {
            const array = [];
            item.__config__.defaultValue.forEach(val => {
              array.push(val)
            })
            variableData.val = array;
          } else {
            variableData.val = item.__config__.defaultValue
          }
          variables.push(variableData)
        })
        this.variables = variables;
      }
    },
    async handleView(row) {
      this.dialogTitle = row.taskName
      this.viewOpen = true
      const { data } = await getTimelineList(row.processInstId)
      const res = await getButton(row.taskId)
      this.adviceForm.processInstanceId = row.processInstId
      this.adviceForm.taskId = row.taskId
      this.timelineList = data || []
      this.buttonList = res.data
    },
    viewClose() {
      this.viewOpen = false
      this.getList();
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
        this.modelProcessInstanceId = row.processInstId
      })
      console.log(row)
    }
  },
}
</script>
<style lang="scss" scoped>
.flow-view {
  &-title {
    font-size: 16px;
    font-weight: bold;
  }
}
.btn {
  margin-top: 5px;
  margin-bottom: 5px;
}
</style>
