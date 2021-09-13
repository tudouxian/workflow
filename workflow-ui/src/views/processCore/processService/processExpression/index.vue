<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="90px">
      <el-form-item label="表达式名称" prop="expressionName">
        <el-input
          v-model="queryParams.expressionName"
          placeholder="请输入表达式名称"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="表达式内容" prop="expressionValue">
        <el-input
          v-model="queryParams.expressionValue"
          placeholder="请输入表达式内容"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="系统预设表达式" prop="systemExpression">
        <el-select v-model="queryParams.systemExpression" placeholder="请选择系统预设表达式" clearable size="small">
          <el-option v-for="item in dict.systemExpression" :key="item.value" :label="item.label" :value="item.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="描述信息" prop="desc">
        <el-input
          v-model="queryParams.desc"
          placeholder="请输入描述信息"
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
          v-hasPermi="['processmanager:processExpression:add']"
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
          v-hasPermi="['processmanager:processExpression:edit']"
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
          v-hasPermi="['processmanager:processExpression:remove']"
        >删除</el-button>
      </el-col>
      <!-- <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['processmanager:processExpression:export']"
        >导出</el-button> -->
     <!-- </el-col>-->
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="processExpressionList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="主键id" align="center" prop="id" />
      <el-table-column label="表达式名称" align="center" prop="expressionName" />
      <el-table-column label="表达式内容" align="center" prop="expressionValue" />
      <el-table-column label="系统预设表达式" align="center" prop="systemExpression" :formatter="formatterSystemExpression" />
      <el-table-column label="描述信息" align="center" prop="desc" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['processmanager:processExpression:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['processmanager:processExpression:remove']"
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

    <!-- 添加或修改流程达式对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="表达式名称" prop="expressionName">
          <el-input v-model="form.expressionName" placeholder="请输入表达式名称" />
        </el-form-item>
        <el-form-item label="表达式内容" prop="expressionValue">
          <el-input v-model="form.expressionValue" placeholder="请输入表达式内容" />
        </el-form-item>
        <el-form-item label="系统预设表达式" prop="systemExpression">
          <el-select v-model="form.systemExpression" placeholder="请选择系统预设表达式">
            <el-option v-for="item in dict.systemExpression" :key="item.value" :label="item.label" :value="item.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="描述信息" prop="desc">
          <el-input v-model="form.desc" placeholder="请输入描述信息" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" :loading="submitLoading" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listProcessExpression, getProcessExpression, delProcessExpression, addProcessExpression, updateProcessExpression } from "@/api/processManagement/processExpression";
import dict from './dict'

export default {
  name: "ProcessExpression",
  components: {
  },
  mixins: [dict],
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
      // 流程达式表格数据
      processExpressionList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageIndex: 1,
        pageSize: 10,
        expressionName: null,
        expressionValue: null,
        systemExpression: null,
        desc: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        expressionName: [
          { required: true, message: '请输入表达式名称', trigger: 'blur' }
        ],
        expressionValue: [
          { required: true, message: '请输入表达式内容', trigger: 'blur' }
        ],
        systemExpression: [
          { required: true, message: '请选择系统预设表达式', trigger: 'blur' }
        ],
        desc: [
          { required: true, message: '请输入描述信息', trigger: 'blur' }
        ]
      },
      submitLoading: false
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询流程达式列表 */
    getList() {
      this.loading = true;
      listProcessExpression(this.queryParams).then(response => {
        this.processExpressionList = response.data;
        this.total = response.totalNum;
        this.loading = false;
      });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
      this.submitLoading = false;
    },
    // 表单重置
    reset() {
      this.form = {
        id: null,
        expressionName: null,
        expressionValue: null,
        systemExpression: null,
        desc: null,
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
      this.queryParams.pageIndex = 1;
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
      this.title = "添加流程达式";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getProcessExpression(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改流程达式";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          this.submitLoading = true;
          if (this.form.id != null) {
            updateProcessExpression(this.form).then(response => {
            this.submitLoading = false;
              this.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addProcessExpression(this.form).then(response => {
              this.submitLoading = false;
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
      const ids = row.id ? [row.id] : this.ids;
      this.$confirm('是否确认删除流程达式编号为"' + ids + '"的数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return delProcessExpression(ids);
        }).then(() => {
          this.getList();
          this.msgSuccess("删除成功");
        }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('processExpression/export', {
        ...this.queryParams
      }, `pprocessExpression.xlsx`)
    }
  }
};
</script>
