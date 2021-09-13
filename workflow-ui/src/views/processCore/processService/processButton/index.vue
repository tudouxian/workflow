<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="按钮名称" prop="buttonName">
        <el-input
          v-model="queryParams.buttonName"
          placeholder="请输入按钮名称"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="按钮编码" prop="buttonCode">
        <el-input
          v-model="queryParams.buttonCode"
          placeholder="请输入按钮编码"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="按钮类型" prop="buttonType">
        <el-select v-model="queryParams.buttonType" placeholder="请选择按钮类型" clearable size="small">
          <el-option label="请选择字典生成" value="" />
        </el-select>
      </el-form-item>
      <el-form-item label="系统预设按钮" prop="systemButton">
        <el-select v-model="queryParams.systemButton" placeholder="请选择系统预设按钮" clearable size="small">
          <el-option label="请选择字典生成" value="" />
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
          v-hasPermi="['processmanager:processButton:add']"
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
          v-hasPermi="['processmanager:processButton:edit']"
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
          v-hasPermi="['processmanager:processButton:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['processmanager:processButton:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="processButtonList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="主键" align="center" prop="id" />
      <el-table-column label="按钮名称" align="center" prop="buttonName" />
      <el-table-column label="按钮编码" align="center" prop="buttonCode" />
      <el-table-column label="相对请求路径" align="center" prop="requestUrl" />
      <el-table-column label="按钮排序" align="center" prop="orderNum" />
      <el-table-column label="按钮类型" align="center" prop="buttonTypeEnum" />
      <el-table-column label="描述信息" align="center" prop="desc" />
      <el-table-column label="系统预设按钮" align="center" prop="systemButton" />
     <!-- <el-table-column label="创建人" align="center" prop="creator" />
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="更新人" align="center" prop="updator" />
      <el-table-column label="修改时间" align="center" prop="updateTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.updateTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>-->
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['processmanager:processButton:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['processmanager:processButton:remove']"
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

    <!-- 添加或修改流程审核按钮管理对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="按钮名称" prop="buttonName">
          <el-input v-model="form.buttonName" placeholder="请输入按钮名称" />
        </el-form-item>
        <el-form-item label="按钮编码" prop="buttonCode">
          <el-input v-model="form.buttonCode" placeholder="请输入按钮编码" />
        </el-form-item>
        <el-form-item label="相对请求路径" prop="requestRul">
          <el-input v-model="form.requestRul" placeholder="请输入相对请求路径" />
        </el-form-item>
        <el-form-item label="按钮排序" prop="orderNum">
          <el-input v-model="form.orderNum" placeholder="请输入按钮排序" />
        </el-form-item>
        <el-form-item label="按钮类型" prop="buttonType">
          <el-select v-model="form.buttonType" placeholder="请选择按钮类型">
            <el-option label="待办按钮" value="TODO" />
            <el-option label="已办按钮" value="DONE" />
            <el-option label="流程按钮" value="PROCESS" />
          </el-select>
        </el-form-item>
        <el-form-item label="描述信息" prop="desc">
          <el-input v-model="form.desc" placeholder="请输入描述信息" />
        </el-form-item>
        <el-form-item label="系统预设按钮" prop="systemButton">
          <el-select v-model="form.systemButton" placeholder="请选择系统预设按钮">
            <el-option label="是" value="1" />
            <el-option label="否" value="0" />
          </el-select>
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
import { listProcessButton, getProcessButton, delProcessButton, addProcessButton, updateProcessButton } from "@/api/processManagement/processButton";

export default {
  name: "ProcessButton",
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
      // 流程审核按钮管理表格数据
      processButtonList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        buttonName: null,
        buttonCode: null,
        buttonType: null,
        systemButton: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        createTime: [
          { required: true, message: "创建时间不能为空", trigger: "blur" }
        ],
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询流程审核按钮管理列表 */
    getList() {
      this.loading = true;
      listProcessButton(this.queryParams).then(response => {
        this.processButtonList = response.data;
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
        buttonName: null,
        buttonCode: null,
        requestRul: null,
        orderNum: null,
        buttonType: null,
        desc: null,
        systemButton: null,
        creator: null,
        createTime: null,
        updator: null,
        updateTime: null
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
      this.title = "添加流程审核按钮管理";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getProcessButton(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改流程审核按钮管理";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateProcessButton(this.form).then(response => {
              this.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addProcessButton(this.form).then(response => {
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
      this.$confirm('是否确认删除流程审核按钮管理编号为"' + ids + '"的数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return delProcessButton(ids);
        }).then(() => {
          this.getList();
          this.msgSuccess("删除成功");
        }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('processmanager/processButton/export', {
        ...this.queryParams
      }, `processmanager_processButton.xlsx`)
    }
  }
};
</script>
