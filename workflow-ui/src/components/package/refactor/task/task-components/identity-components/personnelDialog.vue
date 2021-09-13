<!--
 * @Author: xueyan
 * @Date: 2021-07-29 10:25:55
 * @LastEditTime: 2021-07-29 14:32:52
 * @LastEditors: Please set LastEditors
 * @Description: 人员选择弹窗
 * @FilePath: /flow-template-front/src/components/package/refactor/task/task-components/identity-components/personnelDialog.vue
-->
<template>
  <div class="personnel-dialog">
    <el-dialog
      title="人员选择"
      :visible.sync="dialogVisible"
      width="800px"
      :before-close="handleClose">
      <div class="selected">
        <el-tag closable>标签一</el-tag>
      </div>
      <el-row :gutter="20">
        <el-col :span="6">
          <el-input placeholder="请输入"></el-input>
          <el-tree class="tree" :data="treeData" :props="defaultProps" @node-click="handleNodeClick"></el-tree>
        </el-col>
        <el-col :span="18">
           <el-input placeholder="请输入内容">
            <el-button slot="append" icon="el-icon-search"></el-button>
          </el-input>
          <el-table :data="tableData" :height="500" tooltip-effect="dark" ref="multipleTable" @selection-change="handleSelectionChange">
            <el-table-column prop="type" label="姓名"></el-table-column>
            <el-table-column prop="date" label="工号"></el-table-column>
            <el-table-column prop="date" label="手机"></el-table-column>
            <el-table-column prop="date" label="组织"></el-table-column>
          </el-table>
          <pagination
            v-show="total>0"
            :total="total"
            :page.sync="queryParams.pageNum"
            :limit.sync="queryParams.pageSize"
            @pagination="getList"
          />
        </el-col>
      </el-row>
      <span slot="footer" class="dialog-footer">
        <el-button @click="handleClose">取 消</el-button>
        <el-button type="primary" @click="handleClose">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>
<script>
export default {
  name: 'personnelDialog',
  props: {
    dialogVisible: Boolean
  },
  data () {
    return {
      treeData: [{
        label: '一级 1',
        children: [{
          label: '二级 1-1',
          children: [{
            label: '三级 1-1-1'
          }]
        }]
      }, {
        label: '一级 2',
        children: [{
          label: '二级 2-1',
          children: [{
            label: '三级 2-1-1'
          }]
        }, {
          label: '二级 2-2',
          children: [{
            label: '三级 2-2-1'
          }]
        }]
      }, {
        label: '一级 3',
        children: [{
          label: '二级 3-1',
          children: [{
            label: '三级 3-1-1'
          }]
        }, {
          label: '二级 3-2',
          children: [{
            label: '三级 3-2-1'
          }]
        }]
      }],
      defaultProps: {
        children: 'children',
        label: 'label'
      },
      tableData: [],
      multipleSelection: [],
      // 查询参数
      total: 0,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        buttonName: null,
        buttonCode: null,
        buttonType: null,
        systemButton: null,
      },
    }
  },
  methods: {
    getList () {},
    handleNodeClick(data) {
      console.log(data);
    },
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    // 关闭弹窗前回调
    handleClose() {
      this.$emit('close')
    },
  }
}
</script>
<style lang="scss" scoped>
.selected {
  border-radius: 4px;
  border: 1px dotted #999;
  padding: 5px;
  margin-bottom: 5px;
}

</style>