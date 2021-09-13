<!--
 * @Author: your name
 * @Date: 2021-07-26 11:11:06
 * @LastEditTime: 2021-09-02 14:06:14
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /flow-template-front/src/components/package/refactor/task/task-components/UserTask.vue
-->
<template>
  <div style="margin: 16px 0">
    <!-- <el-form-item label="处理用户">
      <el-select v-model="userTaskForm.assignee" @change="updateElementTask('assignee')">
        <el-option v-for="ak in mockData" :key="'ass-' + ak" :label="`用户${ak}`" :value="`user${ak}`" />
      </el-select>
    </el-form-item>
    <el-form-item label="候选用户">
      <el-select v-model="userTaskForm.candidateUsers" multiple collapse-tags @change="updateElementTask('candidateUsers')">
        <el-option v-for="uk in mockData" :key="'user-' + uk" :label="`用户${uk}`" :value="`user${uk}`" />
      </el-select>
    </el-form-item>
    <el-form-item label="候选分组">
      <el-select v-model="userTaskForm.candidateGroups" multiple collapse-tags @change="updateElementTask('candidateGroups')">
        <el-option v-for="gk in mockData" :key="'ass-' + gk" :label="`分组${gk}`" :value="`group${gk}`" />
      </el-select>
    </el-form-item>
    <el-form-item label="到期时间">
      <el-input v-model="userTaskForm.dueDate" clearable @change="updateElementTask('dueDate')" />
    </el-form-item>
    <el-form-item label="跟踪时间">
      <el-input v-model="userTaskForm.followUpDate" clearable @change="updateElementTask('followUpDate')" />
    </el-form-item>
    <el-form-item label="优先级">
      <el-input v-model="userTaskForm.priority" clearable @change="updateElementTask('priority')" />
    </el-form-item> -->

      <el-tabs tab-position="left" v-model="assigneeType" :before-leave="tabsChange">
        <el-tab-pane label="固定值" name="0">
          <el-form-item label="分配人员">
            <el-input placeholder="请输入内容" v-model="userTaskForm.assigneeStr" @input="assigneeInput" clearable class="input-with-select">
              <el-button slot="append" icon="el-icon-search" @click="clickAssignee"></el-button>
            </el-input>
          </el-form-item>
          <el-form-item label="候选人员">
            <el-tag :key="index" v-for="(tag, index) in userTaskForm.candidateUsers" closable :disable-transitions="false" @close="handleClose(tag)">
              {{tag}}
            </el-tag>
            <el-input
              class="input-new-tag"
              v-if="inputVisible"
              v-model="inputValue"
              ref="saveTagInput"
              size="small"
              @keyup.enter.native="handleInputConfirm"
            >
              <el-button slot="append" @click="openExpression('inputValue')" icon="el-icon-search"></el-button>
            </el-input>
            <el-button v-else class="button-new-tag" size="small" @click="showInput">添加</el-button>
          </el-form-item>

          <el-form-item label="候选分组">
            <el-tag :key="index" v-for="(tag, index) in userTaskForm.candidateGroups" closable :disable-transitions="false" @close="handleCloseRole(tag)">
              {{tag}}
            </el-tag>
            <el-input
              class="input-new-tag"
              v-if="inputVisibleRole"
              v-model="inputValueRole"
              ref="saveTagInputRole"
              size="small"
              @keyup.enter.native="handleInputConfirmRole"
            >
              <el-button slot="append" @click="openExpression('inputValueRole')" icon="el-icon-search"></el-button>
            </el-input>
            <el-button v-else class="button-new-tag" size="small" @click="showInputRole">添加</el-button>
          </el-form-item>
          
        </el-tab-pane>
        <el-tab-pane label="身份存储" name="1">
          <el-form-item label="分配">
            <el-select v-model="allocationType" @change="allocationTypeChange">
              <el-option :label="`分配给单个人`" value="1" />
              <el-option :label="`候选人员`" value="2" />
              <el-option :label="`分配给流程发起人`" value="3" />
            </el-select>
          </el-form-item>
          <el-form-item 
            v-if="allocationType !== '3'"
            :label="
              allocationType === '1' ? '分配人员' :
              allocationType === '2' ? '候选人员' : ''
            ">
            <!-- <el-button size="mini" @click="selectPersonnel">请选择人员</el-button> -->
            <el-input v-if="allocationType === '1'" placeholder="请输入内容" @input="assigneeInput" v-model="userTaskForm.assigneeStr" class="input-with-select">
              <el-button slot="append" icon="el-icon-search" @click="clickAssignee"></el-button>
            </el-input>
            <el-input v-if="allocationType === '2'" placeholder="请点击选择" disabled v-model="userTaskForm.candidateUsersStr" class="input-with-select">
              <el-button slot="append" icon="el-icon-search" @click="selectPersonnel"></el-button>
            </el-input>
          </el-form-item>
          <el-form-item label="候选分组">
            <el-tag :key="index" v-for="(tag, index) in idmCandidateGroups" :disable-transitions="false">
              {{tag}}
            </el-tag>
            <el-button size="mini" @click="seleleRole">请选择候选角色</el-button>
          </el-form-item>
        </el-tab-pane>
      </el-tabs>
      <!-- 变量选择弹窗 -->
      <VariableDialog :dialogVisible="assigneeDialog" @close="VariableDialogClose" @ok="VariableDialogOk" />
      <!-- 身份存储，人员选择 -->
      <PersonnelDialog :dialogVisible="selectPersonnelDialog" @close="personnelDialogClose" />
      <!-- 身份存储，角色选择 -->
      <RoleDialog :dialogVisible="selectRoleDialog" :tags="this.userTaskForm.candidateGroups" :viewTags="this.idmCandidateGroups" @close="RoleDialogClose" @ok="RoleDialogOk" />
      <!-- 表达式选择弹窗 -->
      <ExpressionDialog :open="expressionOpen" @close="expressionOpen=false" @submit="expressionSelectSubmit" />
  </div>
</template>

<script>
import VariableDialog from './fixed-components/variableDialog.vue'
import PersonnelDialog from './identity-components/personnelDialog.vue'
import RoleDialog from './identity-components/roleDialog.vue'
import ExpressionDialog from '../../components/expression/expressionDialog.vue'

// import { updateElementExtensions, updateElementExecutionListener, getElementExecutionListener } from '../../../utils'
import { updateElementExecutionListener, getElementExecutionListener } from '../elementUtils';
export default {
  name: "UserTask",
  props: {
    id: String,
    type: String
  },
  components: {
    VariableDialog,
    PersonnelDialog,
    RoleDialog,
    ExpressionDialog
  },
  data() {
    return {
      defaultTaskForm: {
        assignee: [],// 分配人员
        assigneeStr: '',
        candidateUsers: [],// 候选人员
        candidateUsersStr: '',
        candidateGroups: [],// 候选分
      },
      userTaskForm: {
        assignee: [],// 分配人员
        assigneeStr: '',
        candidateUsers: [],// 候选人员
        candidateUsersStr: '',
        candidateGroups: [],// 候选分
      },
      
      assigneeType: '0', // tabIndex
      idmAssignee: [], // 分配人员
      idmCandidateUsers: [], // 候选人员
      idmCandidateGroups: [], // 分组
      allocationType: '1',
      
      
      mockData: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
      inputVisible: false,
      inputValue: '',
      inputVisibleRole: false,
      inputValueRole: '',
      assigneeDialog: false,
      selectPersonnelDialog: false,
      selectRoleDialog: false,
      expressionOpen: false,
      inputIsRole: false
    };
  },
  watch: {
    id: {
      immediate: true,
      handler(val) {
        if (val) {
          this.bpmnElement = window.bpmnInstances.bpmnElement;
          console.log(this.bpmnElement);
          this.userTaskForm = {
            // ...this.bpmnElement?.businessObject,
            assignee: [],
            assigneeStr: '',
            candidateUsers: [],
            candidateUsersStr: '',
            candidateGroups: []
          }
          this.bpmnElement?.businessObject?.assignee instanceof Array ? (
            this.userTaskForm.assignee = this.bpmnElement?.businessObject?.assignee,
            this.userTaskForm.assigneeStr = this.bpmnElement?.businessObject?.assignee.join(',')
          ) : (
            this.userTaskForm.assignee = this.bpmnElement?.businessObject?.assignee?.split(',') ?? [],
            this.userTaskForm.assigneeStr = this.bpmnElement?.businessObject?.assignee
          )
          this.bpmnElement?.businessObject?.candidateUsers instanceof Array ? 
            this.userTaskForm.candidateUsers = this.bpmnElement?.businessObject?.candidateUsers : 
            this.userTaskForm.candidateUsers = this.bpmnElement?.businessObject?.candidateUsers?.split(',') ?? []
          this.bpmnElement?.businessObject?.candidateGroups instanceof Array ? 
            this.userTaskForm.candidateGroups = this.bpmnElement?.businessObject?.candidateGroups :
            this.userTaskForm.candidateGroups = this.bpmnElement?.businessObject?.candidateGroups?.split(',') ?? []
          
          // if (!this.userTaskForm.candidateUsers) {
          //   this.userTaskForm.candidateUsers = [];
          // }
          // if (!this.userTaskForm.candidateGroups) {
          //   this.userTaskForm.candidateGroups = []; 
          // }
          let idmAssigneeStr = getElementExecutionListener(this.bpmnElement, 'IdmAssignee') || ''
          this.idmAssignee = idmAssigneeStr && JSON.parse(idmAssigneeStr) || [],
          this.assigneeType = getElementExecutionListener(this.bpmnElement, 'AssigneeType') || '0'
          this.allocationType = getElementExecutionListener(this.bpmnElement, 'AllocationType') || '1'
          let idmCandidateUsersStr = getElementExecutionListener(this.bpmnElement, 'IdmCandidateUsers') || ''
          this.idmCandidateUsers = idmCandidateUsersStr && JSON.parse(idmCandidateUsersStr) || []

          let idmCandidateGroupsStr = getElementExecutionListener(this.bpmnElement, 'IdmCandidateGroups')
          this.idmCandidateGroups = idmCandidateGroupsStr ? JSON.parse(idmCandidateGroupsStr) : []
          if (this.allocationType === '1' && this.assigneeType === '1') {
            this.userTaskForm.assigneeStr = this.idmAssignee.map((item) => {
              return item.nickName
            }).join(',')
          }
          this.userTaskForm.candidateUsersStr = this.idmCandidateUsers.map((item) => {
            return item.nickName
          }).join(',')
          console.log('userTaskForm', this.bpmnElement)
          console.log(this.userTaskForm)
          // this.$nextTick(() => this.resetTaskForm());
        }
        
      }
    }
  },
  methods: {
    // tabs切换前的钩子
    tabsChange (index) {
      console.log('切换', index);
      if (index.toString() === this.assigneeType) {
        return;
      }
      return new Promise((resolve, reject) => {
        this.$confirm('此操作将清除已选的数据, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          resolve()
          this.assigneeType = index
          this.moveData()

          updateElementExecutionListener(this.bpmnElement, this.assigneeType, 'AssigneeType')
          this.$nextTick(() => {
            console.log('获取的呢', getElementExecutionListener(this.bpmnElement, 'AssigneeType'));
          })
          
        }).catch(() => {
          reject()
        })
      })
      
    },
    moveData () {
      this.userTaskForm = {
        ...this.userTaskForm,
        assignee: [],// 分配人员
        candidateUsers: [],// 候选人员
        candidateGroups: [],// 候选分组
        assigneeStr: '',
        candidateUsersStr: '',
        candidateGroups: []
      }
      this.idmAssignee = []
      this.idmCandidateUsers = []
      this.idmCandidateGroups = []
      this.updateElementTask('assignee');
      this.updateElementTask('candidateUsers');
      this.updateElementTask('candidateGroups');
      updateElementExecutionListener(this.bpmnElement, JSON.stringify(this.idmAssignee), 'IdmAssignee');
      updateElementExecutionListener(this.bpmnElement, JSON.stringify(this.idmCandidateUsers), 'IdmCandidateUsers');
      updateElementExecutionListener(this.bpmnElement, JSON.stringify(this.idmCandidateGroups), 'IdmCandidateGroups');

      this.$store.commit('DEL_VARIABLESELECT_ALL')
      this.$store.commit('DEL_VARIABLESELECTUSERID_ALL')
    },
    resetTaskForm() {
      for (let key in this.defaultTaskForm) {
        let value;
        if (key === "candidateUsers" || key === "candidateGroups") {
          value = this.bpmnElement?.businessObject[key] ? this.bpmnElement.businessObject[key].split(",") : [];
        } else {
          value = this.bpmnElement?.businessObject[key] || this.defaultTaskForm[key];
        }
        this.$set(this.userTaskForm, key, value);
      }

    },
    updateElementTask(key) {
      let taskAttr = Object.create(null);
      if (key === "candidateUsers" || key === "candidateGroups") {
        taskAttr[key] = this.userTaskForm[key] && this.userTaskForm[key].length ? this.userTaskForm[key].join() : null;
      } else {
        taskAttr[key] = this.userTaskForm[key] || null;
      }
      console.log('taskAttr', taskAttr)
      window.bpmnInstances.modeling.updateProperties(this.bpmnElement, taskAttr);
    },
    // 候选人员
    handleClose(tag) {
      this.userTaskForm.candidateUsers.splice(this.userTaskForm.candidateUsers.indexOf(tag), 1);
      this.updateElementTask('candidateUsers');
    },
    showInput() {
      this.inputVisible = true;
      this.$nextTick(_ => {
        this.$refs.saveTagInput.$refs.input.focus();
      });
    },
    handleInputConfirm() {
      let inputValue = this.inputValue;
      if (inputValue) {
        this.userTaskForm.candidateUsers.push(inputValue);
      }
      this.inputVisible = false;
      this.inputValue = '';
      this.updateElementTask('candidateUsers');
    },

    // 候选角色
    handleCloseRole(tag) {
      this.userTaskForm.candidateGroups.splice(this.userTaskForm.candidateGroups.indexOf(tag), 1);
      this.updateElementTask('candidateGroups');
      this.idmCandidateGroups = [...this.userTaskForm.candidateGroups]
      updateElementExecutionListener(this.bpmnElement, JSON.stringify(this.idmCandidateGroups), 'IdmCandidateGroups')

    },
    showInputRole() {
      this.inputVisibleRole = true;
      this.$nextTick(_ => {
        this.$refs.saveTagInputRole.$refs.input.focus();
      });
    },
    handleInputConfirmRole() {
      let inputValueRole = this.inputValueRole;
      if (inputValueRole) {
        this.userTaskForm.candidateGroups.push(inputValueRole);
      }
      this.inputVisibleRole = false;
      this.inputValueRole = '';
      this.updateElementTask('candidateGroups');

      this.idmCandidateGroups = [...this.userTaskForm.candidateGroups];
      updateElementExecutionListener(this.bpmnElement, JSON.stringify(this.idmCandidateGroups), 'IdmCandidateGroups')
      
    },
    // 点击分配人员
    clickAssignee () {
      this.$store.commit('SET_ISMULTIPLE', false)
      let listStr = getElementExecutionListener(this.bpmnElement, 'IdmAssignee')
      let list = listStr ? JSON.parse(listStr) : []
      console.log('list', list);
      this.$store.commit('SET_VARIABLESELECT', list)
      console.log('assignee', Boolean(this.userTaskForm.assignee))
      this.userTaskForm.assignee.length && this.$store.commit('SET_VARIABLESELECTUSERID', this.userTaskForm.assignee)
      this.idmAssignee && this.$store.commit('SET_VARIABLESELECT', this.idmAssignee);
      this.assigneeDialog = true;
    },
    VariableDialogClose () {
      this.assigneeDialog = false;
    },
    // 分配、候选人员选中了
    VariableDialogOk (list) {
      // 分配人员
      if (this.assigneeType === '0' || this.allocationType === '1') {
        this.userTaskForm.assignee = this.$store.getters.modelSelect.variableSelectUserId
        this.idmAssignee = this.$store.getters.modelSelect.variableSelect
        if (this.assigneeType === '0') {
          this.userTaskForm.assigneeStr = this.userTaskForm.assignee.join(',')
        } else {
          this.userTaskForm.assigneeStr = this.idmAssignee.map((item) => {
            return item.nickName
          }).join(',')
        }
        this.updateElementTask('assignee');
        updateElementExecutionListener(this.bpmnElement, JSON.stringify(this.idmAssignee), 'IdmAssignee')
          
      } else {
        // 候选人员
        this.userTaskForm.candidateUsers = this.$store.getters.modelSelect.variableSelectUserId
        this.idmCandidateUsers = this.$store.getters.modelSelect.variableSelect
        this.userTaskForm.candidateUsersStr = this.idmCandidateUsers.map((item) => {
          return item.nickName
        }).join(',')
        this.updateElementTask('candidateUsers');
        updateElementExecutionListener(this.bpmnElement, JSON.stringify(this.idmCandidateUsers), 'IdmCandidateUsers')
      }

      this.VariableDialogClose();
    },
    // 切换分配
    allocationTypeChange (index) {
      this.userTaskForm.assignee = []
      this.userTaskForm.assigneeStr = ''
      this.idmAssignee = [];
      if (index === '3') {
        this.userTaskForm.assignee = ['${initiator}']
      }
      this.updateElementTask('assignee');
      updateElementExecutionListener(this.bpmnElement, JSON.stringify(this.idmAssignee), 'IdmAssignee')

      this.userTaskForm.candidateUsers = []
      this.userTaskForm.candidateUsersStr = ''
      this.updateElementTask('candidateUsers');
      this.idmCandidateUsers = [];
      updateElementExecutionListener(this.bpmnElement, JSON.stringify(this.idmCandidateUsers), 'IdmCandidateUsers')
      
      

      updateElementExecutionListener(this.bpmnElement, index.toString(), 'AllocationType')
    },
    // 身份存储，人员选择
    selectPersonnel () {
      this.$store.commit('SET_ISMULTIPLE', true)
      let listStr = getElementExecutionListener(this.bpmnElement, 'IdmCandidateUsers')
      let list = listStr ? JSON.parse(listStr) : []
      this.$store.commit('SET_VARIABLESELECT', list)
      
      this.userTaskForm.candidateUsers && this.$store.commit('SET_VARIABLESELECTUSERID', this.userTaskForm.candidateUsers)

      this.assigneeDialog = true;
      // this.selectPersonnelDialog = true;
    },
    personnelDialogClose () {
      this.assigneeDialog = false;
      // this.selectPersonnelDialog = false;
    },
    seleleRole () {
      !this.userTaskForm.candidateGroups.length && (this.userTaskForm.candidateGroups = this.bpmnElement?.businessObject?.candidateGroups?.join(',') ?? [])
      let listStr = getElementExecutionListener(this.bpmnElement, 'IdmCandidateGroups');
      this.idmCandidateGroups = listStr ? JSON.parse(listStr) : []
      console.log(this.userTaskForm.candidateGroups, this.idmCandidateGroups)
      
      this.selectRoleDialog = true;
    },
    RoleDialogOk (tagList, viewTagList) {
      this.userTaskForm.candidateGroups = tagList;
      this.idmCandidateGroups = viewTagList;
      this.updateElementTask('candidateGroups');
      updateElementExecutionListener(this.bpmnElement, JSON.stringify(this.idmCandidateGroups), 'IdmCandidateGroups');

      this.RoleDialogClose();
    },
    RoleDialogClose () {
      this.selectRoleDialog = false;
    },
    // 分配人员手动输入
    assigneeInput (val) {
      this.userTaskForm.assignee = [val];
      this.idmAssignee = [];
      this.userTaskForm.assigneeStr = val;
      this.updateElementTask('assignee');
      updateElementExecutionListener(this.bpmnElement, JSON.stringify(this.idmAssignee), 'IdmAssignee')
    },
    openExpression (field) {
      // 开启表达式弹窗
      this.expressionOpen = true;
      field === 'inputValueRole' ? this.inputIsRole = true : this.inputIsRole = false
    },
    expressionSelectSubmit (obj) {
      this.expressionOpen = false;
      this.inputIsRole ? this.inputValueRole = obj.expressionValue : this.inputValue = obj.expressionValue
    }
  },
  beforeDestroy() {
    this.bpmnElement = null;
  }
};
</script>
<style scoped>
  .el-tag + .el-tag {
    margin-left: 10px;
  }
  .button-new-tag {
    margin-left: 10px;
    height: 32px;
    line-height: 30px;
    padding-top: 0;
    padding-bottom: 0;
  }
  .input-new-tag {
    width: 180px;
    margin-left: 10px;
    vertical-align: bottom;
  }
</style>
