<!--
 * @Author: xueyan
 * @Date: 2021-08-24 15:27:16
 * @LastEditTime: 2021-08-27 16:57:58
 * @LastEditors: Please set LastEditors
 * @Description: 执行监听器配置弹窗
 * @FilePath: /flow-template-front/src/views/processManagement/processListener/configure.vue
-->

<template>
<div>
  <el-dialog :title="title" :visible.sync="dialogOpen" @close="cancel" width="800px" append-to-body>

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
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
        >删除</el-button>
      </el-col>
    </el-row>

    <el-table v-loading="loading" :data="tableData" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="主键" align="center" prop="id" />
      <el-table-column label="字段名称" align="center" prop="paramName" />
      <el-table-column label="字段类型" align="center" prop="paramType" :formatter="formatterParamType" />
      <el-table-column label="字段值/表达式" align="center" prop="paramValue" />
      <el-table-column label="是否必填" align="center" prop="required" :formatter="formatterRequired" />
      <el-table-column label="操作" align="center" width="180" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
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
    <div slot="footer" class="dialog-footer">
      <el-button @click="cancel">关 闭</el-button>
    </div>
  </el-dialog>
  <!-- 新增/编辑弹窗 -->
  <el-dialog :title="addTitle" :visible.sync="addOpen" @close="addCancel" width="600px" append-to-body>
    <el-form ref="form" :model="form" :rules="rules" label-width="120px">
      <el-form-item label="字段名称" prop="paramName">
        <el-input v-model="form.paramName" placeholder="请输入字段名称" />
      </el-form-item>
      <el-form-item label="是否必填" prop="required">
        <el-select v-model="form.required" placeholder="请选择是否必填">
          <el-option v-for="item in dict.required" :key="item.value" :label="item.label" :value="item.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="字段类型" prop="paramType">
        <el-select v-model="form.paramType" placeholder="请选择字段类型">
          <el-option v-for="item in dict.paramType" :key="item.value" :label="item.label" :value="item.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="字段值/表达式" prop="paramValue" :rules="{ required: form.required === 0, trigger: 'blur', message: '请输入字段值/表达式' }">
        <el-input v-model="form.paramValue" placeholder="请输入字段值/表达式" />
      </el-form-item>

    </el-form>
    <div slot="footer" class="dialog-footer">
      <el-button type="primary" :loading="addBtnLoading" @click="addSubmitForm">确 定</el-button>
      <el-button @click="addCancel">取 消</el-button>
    </div>
  </el-dialog>

  </div>
</template>
<script>
import { getConfigureList, addConfigure, updateConfigure, getConfigureById, deleteConfigure } from '@/api/processManagement/processListener.js'
import dict from './dict'

export default {
  mixins: [dict],
  props: {
    title: {
      type: String,
      default: ''
    },
    open: {
      type: Boolean
    },
    row: {
      type: Object
    }
  },
  watch: {
    row: {
      handler (val) {
        this.listenerId = val?.id
      },
      deep: true
    },
    open: {
      handler (val) {
        this.dialogOpen = val
        if (val) {
          this.getList();
        }
      }
    }
  },
  // /workFlowListenerParam/selectAll
  data() {
    return {
      loading: false,
      btnLoading: false,
      dialogOpen: false,
      // 非多个禁用
      multiple: true,
      // 选中数组
      ids: [],
      tableData: [],
      listenerId: null, // 父id
      total: 0,
      queryParams: {
        pageIndex: 1,
        pageSize: 10,
        listenerId: null
      },
      addOpen: false,
      addBtnLoading: false,
      addTitle: '',
      form: {},
      rules: {
        paramName: [
          { required: true, message: '请输入字段名称', trigger: 'blur' }
        ],
        paramType: [
          { required: true, message: '请选择字段类型', trigger: 'blur' }
        ],
        // paramValue: [
        //   { required: (this.form?.required === 0), message: '请输入字段值/表达式', trigger: 'blur' }
        // ],
        required: [
          { required: true, message: '请选择是否必填', trigger: 'blur' }
        ]
      }
    }
  },
  methods: {
    async getList () {
      this.queryParams.listenerId = this.listenerId;
      const res = await getConfigureList(this.queryParams)
      this.tableData = res.data;
      this.total = res.totalNum;
    },
    cancel () {
      this.$emit('cancel');
      this.ids = [];
      this.multiple = true;
      this.queryParams = {
        pageIndex: 1,
        pageSize: 10,
        listenerId: null
      }
      this.tableData = [];
    },
    handleSelectionChange (selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    handleAdd () {
      this.reset();
      this.addOpen = true;
      this.addTitle = "添加流程监听器参数";
    },
    handleDelete () {},
    async handleUpdate (row) {
      this.reset()
      const res = await getConfigureById(row.id)
      this.form = res.data;
      this.addOpen = true;
      this.addTitle = "修改流程监听器参数";
    },
    handleDelete (row) {
      const ids = row.id ? [row.id] : this.ids;
      this.$confirm('是否确认删除流程监听器参数编号为"' + ids + '"的数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return deleteConfigure(ids);
        }).then(() => {
          this.getList();
          this.msgSuccess("删除成功");
        }).catch(() => {});
    },
    addCancel () {
      this.addOpen = false;
    },
    addSubmitForm () {
      this.$refs["form"].validate(valid => {
        if (valid) {
          this.addBtnLoading = true;
          if (this.form.id != null) {
            updateConfigure(this.form).then(response => {
              this.addBtnLoading = false;
              this.msgSuccess("修改成功");
              this.addOpen = false;
              this.getList();
            });
          } else {
            this.form.listenerId = this.listenerId
            addConfigure(this.form).then(response => {
              this.addBtnLoading = false;
              this.msgSuccess("新增成功");
              this.addOpen = false;
              this.getList();
            });
          }

        }
      })
    },
    // 表单重置
    reset() {
      this.form = {
        id: null,
        paramName: null,
        paramType: null,
        paramValue: null,
        required: null
      };
      this.resetForm("form");
    },
  }
}
</script>
