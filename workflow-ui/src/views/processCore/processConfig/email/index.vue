<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="租户" prop="tenantId">
        <el-select v-model="queryParams.tenantId" placeholder="请选择租户" clearable size="small">
          <el-option v-for="item in dict.tenant" :key="item.value" :label="item.name" :value="item.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="邮箱服务" prop="mailServerHost">
        <el-input
          v-model="queryParams.mailServerHost"
          placeholder="请输入邮箱服务eg:smtp.163.com"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
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
          v-hasPermi="['email:email:add']"
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
          v-hasPermi="['email:email:edit']"
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
          v-hasPermi="['email:email:remove']"
        >删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="emailList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="主键" align="center" prop="id" />
      <el-table-column label="租户" align="center" prop="tenantId" :formatter="formatterTenantId" />
      <el-table-column label="邮箱服务" align="center" prop="mailServerHost" />
      <el-table-column label="端口" align="center" prop="mailServerPort" />
      <el-table-column label="默认发送邮箱" align="center" prop="mailDefaultFrom" />
      <el-table-column label="账号" align="center" prop="mailUsername" />
      <el-table-column label="密码" align="center" prop="mailPassword" />
      <el-table-column label="是否使用SSL" align="center" prop="mailSsl" />
      <el-table-column label="邮箱备注" align="center" prop="note" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['email:email:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['email:email:remove']"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageIndex"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改租户邮箱配置对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="租户" prop="tenantId">
          <el-select v-model="form.tenantId" placeholder="租户">
            <el-option v-for="item in dict.tenant" :key="item.value" :label="item.name" :value="item.value"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="邮箱服务" prop="mailServerHost">
          <el-input v-model="form.mailServerHost" placeholder="请输入邮箱服务eg:smtp.163.com" />
        </el-form-item>
        <el-form-item label="端口" prop="mailServerPort">
          <el-input v-model="form.mailServerPort" placeholder="请输入邮箱服务端口eg:465" />
        </el-form-item>
        <el-form-item label="默认发送邮箱" prop="mailDefaultFrom">
          <el-input v-model="form.mailDefaultFrom" placeholder="请输入邮箱服务默认发送邮箱" />
        </el-form-item>
        <el-form-item label="账号" prop="mailUsername">
          <el-input v-model="form.mailUsername" placeholder="请输入邮箱服务账号" />
        </el-form-item>
        <el-form-item label="密码" prop="mailPassword">
          <el-input v-model="form.mailPassword" placeholder="请输入邮箱服务密码" />
        </el-form-item>
        <el-form-item label="是否使用SSL" prop="mailSsl">
          <el-select v-model="form.mailSsl" placeholder="请选择是否使用SSL" >
            <el-option label="是" value="1" />
            <el-option label="否" value="0" />
          </el-select>
        </el-form-item>
        <el-form-item label="邮箱备注" prop="note">
          <el-input v-model="form.note" placeholder="请输入邮箱备注" />
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
import { listEmail, getEmail, delEmail, addEmail, updateEmail, exportEmail } from "@/api/processManagement/email";
import dict from "./dict";

export default {
  name: "Email",
  mixins: [dict],
  data() {
    return {
      // 遮罩层
      loading: true,
      // 导出遮罩层
      exportLoading: false,
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
      // 租户邮箱配置表格数据
      emailList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        tenantId: null,
        mailServerHost: null,
        mailServerPort: null,
        mailDefaultFrom: null,
        mailUsername: null,
        mailPassword: null,
        mailSsl: null,
        note: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        tenantId: [
          { required: true, message: "租户选择不能为空", trigger: "blur" }
        ],
        mailServerHost: [
          { required: true, message: "邮箱服务不能为空", trigger: "blur" }
        ],
        mailServerPort: [
          { required: true, message: "邮箱服务端口不能为空", trigger: "blur" }
        ],
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询租户邮箱配置列表 */
    getList() {
      this.loading = true;
      listEmail(this.queryParams).then(response => {
        this.emailList = response.data;
        this.total = response.totalNum;
        this.loading = false;
      });
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
        tenantId: null,
        mailServerHost: null,
        mailServerPort: null,
        mailDefaultFrom: null,
        mailUsername: null,
        mailPassword: null,
        mailSsl: null,
        note: null,
        creator: null,
        createTime: null,
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
      this.title = "添加租户邮箱配置";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getEmail(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改租户邮箱配置";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateEmail(this.form).then(response => {
              this.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addEmail(this.form).then(response => {
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
      this.$confirm('是否确认删除租户邮箱配置编号为"' + ids + '"的数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return delEmail(ids);
        }).then(() => {
          this.getList();
          this.msgSuccess("删除成功");
        }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      const queryParams = this.queryParams;
      this.$confirm('是否确认导出所有租户邮箱配置数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(() => {
          this.exportLoading = true;
          return exportEmail(queryParams);
        }).then(response => {
          this.download(response.msg);
          this.exportLoading = false;
        }).catch(() => {});
    }
  }
};
</script>
