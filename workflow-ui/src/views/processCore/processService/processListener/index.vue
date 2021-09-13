<!--
 * @Author: xueyan
 * @Date: 2021-08-24 10:25:19
 * @LastEditTime: 2021-09-01 16:12:05
 * @LastEditors: Please set LastEditors
 * @Description: 流程监听器
 * @FilePath: /flow-template-front/src/views/processManagement/processListener/index.vue
-->
<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="98px">
      <el-form-item label="监听器名称" prop="listenerName">
        <el-input
          v-model="queryParams.listenerName"
          placeholder="请输入监听器名称"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="监听器类型" prop="listenerType">
        <el-select v-model="queryParams.listenerType" placeholder="请选择监听器类型" clearable size="small">
          <el-option v-for="item in dict.listenerType" :key="item.value" :label="item.label" :value="item.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="事件类型" prop="eventType">
        <el-select v-model="queryParams.eventType" placeholder="请选择事件类型" clearable size="small">
          <el-option v-for="item in dict.eventType" :key="item.value" :label="item.label" :value="item.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="值类型" prop="valueType">
        <el-select v-model="queryParams.valueType" placeholder="请选择值类型" clearable size="small">
          <el-option v-for="item in dict.valueType" :key="item.value" :label="item.label" :value="item.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="是否是系统预设监听器" prop="systemListener">
        <el-select v-model="queryParams.systemListener" placeholder="请选择是否是系统预设监听器" clearable size="small">
            <el-option v-for="item in dict.systemListener" :key="item.value" :label="item.label" :value="item.value" />
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
          v-hasPermi="['processmanager:processListener:add']"
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
          v-hasPermi="['processmanager:processListener:edit']"
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
          v-hasPermi="['processmanager:processListener:remove']"
        >删除</el-button>
      </el-col>
      <!-- <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['processmanager:processListener:export']"
        >导出</el-button>
      </el-col> -->
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="processListenerList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="主键" align="center" prop="id" />
      <el-table-column label="监听器名称" align="center" prop="listenerName" />
      <el-table-column label="监听器类型" align="center" prop="listenerType" :formatter="formatterListenerType" />
      <el-table-column label="事件类型" align="center" prop="eventType" :formatter="formatterEventType" />
      <el-table-column label="值类型" align="center" prop="valueType" :formatter="formatterValueType" />
      <el-table-column label="监听器值" align="center" prop="listenerValue" />
      <el-table-column label="是否是系统预设监听器" align="center" prop="systemListener" :formatter="formatterSystemListener" />
      <el-table-column label="备注-描述" align="center" prop="desc" />
      <el-table-column label="操作" align="center" width="180" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleConfigure(scope.row)"
          >配置</el-button>
          <!--v-hasPermi="['processmanager:processListener:configure']"-->
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['processmanager:processListener:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['processmanager:processListener:remove']"
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

    <!-- 添加或修改流程监听器对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="监听器名称" prop="listenerName">
          <el-input v-model="form.listenerName" placeholder="请输入监听器名称" />
        </el-form-item>
        <el-form-item label="监听器类型" prop="listenerType">
          <el-select v-model="form.listenerType" placeholder="请选择监听器类型" @change="listenerTypeChange">
            <el-option v-for="item in dict.listenerType" :key="item.value" :label="item.label" :value="item.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="事件类型" prop="eventType">
          <el-select v-model="form.eventType" placeholder="请选择事件类型">
            <el-option v-for="item in (form.listenerType === 1 ? dict.implementEventType : form.listenerType === 2 ? dict.taskEventType : [] )" :key="item.value" :label="item.label" :value="item.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="值类型" prop="valueType">
          <el-select v-model="form.valueType" placeholder="请选择值类型">
            <el-option v-for="item in dict.valueType" :key="item.value" :label="item.label" :value="item.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="监听器值" prop="listenerValue">
          <el-input v-model="form.listenerValue" placeholder="请输入监听器值" />
        </el-form-item>
        <el-form-item label="是否是系统预设监听器" prop="systemListener">
          <el-select v-model="form.systemListener" placeholder="请选择是否是系统预设监听器">
            <el-option v-for="item in dict.systemListener" :key="item.value" :label="item.label" :value="item.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="备注-描述" prop="desc">
          <el-input v-model="form.desc" placeholder="请输入备注-描述" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" :loading="submitLoading" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
    <Configure :title="title" :row="configureForm" :open="configureOpen" @cancel="configureOpen=false" />
  </div>
</template>

<script>
import { listProcessListener, getProcessListener, delProcessListener, addProcessListener, updateProcessListener } from "@/api/processManagement/processListener";
import dict from './dict'
import Configure from './configure.vue'

export default {
  name: "ProcessListener",
  components: {
    Configure
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
      // 流程监听器表格数据
      processListenerList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageIndex: 1,
        pageSize: 10,
        listenerName: null,
        listenerType: null,
        eventType: null,
        valueType: null,
        systemListener: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        listenerName: [
          { required: true, message: '请输入监听器名称', trigger: 'blur' }
        ],
        listenerType: [
          { required: true, message: '请选择监听器类型', trigger: 'blur' }
        ],
        eventType: [
          { required: true, message: '请选择事件类型', trigger: 'blur' }
        ],
        valueType: [
          { required: true, message: '请选择值类型', trigger: 'blur' }
        ],
        listenerValue: [
          { required: true, message: '请输入监听器值', trigger: 'blur' }
        ],
        systemListener: [
          { required: true, message: '请选择是否是系统预设监听器', trigger: 'blur' }
        ]
      },
      submitLoading: false,
      configureOpen: false,
      configureForm: {},
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询流程监听器列表 */
    getList() {
      this.loading = true;
      listProcessListener(this.queryParams).then(response => {
        this.processListenerList = response.data;
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
        listenerName: null,
        listenerType: null,
        eventType: null,
        valueType: null,
        listenerValue: null,
        systemListener: null,
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
      this.title = "添加流程监听器";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getProcessListener(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改流程监听器";
      });
    },
    /** 配置按钮操作 */
    handleConfigure (row) {
      this.title = row.listenerName;
      this.configureForm = row;
      this.configureOpen = true;
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          this.submitLoading = true;
          if (this.form.id != null) {
            updateProcessListener(this.form).then(response => {
              this.submitLoading = false;
              this.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addProcessListener(this.form).then(response => {
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
      this.$confirm('是否确认删除流程监听器编号为"' + ids + '"的数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return delProcessListener(ids);
        }).then(() => {
          this.getList();
          this.msgSuccess("删除成功");
        }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('processListener/export', {
        ...this.queryParams
      }, `processListener.xlsx`)
    },
    listenerTypeChange () {
      this.form.eventType = null
    }
  }
};
</script>
