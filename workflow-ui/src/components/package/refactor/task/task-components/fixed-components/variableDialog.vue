<!--
 * @Author: xueyan
 * @Date: 2021-07-28 14:30:28
 * @LastEditTime: 2021-08-10 13:51:51
 * @LastEditors: Please set LastEditors
 * @Description: 变量选择弹窗
 * @FilePath: /flow-template-front/src/components/package/refactor/task/task-components/variableDialog.vue
-->
<template>
  <div class="variableDialog">
    <el-dialog
      title="变量选择"
      :close-on-click-modal="false"
      :visible.sync="dialogVisible"
      width="1200px"
      :before-close="handleClose">
      <div class="dialog-body">
        <div class="selected">
          <el-tag v-for="(item, index) in $store.getters.modelSelect.variableSelect" :key="index" closable @close="tagClose(item)">{{item.nickName}}</el-tag>
        </div>
        <el-tabs v-model="activeName" @tab-click="handleClick">
          <el-tab-pane label="公司" name="1">
            <TableCompany ref="TableCompany" />
          </el-tab-pane>
          <el-tab-pane label="部门" name="2">
            <TableDepartment ref="TableDepartment" />
          </el-tab-pane>
          <el-tab-pane label="角色" name="3">
            <TableRole ref="TableRole" />
          </el-tab-pane>
          <el-tab-pane label="矩阵" name="4">
            <TableCompanyMatrix ref="TableCompanyMatrix" />
          </el-tab-pane>
        </el-tabs>
      </div>
      

      <span slot="footer" class="dialog-footer">
        <el-button @click="handleClose">取 消</el-button>
        <el-button type="primary" @click="handleOk">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>
<script>
import TableRole from './tableRole.vue'
import TableCompanyMatrix from './tableCompanyMatrix.vue'
import TableCompany from './tableCompany.vue'
import TableDepartment from './tableDepartment.vue'
export default {
  name: 'variableDialog',
  props: ['dialogVisible'],
  components: {
    TableRole,
    TableCompanyMatrix,
    TableCompany,
    TableDepartment
  },
  data() {
    return {
      activeName: '2'
    }
  },
  watch: {
    dialogVisible (newVal, oldVal) {
      newVal && this.$nextTick(() => {
        this.$refs.TableDepartment.getDeptTree()
      })
    }
  },
  methods: {
    // 关闭弹窗前回调
    handleClose() {
      this.$emit('close')
      this.remove()
    },
    handleOk() {
      this.$emit('ok', this.$store.getters.modelSelect.variableSelect);
    },
    // 清除vuex里的缓存
    remove () {
      this.$store.commit('DEL_VARIABLESELECT_ALL')
      this.$store.commit('DEL_VARIABLESELECTUSERID_ALL')
    },
    handleClick(tab, event) {
      console.log(tab, event);
      switch (tab.index) {
        case "1":
          this.$refs.TableDepartment.getDeptTree()
          this.$refs.TableDepartment.setSelectState()
          break
        case "2":
          this.$refs.TableRole.getRoleTree()
          this.$refs.TableRole.setSelectState()
          break;
        case "3":
          this.$refs.TableCompanyMatrix.getData()
          break;
        default: {
          this.msgInfo('暂未开放')
        }
      }
    },
    tagClose (tag) {
      this.$store.commit('DEL_VARIABLESELECT', tag);
      this.$store.commit('DEL_VARIABLESELECTUSERID', tag.userId);
    }
    
  }
}
</script>
<style lang="scss" scoped>
.selected {
  border-radius: 4px;
  border: 1px dotted #999;
  padding: 5px;
  min-height: 40px;
}
.dialog-body {
  min-height: 676px;
}
</style>

<style lang="scss">
.variableDialog {
  .pagination-container {
    height: 30px;
  }
}
</style>