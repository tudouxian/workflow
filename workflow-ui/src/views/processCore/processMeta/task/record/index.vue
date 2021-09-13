<template>
  <div class="app-container">
        <el-card class="box-card" >
              <div slot="header" class="clearfix">
                <span class="el-icon-document">基础信息</span>
                <el-button style="float: right;" type="primary" @click="goBack">返回</el-button>
              </div>


            <el-col :span="16" :offset="6" v-if="variableOpen">
              <!--申请流程初始化表单模块-->
              <div>
                <parser :key="new Date().getTime()" :form-conf="variablesData" />
              </div>

              <!--审批流程模块-->
              <div style="margin-left:20px;margin-bottom: 20px;font-size: 14px;" v-if="finished === 'true'">
                <el-form ref="taskForm" :model="taskForm" label-width="80px" size="mini">
                  <el-form-item label="退回节点" prop="targetKey" v-show="taskForm.returnTaskShow">
                    <el-radio-group v-model="taskForm.targetKey">
                      <<el-radio-button
                        v-for="item in returnTaskList"
                        :key="item.id"
                        :label="item.id"
                      >{{item.name}}</el-radio-button>
                    </el-radio-group>
                  </el-form-item>
                  <el-form-item label="任务接收" prop="targetKey" v-show="taskForm.sendUserShow">
                    <el-select style="width: 50%" v-model="assignee" @change="handleCheckChange" :multiple="taskForm.multiple" placeholder="请选择">
                      <el-option
                        v-for="item in userDataList"
                        :key="item.userId"
                        :label="item.nickName"
                        :value="item.userId">
                      </el-option>
                    </el-select>
                  </el-form-item>
                  <el-form-item label="审批意见" prop="comment" :rules="[{ required: true, message: '请输入意见', trigger: 'blur' }]">
                    <el-input style="width: 50%" type="textarea" v-model="taskForm.comment" placeholder="请输入意见"/>
                  </el-form-item>
                  <el-form-item>
                    <div  v-show="taskForm.defaultTaskShow">
                      <el-button  icon="el-icon-edit-outline" type="success" size="mini" @click="handleComplete">审批</el-button>
                      <el-button  icon="el-icon-edit-outline" type="primary" size="mini" @click="handleDelegate">委派</el-button>
                      <el-button  icon="el-icon-edit-outline" type="primary" size="mini" @click="handleAssign">转办</el-button>
                      <el-button  icon="el-icon-edit-outline" type="primary" size="mini" @click="handleDelegate">签收</el-button>
                      <el-button  icon="el-icon-refresh-left" type="warning" size="mini" @click="handleReturn">退回</el-button>
                      <el-button  icon="el-icon-circle-close" type="danger" size="mini" @click="handleReject">驳回</el-button>
                    </div>
                    <div v-show="taskForm.returnTaskShow">
                      <el-button type="primary" @click="submitReturnTask">确 定</el-button>
                      <el-button @click="cancelTask">取 消</el-button>
                    </div>
                    <div v-show="taskForm.delegateTaskShow">
                      <el-button type="primary" @click="submitDeleteTask">确 定</el-button>
                      <el-button @click="cancelDelegateTask">取 消</el-button>
                    </div>
                  </el-form-item>
                </el-form>
              </div>
            </el-col>

            <!--初始化流程加载表单信息-->
            <el-col :span="16" :offset="4" v-if="formConfOpen">
              <div class="test-form">
                <parser :key="new Date().getTime()"  :form-conf="formConf" @submit="submitForm" ref="parser" @getData="getData" />
              </div>
            </el-col>
        </el-card>

      <!--流程流转记录-->
       <el-card class="box-card" v-if="flowRecordList">
          <div slot="header" class="clearfix">
            <span class="el-icon-notebook-1">审批记录</span>
          </div>
          <el-col :span="16" :offset="4" >
            <div class="block">
              <el-timeline>
                <el-timeline-item
                  v-for="(item,index ) in flowRecordList"
                  :key="index"
                  :icon="setIcon(item.finishTime)"
                  :color="setColor(item.finishTime)"
                >
                  <p style="font-weight: 700">{{item.taskName}}</p>
                  <el-card :body-style="{ padding: '10px' }">
                    <label v-if="item.assigneeName" style="font-weight: normal;margin-right: 30px;">实际办理： {{item.assigneeName}} <el-tag type="info" size="mini">{{item.deptName}}</el-tag></label>
                    <label v-if="item.candidate" style="font-weight: normal;margin-right: 30px;">候选办理： {{item.candidate}}</label>
                    <label style="font-weight: normal">接收时间： </label><label style="color:#8a909c;font-weight: normal">{{item.createTime}}</label>
                    <label v-if="item.finishTime" style="margin-left: 30px;font-weight: normal">办结时间： </label><label style="color:#8a909c;font-weight: normal">{{item.finishTime}}</label>
                    <label v-if="item.duration" style="margin-left: 30px;font-weight: normal">耗时： </label><label style="color:#8a909c;font-weight: normal">{{item.duration}}</label>

                    <p  v-if="item.comment">
                      <el-tag type="success" v-if="item.comment.type === '1'">  {{item.comment.comment}}</el-tag>
                      <el-tag type="warning" v-if="item.comment.type === '2'">  {{item.comment.comment}}</el-tag>
                      <el-tag type="danger" v-if="item.comment.type === '3'">  {{item.comment.comment}}</el-tag>
                    </p>
                  </el-card>
                </el-timeline-item>
              </el-timeline>
            </div>
          </el-col>
      </el-card>

      <!--流程执行图-->
<!--      <el-card class="box-card" v-if="src" >-->
<!--        <div slot="header" class="clearfix">-->
<!--          <span class="el-icon-picture-outline">流程图</span>-->
<!--        </div>-->
<!--        <el-col :span="16" :offset="4">-->
<!--          <el-image :src="src"></el-image>-->
<!--        </el-col>-->
<!--      </el-card>-->
    <el-card class="box-card">
        <div slot="header" class="clearfix">
          <span class="el-icon-picture-outline">流程图</span>
        </div>
        <flow :xmlData="xmlData" :taskData="taskList"></flow>
    </el-card>
  </div>
</template>

<script>
import Parser from '@/components/parser/Parser'
import {definitionStart, getProcessVariables, userList, readXml, getFlowViewer } from "@/api/processCenter/definition";
import flow from '@/views/processCore/processMeta/task/record/flow'
export default {
  name: "Record",
  components: {
    Parser,
    flow
  },
  props: {},
  data() {
    return {
      // 模型xml数据
      xmlData: "",
      taskList: [],
      // // 任务列表
      // taskList: [{
      //   // 任务定义的key
      //   "key": "Activity_0gtu56i",
      //   // 任务是否完成
      //   "completed": false
      // },
      //   {
      //     // 任务定义的key
      //     "key": "Activity_02fkd13",
      //     // 任务是否完成
      //     "completed": true
      //   }],
      // 遮罩层
      loading: true,
      flowRecordList: [], // 流程流转数据
      formConfCopy: {},
      src: null,
      rules: {}, // 表单校验
      variablesForm: {}, // 流程变量数据
      taskForm:{
        returnTaskShow: false, // 是否展示回退表单
        delegateTaskShow: false, // 是否展示回退表单
        defaultTaskShow: true, // 默认处理
        sendUserShow: false, // 审批用户
        multiple: false,
        comment:"", // 意见内容
        procInsId: "", // 流程实例编号
        instanceId: "", // 流程实例编号
        deployId: "",  // 流程定义编号
        taskId: "" ,// 流程任务编号
        procDefId: "",  // 流程编号
        vars: "",
        targetKey:""
      },
      userDataList:[], // 流程候选人
      assignee: null,
      formConf: {}, // 默认表单数据
      formConfOpen: false, // 是否加载默认表单数据
      variables: [], // 流程变量数据
      variablesData: {}, // 流程变量数据
      variableOpen: false, // 是否加载流程变量数据
      returnTaskList: [],  // 回退列表数据
      finished: 'false'
    };
  },
  created() {
    this.taskForm.deployId = this.$route.query && this.$route.query.deployId;
    this.taskForm.taskId  = this.$route.query && this.$route.query.taskId;
    this.taskForm.procInsId = this.$route.query && this.$route.query.procInsId;
    this.taskForm.instanceId = this.$route.query && this.$route.query.procInsId;
    // 初始化表单
    this.taskForm.procDefId  = this.$route.query && this.$route.query.procDefId;
    // 回显流程记录
    this.getFlowViewer(this.taskForm.procInsId);
    this.getModelDetail(this.taskForm.deployId);
    // 流程任务重获取变量表单
    if (this.taskForm.taskId){
      this.processVariables( this.taskForm.taskId)
      this.taskForm.deployId = null
    }
    this.getFlowRecordList( this.taskForm.procInsId, this.taskForm.deployId);
    this.finished =  this.$route.query && this.$route.query.finished

  },
  mounted() {
    // // 表单数据回填，模拟异步请求场景
    // setTimeout(() => {
    //   // 请求回来的表单数据
    //   const data = {
    //     field102: '18836662555'
    //   }
    //   // 回填数据
    //   this.fillFormData(this.formConf, data)
    //   // 更新表单
    //   this.key = +new Date().getTime()
    // }, 1000)
  },
  methods: {
    /** xml 文件 */
    getModelDetail(deployId) {
      // 发送请求，获取xml
      readXml(deployId).then(res =>{
        this.xmlData = res.data
      })
    },
    getFlowViewer(procInsId){
      getFlowViewer(procInsId).then(res =>{
        this.taskList = res.data
      })
    },
    setIcon(val) {
      if (val) {
        return "el-icon-check";
      } else {
        return "el-icon-time";
      }
    },
    setColor(val) {
      if (val) {
        return "#2bc418";
      } else {
        return "#b3bdbb";
      }
    },
    /** 流程变量赋值 */
    handleCheckChange(val){
      if (val instanceof Array) {
        this.taskForm.values = {
          "approval": val.join(',')
        }
      }else {
        this.taskForm.values = {
          "approval": val
        }
      }
    },
    fillFormData(form, data) {
      form.fields.forEach(item => {
        const val = data[item.__vModel__]
        if (val) {
          item.__config__.defaultValue = val
        }
      })
    },
    /** 获取流程变量内容 */
    processVariables(taskId) {
      if (taskId) {
        // 提交流程申请时填写的表单存入了流程变量中后续任务处理时需要展示
        getProcessVariables(taskId).then(res => {
          // this.variables = res.data.variables;
          this.variablesData = res.data.variables;
          this.variableOpen = true
        });
      }
    },

    handleAssign(){

    },
    /** 返回页面 */
    goBack() {
      // 关闭当前标签页并返回上个页面
      this.$store.dispatch("tagsView/delView", this.$route);
      this.$router.go(-1)
    },
    /** 接收子组件传的值 */
    getData(data) {
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
  }
};
</script>
<style lang="scss" scoped>
.test-form {
  margin: 15px auto;
  width: 800px;
  padding: 15px;
}

.clearfix:before,
.clearfix:after {
  display: table;
  content: "";
}
.clearfix:after {
  clear: both
}

.box-card {
  width: 100%;
  margin-bottom: 20px;
}
</style>
