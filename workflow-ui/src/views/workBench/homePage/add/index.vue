<!--
 * @Author: xueyan
 * @Date: 2021-07-22 16:17:00
 * @LastEditTime: 2021-08-12 11:18:23
 * @LastEditors: Please set LastEditors
 * @Description: 发起流程
 * @FilePath: /flow-template-front/src/views/workBench/homePage/add/add.vue
-->

<template>
  <div class="app-container homePage-add">
    <el-page-header @back="goBack" content="发起流程"></el-page-header>
    <div style="height: 50px"></div>
    <el-row :gutter="20">
      <el-col :span="6">
        <el-tree :data="treeData" :props="defaultProps" @node-click="handleNodeClick"></el-tree>
      </el-col>
      <el-col :span="18">
        <div v-for="item in tableList" :key="item.id" class="card">
          <el-card class="box-card">
            <el-row>
              <el-col :span="4">
                <img :src="item.iconUrl" height="30px" width="30px">
              </el-col>
              <el-col :span="20">
                <span class="serviceName">{{ item.serviceName }}</span>
              </el-col>
            </el-row>
            <el-row style="margin-top: 15px">
              <span class="button" @click="apply(item)">立即申请</span>
              <span class="button" @click="guide(item)">申请指南</span>
              <span class="button" @click="commonly(item)">常用</span>
            </el-row>
          </el-card>
        </div>
        <!-- <el-table
          v-loading="loading"
          :data="tableList"
          row-key="categoryCode"
        >
        <el-table-column label="服务名" align="center">
          <template slot-scope="scope">
            <img :src="scope.row.iconUrl" height="50px">
            <span style="margin-left: 10px">{{ scope.row.serviceName }}</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
          <template slot-scope="scope">
            <el-button
              size="mini"
              type="text"
              icon="el-icon-view"
              @click="apply(scope.row)"
            >立即申请</el-button>
            <el-button
              size="mini"
              type="text"
              icon="el-icon-guide"
              @click="guide(scope.row)"
            >申请指南</el-button>
            <el-button
              size="mini"
              type="text"
              icon="el-icon-guide"
              @click="commonly(scope.row)"
            >常用</el-button>
          </template>
        </el-table-column>
      </el-table> -->

      </el-col>
    </el-row>

  </div>
</template>

<script>
import { getTreeByCateGroyName, listAllServiceUnderCategory, startProcessService } from '@/api/workmenu/add'
export default {
  data() {
    return {
      treeData: [],
      defaultProps: {
        children: 'children',
        label: 'categoryName'
      },
      loading: false,
      tableList: []
    }
  },
  created() {
    this.getTreeData()
  },
  methods: {
    async getTreeData (categoryName) {
      let params = {
        categoryName
      }
      const {data} = await getTreeByCateGroyName(params)
      this.treeData = data
    },
    async handleNodeClick(item) {
      let data = {
        serviceCategoryId: item.id
      }
      this.loading = true
      const res = await listAllServiceUnderCategory(data)
      this.loading = false
      this.tableList = res.data
      console.log(data);
      console.log(res);
    },
    // 申请
    async apply (row) {

      this.$confirm('确定启动该服务吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning',
        beforeClose: async (action, instance, done) => {
          if (action === 'confirm') {
            instance.confirmButtonLoading = true;
            instance.confirmButtonText = '执行中...';
            let data = {
              serviceID: row.id
            }
            const res = await startProcessService(data)
            if (res.success) {
              done();
              instance.confirmButtonLoading = false;
              this.msgSuccess("操作成功！");
            }
          } else {
            done();
            instance.confirmButtonLoading = false;
          }
        }
      });
    },
    // 指南
    guide () {
      this.$message({
        showClose: true,
        message: '开发中...',
        type: 'warning'
      });
    },
    // 常用
    commonly () {
      this.$message({
        showClose: true,
        message: '开发中...',
        type: 'warning'
      });
    },
    goBack() {
      window.history.back(-1);
    }
  }
}
</script>
<style lang="scss" scoped>
.card {
  display: inline-flex;
  justify-content: flex-start;
  margin-right: 20px;
  margin-bottom: 10px;
  width: 30%;
  .box-card {
    width: 100%;
  }
}
.serviceName {
  margin-left: 10px;
  line-height: 30px;
  font-size: 20px;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  // display: inline;
  -webkit-line-clamp: 1;
  -webkit-box-orient: vertical;
}
.button {
  color: #409EFF;
  margin-right: 10px;
  cursor:pointer;
}

</style>
