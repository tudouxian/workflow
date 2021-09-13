<!--
 * @Author: xueyan
 * @Date: 2021-07-20 15:25:44
 * @LastEditTime: 2021-07-26 09:57:29
 * @LastEditors: Please set LastEditors
 * @Description: 处理弹窗内，内容
 * @FilePath: /flow-template-front/src/views/workBench/homePage/components/handlecontent.vue
-->

<template>
  <div class="handlecontent">
    <el-dialog :title="title" :visible.sync="dialogVisible" width="600px" append-to-body>
      <!-- 任务指定驳回，驳回节点 -->
      <label v-if="buttonCode === '_flow_task_back_step'">请选择驳回节点：</label>
      <el-select v-model="adviceForm.distFlowElementId" filterable placeholder="请选择" v-if="buttonCode === '_flow_task_back_step'">
      <el-option
        v-for="item in stepOptions"
        :key="item.nodeId"
        :label="item.nodeName"
        :value="item.nodeId">
      </el-option>
    </el-select>
    <!-- 关于选人的下拉框 -->
    <div v-else-if="
          buttonCode === '_flow_task_turn' || 
          buttonCode === '_flow_task_delegate' ||
          buttonCode === '_flow_sign' ||
          buttonCode === '_flow_task_before_add_sign' ||
          buttonCode === '_flow_task_after_add_sign' ||
          buttonCode === '_flow_task_synergy'
        ">
      <label >请选择人员：</label>
      <el-select
        :multiple="buttonCode === '_flow_task_after_add_sign' || buttonCode === '_flow_task_before_add_sign' || buttonCode === '_flow_task_synergy'"
        v-model="adviceForm.userId"
        filterable
        remote
        reserve-keyword
        placeholder="请输入关键词"
        :remote-method="remoteMethod"
        :loading="loading">
        <el-option
          v-for="item in userList"
          :key="item.userId"
          :label="item.nickName"
          :value="item.userId">
        </el-option>
      </el-select>
    </div>
    <!-- 其他审核 -->
    <el-input
      v-else
      type="textarea"
      :rows="2"
      placeholder="请输入审核意见"
      v-model="adviceForm.message">
    </el-input>
    <span slot="footer" class="dialog-footer">
      <el-button @click="close">取 消</el-button>
      <el-button type="primary" :loading="btnloading" @click="ok">确 定</el-button>
    </span>
  </el-dialog>
    
  </div>
</template>

<script>
// deptName
import { getStepList, getUserList, handleActions } from '@/api/workmenu/handlecontent.js'
export default {
  props: ['buttonCode', 'taskId', 'processInstanceId', 'title', 'off'],
  name: 'handlecontent',
  data() {
    return {
      adviceForm: {},
      stepOptions: [],// 节点列表
      stepLoading: false,
      loading: false,
      btnloading: false,
      userList: [],
      dialogVisible: false,
      btnData: {}
    }
  },
  watch: {
    buttonCode (newVal, oldVal) {
      if (newVal === '_flow_task_back_step') {
        this.getStepList()
      } else if (
        newVal === '_flow_task_turn' || 
        newVal === '_flow_task_delegate' ||
        newVal === '_flow_sign' ||
        newVal === '_flow_task_before_add_sign' ||
        newVal === '_flow_task_after_add_sign'
      ) {
        this.remoteMethod()
      }
    }
  },
  methods: {
    async getStepList () {
      const { data } = await getStepList(this.processInstanceId, this.taskId)
      this.stepOptions = data
    },
    async remoteMethod (query) {
      if (query !== '') {
        let params = {
          nickName: query
        }
        this.loading = true
        const { data } = await getUserList(params)
        this.loading = false
        this.userList = data
      }
    },
    openDialog (btnData) {
      this.dialogVisible = true
      this.btnData = btnData
    },
    close () {
      this.adviceForm = {}
      this.dialogVisible = false
      this.btnloading = false
    },
    async ok () {
      // 处理数据
      let params = {
        processInstanceId: this.processInstanceId,
        taskId: this.taskId,
      }
      switch (this.buttonCode) {
        case '_flow_task_back_step':
          params.distFlowElementId = this.adviceForm.distFlowElementId
          break
        case '_flow_task_turn':
          params.turnToUserId = this.adviceForm.userId
          break
        case '_flow_task_delegate':
          params.delegateUserId = this.adviceForm.userId
          break
        case '_flow_sign':
          params.signUserId = this.adviceForm.userId
          break
        case '_flow_task_before_add_sign':
          params.signUserIds = this.adviceForm.userId
          break
        case '_flow_task_after_add_sign':
          params.signUserIds = this.adviceForm.userId
          break
        case '_flow_task_synergy':
          params.synergyUserIds = this.adviceForm.userId
        default:
          params.message = this.adviceForm.message
      }
      this.btnloading = true
      const res = await handleActions({
        url: this.btnData.requestUrl,
        params
      })
      this.btnloading = false
      if (res.success === true) {
        this.dialogVisible = false
        this.$message.success('操作成功！')
        this.$emit('off')
      }

    }
  }
}
</script>