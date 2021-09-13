<!--
 * @Author: your name
 * @Date: 2021-07-29 14:26:30
 * @LastEditTime: 2021-07-29 14:40:26
 * @LastEditors: Please set LastEditors
 * @Description: 普通角色
 * @FilePath: /flow-template-front/src/components/package/refactor/task/task-components/identity-components/tableCommonly.vue
-->
<template>
  <div class="identity-table-commonly">
    <el-row  :gutter="20">
      <el-col :span="6">
        <el-input placeholder="请输入"></el-input>
        <el-tree class="tree" :data="treeData" :props="defaultProps" @node-click="handleNodeClick"></el-tree>
      </el-col>
      <el-col :span="18">
        <el-input placeholder="请输入内容">
          <el-button slot="append" icon="el-icon-search"></el-button>
        </el-input>
        <el-table :data="tableData" :height="500" tooltip-effect="dark" ref="multipleTable" @selection-change="handleSelectionChange">
          <el-table-column prop="type" label="名称"></el-table-column>
          <el-table-column prop="date" label="变量名"></el-table-column>
          <el-table-column prop="date" label="人员"></el-table-column>
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
  </div>
</template>
<script>
export default {
  name: 'identityTableCommonly',
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
    }
  }
}
</script>

<style lang="scss">
.identity-table-commonly {
  .tree {
    overflow: scroll;
  }
}
</style>