<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="110px">
      <el-form-item label="类型" prop="type">
        <el-input
          v-model="queryParams.type"
          placeholder="请输入类型"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="名称" prop="name">
        <el-input
          v-model="queryParams.name"
          placeholder="请输入名称"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="流程执行实例ID" prop="executionId">
        <el-input
          v-model="queryParams.executionId"
          placeholder="请输入流程执行实例ID"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="流程实例ID" prop="procInstId">
        <el-input
          v-model="queryParams.procInstId"
          placeholder="请输入流程实例ID"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="任务ID" prop="taskId">
        <el-input
          v-model="queryParams.taskId"
          placeholder="请输入任务ID"
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
          v-hasPermi="['processmanager:ruVariable:remove']"
        >删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="ruVariableList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="主键" align="center" prop="id" />
      <el-table-column label="流程实例ID" align="center" prop="procInstId" />
      <el-table-column label="流程执行实例ID" align="center" prop="executionId" />
      <el-table-column label="任务ID" align="center" prop="taskId" />
      <!--<el-table-column label="字节表ID" align="center" prop="bytearrayId" />-->
     <!-- <el-table-column label="作用域" align="center" prop="scopeId" />
      <el-table-column label="子作用域" align="center" prop="subScopeId" />
      <el-table-column label="作用域类型" align="center" prop="scopeType" />-->
      <el-table-column label="变量名称" align="center" prop="name" />
      <el-table-column label="变量类型" align="center" prop="type" />
      <el-table-column label="变量值" align="center" prop="variableValue" />
      <!--<el-table-column label="存储值double类型" align="center" prop="double_" />
      <el-table-column label="存储值long类型" align="center" prop="long_" />
      <el-table-column label="存储值字符串类型" align="center" prop="text" />
      <el-table-column label="存储值字符串类型2" align="center" prop="text2" />-->
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['processmanager:ruVariable:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['processmanager:ruVariable:remove']"
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

    <!-- 添加或修改运行时变量信息对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="140px">
        <el-form-item label="流程执行实例ID" prop="executionId">
          <el-input v-model="form.executionId" placeholder="请输入流程执行实例ID" />
        </el-form-item>
        <el-form-item label="流程实例ID" prop="procInstId">
          <el-input v-model="form.procInstId" placeholder="请输入流程实例ID" />
        </el-form-item>
        <el-form-item label="任务ID" prop="taskId">
          <el-input v-model="form.taskId" placeholder="请输入任务ID" />
        </el-form-item>
        <el-form-item label="变量名称" prop="name">
          <el-input v-model="form.name" placeholder="请输入名称" />
        </el-form-item>
        <el-form-item label="变量类型" prop="type">
          <el-input v-model="form.type" placeholder="请输入类型" />
        </el-form-item>
        <el-form-item label="存储值double类型" prop="double_">
          <el-input v-model="form.double_" placeholder="请输入存储值double类型" />
        </el-form-item>
        <el-form-item label="存储值long类型" prop="long_">
          <el-input v-model="form.long_" placeholder="请输入存储值long类型" />
        </el-form-item>
        <el-form-item label="存储值字符串类型" prop="text">
          <el-input v-model="form.text" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="存储值字符串类型2" prop="text2">
          <el-input v-model="form.text2" type="textarea" placeholder="请输入内容" />
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
import { listRuVariable, getRuVariable, delRuVariable, addRuVariable, updateRuVariable } from "@/api/processCenter/variable";

export default {
  name: "Variable",
  components: {
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
      // 运行时变量信息表格数据
      ruVariableList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageIndex: 1,
        pageSize: 10,
        rev: null,
        type: null,
        name: null,
        executionId: null,
        procInstId: null,
        taskId: null,
        scopeId: null,
        subScopeId: null,
        scopeType: null,
        bytearrayId: null,
        double_: null,
        long_: null,
        text: null,
        text2: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        type: [
          { required: true, message: "变量类型不能为空", trigger: "blur" }
        ],
        name: [
          { required: true, message: "变量名称不能为空", trigger: "blur" }
        ],
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询运行时变量信息列表 */
    getList() {
      this.loading = true;
      listRuVariable(this.queryParams).then(response => {
        this.ruVariableList = response.rows;
        this.total = response.total;
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
        rev: null,
        type: null,
        name: null,
        executionId: null,
        procInstId: null,
        taskId: null,
        scopeId: null,
        subScopeId: null,
        scopeType: null,
        bytearrayId: null,
        double_: null,
        long_: null,
        text: null,
        text2: null
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
      this.title = "添加运行时变量信息";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getRuVariable(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改运行时变量信息";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateRuVariable(this.form).then(response => {
              this.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addRuVariable(this.form).then(response => {
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
      this.$confirm('是否确认删除运行时变量信息编号为"' + ids + '"的数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return delRuVariable(ids);
        }).then(() => {
          this.getList();
          this.msgSuccess("删除成功");
        }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('processmanager/ruVariable/export', {
        ...this.queryParams
      }, `processmanager_ruVariable.xlsx`)
    }
  }
};
</script>
