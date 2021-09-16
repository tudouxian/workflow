<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="租户KEY" prop="tennatId">
        <el-input
          v-model="queryParams.tennatId"
          placeholder="请输入租户KEY"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="名称" prop="tenantName">
          <el-input
            v-model="queryParams.tenantName"
            placeholder="请输入租户名称"
            clearable
            size="small"
            @keyup.enter.native="handleQuery"
          />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable size="small">
          <el-option label="上线" value="0" />
          <el-option label="下线" value="1" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['processmanager:processTenant:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['processmanager:processTenant:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['processmanager:processTenant:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['processmanager:processTenant:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="processTenantList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="主键" align="center" prop="id" />
      <el-table-column label="租户KEY" align="center" prop="tennatId" />
      <el-table-column label="租户名称" align="center" prop="tenantName" />
      <el-table-column label="状态" align="center" prop="status"  :formatter="formatterStatus"/>
      <el-table-column label="密钥" align="center" prop="secretKey" />
      <el-table-column label="系统首页路径" align="center" prop="url" />
      <el-table-column label="系统的图标" align="center" prop="image" >
        <template width="90" slot-scope="scope">
        <img :src="scope.row.image" height="30px" width="30px">
        </template>
      </el-table-column>
      <el-table-column label="系统备注" align="center" prop="note" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['processmanager:processTenant:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['processmanager:processTenant:remove']"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改租户管理对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="120px">
        <el-form-item label="租户KEY" prop="tennatId">
          <el-input v-model="form.tennatId" placeholder="请输入租户标示" />
        </el-form-item>
        <el-form-item label="名称" prop="tenantName">
          <el-input v-model="form.tenantName" placeholder="请填写名称">
          </el-input>
        </el-form-item>
        <el-form-item label="租户KEY" prop="tennatId">
          <el-input v-model="form.tennatId" placeholder="请输入系统标示" />
        </el-form-item>
        <el-form-item label="状态">
          <el-radio-group v-model="form.status">
            <el-radio :label="0">上线</el-radio>
            <el-radio :label="1">下线</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="密钥" prop="secretKey">
          <el-input v-model="form.secretKey" placeholder="请输入密钥" />
        </el-form-item>
        <el-form-item label="系统首页路径" prop="url">
          <el-input v-model="form.url" placeholder="请输入系统url前缀" />
        </el-form-item>
        <el-form-item label="系统的图标">
          <imageUpload v-model="form.image"/>
        </el-form-item>
        <el-form-item label="系统备注" prop="note">
          <el-input v-model="form.note" type="textarea" placeholder="请输入内容" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
  import { listProcessTenant, getProcessTenant, delProcessTenant, addProcessTenant, updateProcessTenant } from "@/api/processManagement/processTenant";
  import ImageUpload from '@/components/ImageUpload';
  import dict from "./dict";
  export default {
    name: "ProcessTenant",
    mixins: [dict],
    components: {
      ImageUpload,
    },
    data() {
      return {
        // 遮罩层
        loading: true,
        // 选中数组
        ids: [],
        // 非单个禁用
        single: true,
        // 非多个禁用
        multiple: true,
        // 显示搜索条件
        showSearch: true,
        // 总条数
        total: 0,
        // 租户管理表格数据
        processTenantList: [],
        // 弹出层标题
        title: "",
        // 是否显示弹出层
        open: false,
        // 名称字典
        tenantNameOptions: [],
        // 查询参数
        queryParams: {
          pageNum: 1,
          pageSize: 10,
          tennatId: null,
          tenantName: null,
          status: null,
          secretKey: null,
          url: null,
          image: null,
          note: null,
          creator: null,
        },
        // 表单参数
        form: {
          status: 0
        },
        // 表单校验
        rules: {
        }
      };
    },
    created() {
      this.getList();
      // this.getDicts("sys_show_hide").then(response => {
      //   this.tenantNameOptions = response.data;
      // });
    },
    methods: {
      /** 查询租户管理列表 */
      getList() {
        this.loading = true;
        this.queryParams.pageIndex = this.queryParams.pageNum
        listProcessTenant(this.queryParams).then(response => {
          this.processTenantList = response.data;
          this.total = response.totalNum;
          this.loading = false;
        });
      },
      // 名称字典翻译
      tenantNameFormat(row, column) {
        return this.selectDictLabel(this.tenantNameOptions, row.tenantName);
      },
      // 取消按钮
      cancel() {
        this.open = false;
        this.reset();
      },
      // 表单重置
      reset() {
        this.form = {
          id: null,
          tennatId: null,
          tenantName: null,
          status: 0,
          secretKey: null,
          url: null,
          image: null,
          note: null,
          createTime: null,
          creator: null,
          updateTime: null,
          updator: null,
          delFlag: null
        };
        this.resetForm("form");
      },
      /** 搜索按钮操作 */
      handleQuery() {
        this.queryParams.pageNum = 1;
        this.getList();
      },
      /** 重置按钮操作 */
      resetQuery() {
        this.resetForm("queryForm");
        this.handleQuery();
      },
      // 多选框选中数据
      handleSelectionChange(selection) {
        this.ids = selection.map(item => item.id)
        this.single = selection.length!==1
        this.multiple = !selection.length
      },
      /** 新增按钮操作 */
      handleAdd() {
        this.reset();
        this.open = true;
        this.title = "添加租户管理";
      },
      /** 修改按钮操作 */
      handleUpdate(row) {
        this.reset();
        const id = row.id || this.ids
        getProcessTenant(id).then(response => {
          this.form = response.data;
          this.open = true;
          this.title = "修改租户管理";
        });
      },
      /** 提交按钮 */
      submitForm() {
        this.$refs["form"].validate(valid => {
          if (valid) {
            if (this.form.id != null) {
              updateProcessTenant(this.form).then(response => {
                this.msgSuccess("修改成功");
                this.open = false;
                this.getList();
              });
            } else {
              addProcessTenant(this.form).then(response => {
                this.msgSuccess("新增成功");
                this.open = false;
                this.getList();
              });
            }
          }
        });
      },
      /** 删除按钮操作 */
      handleDelete(row) {
        const ids = row.id || this.ids;
        this.$confirm('是否确认删除租户管理编号为"' + ids + '"的数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return delProcessTenant(ids);
        }).then(() => {
          this.getList();
          this.msgSuccess("删除成功");
        }).catch(() => {});
      },
      /** 导出按钮操作 */
      handleExport() {
        this.download('processmanager/processTenant/export', {
          ...this.queryParams
        }, `processmanager_processTenant.xlsx`)
      }
    }
  };
</script>
