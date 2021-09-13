<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="模型id" prop="modelId">
        <el-input
          v-model="queryParams.modelId"
          placeholder="请输入模型id"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="模型名称" prop="name">
        <el-input
          v-model="queryParams.name"
          placeholder="请输入模型名称"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="模型key" prop="modelKey">
        <el-input
          v-model="queryParams.modelKey"
          placeholder="请输入模型key"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="模型类型" prop="modelType">
        <el-select v-model="queryParams.modelType" placeholder="请选择模型类型" clearable size="small">
          <el-option v-for="item in dict.modelType" :key="item.vlaue" :label="item.name" :value="item.value"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="分类名称" prop="categoryId">
        <el-input
          v-model="queryParams.categoryId"
          placeholder="请输入分类id"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="流程模型状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择流程图模型状态" clearable size="small">
          <el-option v-for="item in dict.status" :key="item.value" :label="item.name" :value="item.value"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="所属部门名称" prop="ownDeptName">
        <el-input
          v-model="queryParams.ownDeptName"
          placeholder="请输入所属部门名称"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="租户ID" prop="tenantId">
        <el-input
          v-model="queryParams.tenantId"
          placeholder="请输入系统标识-租户ID"
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
          v-hasPermi="['processmanager:processModelInfo:add']"
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
          v-hasPermi="['processmanager:processModelInfo:edit']"
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
          v-hasPermi="['processmanager:processModelInfo:remove']"
        >删除</el-button>
      </el-col>
      <!-- <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['processmanager:processModelInfo:export']"
        >导出</el-button>
      </el-col> -->
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="processModelInfoList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="主键" align="center" prop="id" />
      <el-table-column label="模型id" align="center" prop="modelId" />
      <el-table-column label="模型名称" align="center" prop="name" />
      <el-table-column label="模型key" align="center" prop="modelKey" />
      <el-table-column label="模型类型" align="center" prop="modelType" :formatter="formatterModelType"/>
      <el-table-column label="分类名称" align="center" prop="categoryId" :formatter="formatterCategoryId"/>
      <!--<el-table-column label="流程模型状态" align="center" prop="status" :formatter="formatterStatus"/>-->
      <el-table-column label="流程模型状态" align="center">
        <template slot-scope="scope">
          <el-tag type="info" v-if="scope.row.status === 4">停用</el-tag>
          <el-tag type="success" v-if="scope.row.status === 3">已发布</el-tag>
          <el-tag type="primary" v-if="scope.row.status === 2">待发布</el-tag>
          <el-tag type="warning" v-if="scope.row.status === 1">草稿</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="所属部门名称" align="center" prop="ownDeptId" :formatter="formatterOwnDeptName"/>
      <el-table-column label="租户ID" align="center" prop="tenantId" :formatter="formatterTenantId"/>
      <el-table-column label="操作" align="center" width="200" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-upload2"
            @click="handlePublish(scope.row)"
          >发布</el-button>
          <!-- v-hasPermi="['processmanager:processModelInfo:publish']"-->
          <el-button
            size="mini"
            type="text"
            icon="el-icon-circle-close"
            @click="handleStop(scope.row)"
          >停用</el-button>
          <!--v-hasPermi="['processmanager:processModelInfo:stop']"-->
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
          >修改</el-button>
          <!--v-hasPermi="['processmanager:processModelInfo:edit']"-->
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
          >删除</el-button>
          <!-- v-hasPermi="['processmanager:processModelInfo:remove']"-->
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

    <!-- 添加或修改流程模型基本信息对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="700px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="模型名称" prop="name">
          <el-input v-model="form.name" placeholder="请输入模型名称" />
        </el-form-item>
        <el-form-item label="模型key" prop="modelKey">
          <el-input v-model="form.modelKey" placeholder="请输入模型key" />
        </el-form-item>
        <el-form-item label="模型类型" prop="modelType">
          <el-select v-model="form.modelType" placeholder="请选择模型类型">
            <el-option label="自定义流程" :value="0" />
            <el-option label="业务流程" :value="1" />
          </el-select>
        </el-form-item>
        <el-form-item label="分类" prop="categoryId">
          <el-select v-model.number="form.categoryId" placeholder="请选择分类">
            <el-option v-for="item in dict.category" :key="item.value" :label="item.name" :value="item.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="所属部门" prop="ownDeptId">
          <el-select v-model.number="form.ownDeptId" placeholder="请输入选择部门">
            <el-option v-for="item in dict.dept" :key="item.value" :label="item.name" :value="item.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="排序" prop="orderNum">
          <el-input v-model.number="form.orderNum" placeholder="请输入排序" />
        </el-form-item>
        <el-form-item label="租户" prop="tenantId">
          <el-select v-model.number="form.tenantId" placeholder="请选择租户">
            <el-option v-for="item in dict.tenant" :key="item.value" :label="item.name" :value="item.value" />
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
import dict from './dict'
import { listProcessModelInfo, getProcessModelInfo, delProcessModelInfo, addProcessModelInfo, updateProcessModelInfo, saveXml, readXml, publishBpmn, stopBpmn } from "@/api/processManagement/processModelInfo";

export default {
  name: "ProcessModelInfo",
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
      // 流程模型基本信息表格数据
      processModelInfoList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        modelId: null,
        name: null,
        modelKey: null,
        modelType: null,
        categoryId: null,
        status: null,
        ownDeptId: null,
        ownDeptName: null,
        orderNum: null,
        tenantId: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        name: [
          { required: true, message: '请输入模型名称', trigger: 'blur' }
        ],
        modelKey: [
          { required: true, message: '请输入模型key', trigger: 'blur' },
          {
            trigger: 'blur',
            validator(rule, value, callback) {
              if (value.search(/^[a-zA-Z][a-zA-Z0-9_]*$/) < 0) {
                callback(new Error('必需以字母开头，只包含字母、数字、下划线'))
              } else {
                callback()
              }
            },
          }
        ],
        modelType: [
          { required: true, message: '请选择模型类型', trigger: 'blur' }
        ],
        categoryId: [
          { required: true, message: '请选择分类', trigger: 'blur' }
        ],
        ownDeptId: [
          { required: true, message: '请输入选择部门', trigger: 'blur' }
        ],
        orderNum: [
          { required: true, message: '请输入排序', trigger: 'blur' }
        ],
        tenantId: [
          { required: true, message: '请选择租户', trigger: 'blur' }
        ],
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询流程模型基本信息列表 */
    getList() {
      this.loading = true;
      listProcessModelInfo({...this.queryParams, pageIndex: this.queryParams.pageNum}).then(response => {
        this.processModelInfoList = response.data;
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
        modelId: null,
        name: null,
        modelKey: null,
        modelType: null,
        categoryId: null,
        status: 0,
        ownDeptId: null,
        ownDeptName: null,
        applyCompanyId: null,
        functionRange: null,
        orderNum: null,
        tenantId: null,
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
      this.title = "添加流程模型基本信息";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getProcessModelInfo(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改流程模型基本信息";
      });
    },
    /** 跳转到流程设计页面 */
    handleLoadXml(data){
      this.open = false
      this.$router.push({
        // path: '/processCore/processModelInfo/model', // 老
        path: '/processCore/processModel/processModelDesign',
        query: {
          deployId: data ? data : this.form.modelId,
          // bpmn: {
          //   saveXml,
          //   readXml
          // }
        }
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateProcessModelInfo(this.form).then(response => {
              this.msgSuccess("修改成功");
              this.open = false;
              this.getList();
              this.handleLoadXml()
            });
          } else {
            addProcessModelInfo(this.form).then(response => {
              this.msgSuccess("新增成功");
              this.open = false;
              this.getList();
              this.handleLoadXml(response.data.modelId)
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const ids = row.id ? [row.id] : this.ids;
      this.$confirm('是否确认删除流程模型基本信息编号为"' + ids + '"的数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return delProcessModelInfo(ids);
        }).then(() => {
          this.getList();
          this.msgSuccess("删除成功");
        }).catch(() => {});
    },
    async handlePublish(row) {
      await publishBpmn(row.modelId)
      this.$message.success('发布成功')
      await this.getList()
    },
    async handleStop(row) {
      await stopBpmn(row.modelId)
      this.$message.success('停用成功')
      await this.getList()
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('processmanager/processModelInfo/export', {
        ...this.queryParams
      }, `processmanager_processModelInfo.xlsx`)
    },
  }
};
</script>
