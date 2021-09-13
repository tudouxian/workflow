<!--
 * @Author: your name
 * @Date: 2021-07-26 11:11:06
 * @LastEditTime: 2021-09-02 14:57:54
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /flow-template-front/src/components/package/refactor/base/ElementBaseInfo.vue
-->
<template>
  <div class="panel-tab__content">
    <el-form size="mini" label-width="90px" @submit.native.prevent>
      <el-form-item label="ID">
        <el-input
          v-model="elementBaseInfo.id"
          :disabled="idEditDisabled || elementBaseInfo.$type === 'bpmn:Process'"
          clearable
          @change="updateBaseInfo('id')"
        />
      </el-form-item>
      <el-form-item label="名称">
        <el-input v-model="elementBaseInfo.name" clearable @change="updateBaseInfo('name')" />
      </el-form-item>
      <el-form-item label="跳过表达式" v-show="elementBaseInfo.$type !== 'bpmn:Process'">
        <el-input v-model="elementBaseInfo.skipExpression" clearable @change="updateBaseInfo('skipExpression')">
          <el-button slot="append" @click="openExpression" icon="el-icon-search"></el-button>
        </el-input>
      </el-form-item>
      <!--流程的基础属性-->
      <template v-if="elementBaseInfo.$type === 'bpmn:Process'">
        <!-- <el-form-item label="流程启动人">
          <el-input v-model="elementBaseInfo.versionTag" clearable @change="updateBaseInfo('initiator')" />
        </el-form-item>
        <el-form-item label="流程启动组">
          <el-input v-model="elementBaseInfo.versionTag" clearable @change="updateBaseInfo('startGroup')" />
        </el-form-item> -->
        <el-form-item label="可执行">
          <el-switch v-model="elementBaseInfo.isExecutable" active-text="是" inactive-text="否" @change="updateBaseInfo('isExecutable')" />
        </el-form-item>
      </template>
    </el-form>
    <!-- 表达式选择弹窗 -->
    <ExpressionDialog :open="expressionOpen" @close="expressionOpen=false" @submit="expressionSelectSubmit" />
  </div>
</template>
<script>
import ExpressionDialog from '../components/expression/expressionDialog.vue'

export default {
  name: "ElementBaseInfo",
  props: {
    businessObject: Object,
    type: String,
    idEditDisabled: {
      type: Boolean,
      default: true
    }
  },
  components:{ ExpressionDialog },
  data() {
    return {
      elementBaseInfo: {},
      expressionOpen: false,
    };
  },
  watch: {
    businessObject: {
      immediate: false,
      handler: function(val) {
        if (val) {
          this.$nextTick(() => this.resetBaseInfo());
        }
      }
    }
  },
  methods: {
    resetBaseInfo() {
      this.bpmnElement = window?.bpmnInstances?.bpmnElement;
      this.elementBaseInfo = JSON.parse(JSON.stringify(this.bpmnElement.businessObject));
    },
    updateBaseInfo(key) {
      const attrObj = Object.create(null);
      attrObj[key] = this.elementBaseInfo[key];
      if (key === "id") {
        window.bpmnInstances.modeling.updateProperties(this.bpmnElement, {
          id: this.elementBaseInfo[key],
          di: { id: `${this.elementBaseInfo[key]}_di` }
        });
      } else {
        window.bpmnInstances.modeling.updateProperties(this.bpmnElement, attrObj);
      }
    },
    openExpression () {
      // 开启表达式弹窗
      this.expressionOpen = true;
    },
    expressionSelectSubmit (obj) {
      this.expressionOpen = false;
      this.elementBaseInfo.skipExpression = obj.expressionValue;
      this.updateBaseInfo('skipExpression');
    }
  },
  beforeDestroy() {
    this.bpmnElement = null;
  }
};
</script>
