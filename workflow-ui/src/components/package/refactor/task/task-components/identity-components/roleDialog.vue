<!--
 * @Author: xueyan
 * @Date: 2021-07-29 14:16:30
 * @LastEditTime: 2021-08-20 11:49:18
 * @LastEditors: Please set LastEditors
 * @Description: 角色选择
 * @FilePath: /flow-template-front/src/components/package/refactor/task/task-components/identity-components/roleDialog.vue
-->

<template>
  <div class="role-dialog">
    <el-dialog
      title="角色选择"
      :close-on-click-modal="false"
      :visible.sync="dialogVisible"
      width="800px"
      :before-close="handleClose">
      <div class="tag-selected">
        <el-tag closable v-for="(item, index) in viewTagList" :key="index" @close="tagHandleClose(item, index)">{{item}}</el-tag>
      </div>
      <!-- <el-tabs v-model="activeName" @tab-click="handleClick">
        <el-tab-pane label="普通角色" name="1">
          <TableCommonly />
        </el-tab-pane>
        <el-tab-pane label="矩阵公司角色" name="2">
          <TableCompanyMatrix />
        </el-tab-pane>
        <el-tab-pane label="矩阵部门角色" name="3">
          111
        </el-tab-pane>
      </el-tabs> -->

      <el-row :gutter="20">
        <el-col :span="8">
          <label>区域
            <el-cascader
              class="el-select"
              v-model="areaValue"
              @change="areaChange"
              :options="areaList"
              :props="{ checkStrictly: true, emitPath:false, label:'areaName', value:'areaKey' }"
              clearable></el-cascader>
          </label>
        </el-col>
        <el-col :span="8">
          <label>部门
            <el-cascader
              class="el-select"
              v-model="deptValue"
              @change="deptChange"
              :options="deptList"
              :props="{ checkStrictly:true, emitPath:false, label:'deptName', value:'deptKey' }"
              clearable></el-cascader>
          </label>
        </el-col>
        <el-col :span="8">
          <label>
            角色
            <el-select v-model="roleValue" @change="roleChange" clearable placeholder="请选择">
              <el-option
                v-for="(item, index) in roleList"
                :key="index"
                :label="item.roleName"
                :value="item.roleKey">
              </el-option>
            </el-select>
          </label>
        </el-col>
      </el-row>
      <div class="add-btn">
        <el-button type="primary" @click="pushData" plain>添加</el-button>
      </div>

      <span slot="footer" class="dialog-footer">
        <el-button @click="handleClose">取 消</el-button>
        <el-button type="primary" @click="handleOk">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>
<script>
// import TableCommonly from "./tableCommonly.vue";
// import TableCompanyMatrix from "./tableCompanyMatrix.vue";
import { getDeptTree, getRoleList, getAreaList } from '@/api/processCenter/model.js'
export default {
  name: 'roleDialog',
  props: {
    dialogVisible: Boolean,
    tags: Array,
    viewTags: Array
  },
  components: {
  },
  data () {
    return {
      // activeName: '1',
      areaList: [],
      deptList: [],
      roleList: [],
      areaValue: '',
      deptValue: '',
      roleValue: '',
      tagList: [], // 最终提交的
      viewTagList: [],// 显示使用
      areaName: '',
      deptName: '',
      roleName: '',
    }
  },
  watch: {
    dialogVisible (newVal, oldVal) {
      if (newVal) {
        this.getAreaList();
        this.getDeptList();
        this.getRoleList();
        this.tagList = [...this.tags] || [];
        this.viewTagList = [...this.viewTags] || [];
      }
    }
  },
  methods: {
    // 获取区域
    async getAreaList () {
      const { data } = await getAreaList();
      this.areaList = data;
    },
    // 获取部门
    async getDeptList () {
      const { data } = await getDeptTree();
      this.deptList = data;
    },
    // 获取角色
    async getRoleList () {
      const { data } = await getRoleList({pageIndex: 1, pageSize: 500});
      this.roleList = data;
    },
    // 关闭弹窗前回调
    handleClose () {
      this.tagList = [];
      this.areaValue = '';
      this.deptValue = '';
      this.roleValue = '';
      this.$emit('close');
    },
    handleOk () {
      this.$emit('ok', this.tagList, this.viewTagList);
    },
    // handleClick(tab, event) {
    //   console.log(tab, event);
    // },
    areaChange (data) {
      let area = this.findTreeData(this.areaList ,data, 'areaKey')
      this.areaName = area.length ? area[0].areaName : ''
    },
    deptChange (data) {
      console.log(data);
      let dept = this.findTreeData(this.deptList ,data, 'deptKey')
      console.log('dept', dept);
      this.deptName = dept.length ? dept[0].deptName : ''
    },
    roleChange (value) {
      this.roleName = this.roleList.filter((item) => {
        return item.roleKey === value
      })[0]?.roleName
    },
    // 查找tree里的数据
    findTreeData (treeList, key, keyName) {
      let selectData;
      let find = (list) => {
        return list.filter(item => {
          return item[keyName] === key
        })
      }

      let loop = (list) => {
        for (let iterator of list) {
          let findList = find(list);
          if (findList?.length) {
            selectData = findList;
            return findList
          } else if (iterator?.children?.length) {
            loop(iterator.children)
          }
        }
      }
      loop(treeList);
      return selectData
    },
    pushData () {
      this.tagList.push(`${this.areaValue}+${this.deptValue}+${this.roleValue}`)
      this.areaValue = '';
      this.roleValue = '';
      this.deptValue = '';

      this.viewTagList.push(`${this.areaName}|${this.deptName}|${this.roleName}`)

    },
    // 关闭标签
    tagHandleClose(tag, index) {
      this.viewTagList.splice(index, 1);
      this.tagList.splice(index, 1)
    },

  }
}
</script>
<style lang="scss" scoped>
.tag-selected {
  border-radius: 4px;
  border: 1px dotted #999;
  padding: 5px;
  min-height: 40px;
}
.add-btn {
  margin-top: 20px;
  text-align: center;
}

</style>
