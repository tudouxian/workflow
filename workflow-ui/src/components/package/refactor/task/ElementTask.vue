<!--
 * @Author: xueyan
 * @Date: 2021-07-26 11:11:06
 * @LastEditTime: 2021-08-10 15:51:42
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /flow-template-front/src/components/package/refactor/task/ElementTask.vue
-->
<template>
  <div class="panel-tab__content">
    <el-form size="mini" label-width="90px" @submit.native.prevent>
      <el-form-item label="异步延续">
        <el-checkbox v-model="taskConfigForm.async" label="异步" @change="changeTaskAsync" />
      </el-form-item>
      <component :is="witchTaskComponent" v-bind="$props" />
      <!-- 后期可能加这两个字段，js逻辑没有加 -->
      <!-- <el-row :gutter="24" class="el-form-item el-form-item--mini">
        <el-col :span="12">
          <el-form-item label="节点类型">
            <el-select v-model="taskConfigForm.nodeType">
              <el-option v-for="item in typeList" :key="item.id" :label="item.label" :value="item.value" />
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="可编辑">
            <el-switch v-model="taskConfigForm.isEdit"></el-switch>
          </el-form-item> 
        </el-col>
      </el-row> -->
      
      <el-form-item label="到期时间">
        <!-- dueDate -->
        <el-button @click="dateClick">{{taskConfigForm.dueDate || '请选择到期时间'}}</el-button>
      </el-form-item>
      <el-form-item label="优先级">
         <el-input-number v-model="taskConfigForm.priority" @change="priorityChange" :min="1" :max="20" label="描述文字"></el-input-number>
      </el-form-item>
    </el-form>

    <DateDialog :dialogVisible="dateDialogVisible" @close="dateDialogClose" @ok="dateDialogOk" />
  </div>
</template>

<script>
import UserTask from "./task-components/UserTask";
import ScriptTask from "./task-components/ScriptTask";
import ReceiveTask from "./task-components/ReceiveTask";

import DateDialog from "./task-components/dateDialog.vue";

export default {
  name: "ElementTaskConfig",
  components: { UserTask, ScriptTask, ReceiveTask, DateDialog },
  props: {
    id: String,
    type: String
  },
  data() {
    return {
      taskConfigForm: {
        async: false,
        // nodeType: '',
        // isEdit: false,
        priority: 1,
        dueDate: ''
      },
      witchTaskComponent: "",
      installedComponent: {
        // 手工任务与普通任务一致，不需要其他配置
        // 接收消息任务，需要在全局下插入新的消息实例，并在该节点下的 messageRef 属性绑定该实例
        // 发送任务、服务任务、业务规则任务共用一个相同配置
        UserTask: "UserTask", // 用户任务配置
        ScriptTask: "ScriptTask", // 脚本任务配置
        ReceiveTask: "ReceiveTask" // 消息接收任务
      },
      // typeList: [
      //   {id: 1, value: 1, label: '普通'},
      //   {id: 2, value: 2, label: '必审'},
      //   {id: 3, value: 3, label: '评审'},
      //   {id: 4, value: 4, label: '协同'},
      //   {id: 5, value: 5, label: '不审'},
      //   {id: 6, value: 6, label: '审批中'}
      // ]
      dateDialogVisible: false
    };
  },
  watch: {
    id: {
      immediate: true,
      handler() {
        this.bpmnElement = window.bpmnInstances.bpmnElement;
        this.taskConfigForm.async = this.bpmnElement?.businessObject?.async;
        this.taskConfigForm.priority = this.bpmnElement?.businessObject?.priority;
        this.taskConfigForm.dueDate = this.bpmnElement?.businessObject?.dueDate;
      }
    },
    type: {
      immediate: true,
      handler() {
        this.witchTaskComponent = this.installedComponent[this.type];
      }
    }
  },
  methods: {
    changeTaskAsync() {
      this.updateElementTask('async')

      // window.bpmnInstances.modeling.updateProperties(window.bpmnInstances.bpmnElement, {
      //   ...this.taskConfigForm
      // });
    },
    priorityChange() {
      this.updateElementTask('priority')
      // window.bpmnInstances.modeling.updateProperties('priority');
      // console.log(value);
    },
    updateElementTask(key) {
      let taskAttr = Object.create(null);
      taskAttr[key] = this.taskConfigForm[key] || null;
      window.bpmnInstances.modeling.updateProperties(this.bpmnElement, taskAttr);
    },
    dateClick () {
      // 选择到期时间
      this.dateDialogVisible = true;
    },
    dateDialogClose () {
      this.dateDialogVisible = false;
    },
    dateDialogOk (date) {
      this.dateDialogClose()
      console.log(date);
      if (date) {
        this.taskConfigForm.dueDate = date;
        this.updateElementTask('dueDate')
      }
    }
  }
};
</script>
