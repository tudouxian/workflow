<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="表单名称" prop="formName">
        <el-input
          v-model="queryParams.formName"
          placeholder="请输入表单名称"
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
        >删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="formList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="表单主键" align="center" prop="modelInfoId" />
      <el-table-column label="表单KEY" align="center" prop="formKey" />
      <el-table-column label="主版本号" align="center" prop="version" />
      <el-table-column label="表单分类" align="center" prop="categoryId" :formatter="formatterFormCategory" />
      <el-table-column label="表单名称" align="center" prop="formName" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-view"
            @click="handleDetail(scope.row)"
          >详情</el-button>
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

    <!-- 添加或修改流程表单对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="表单名称" prop="formName">
          <el-input v-model="form.formName" placeholder="请输入表单名称" />
        </el-form-item>
        <el-form-item label="表单分类" prop="formCategory">
          <el-select v-model.number="form.categoryId" placeholder="请选择表单分类">
            <el-option v-for="item in formCategoryList" :key="item.id" :label="item.categoryName" :value="item.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="绑定表单模型" prop="formName"  :inline="true">
          <el-select v-model.number="form.formKey" placeholder="请选择表单模型" style="width: 260px">
          <!--<el-option    label="表单模型"  value="" />-->
          </el-select>
         <!-- <el-input v-model="form.formKey" placeholder="请输入表单KEY" />
          <el-input v-model="form.version" placeholder="请输入表单版本" />-->
          <el-button @click="handleDesign">设计模型</el-button>
        </el-form-item>
       <!-- <el-form-item label="表单内容">
          <editor v-model="form.formContent" :min-height="192"/>
        </el-form-item>-->
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" placeholder="请输入备注" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    <!--表单配置详情-->
   <!-- <el-dialog :title="formTitle" :visible.sync="formConfOpen" width="60%" append-to-body>
      <div class="test-form">
        <parser :key="new Date().getTime()"  :form-conf="formConf" />
      </div>
    </el-dialog>-->

    <el-dialog :title="formTitle" :visible.sync="formConfOpen" width="90%"  append-to-body>
        <fc-designer ref="designer" height="2360px" />
    </el-dialog>
  </div>
</template>

<script>
import { listForm, getForm, delForm, addForm, updateForm, exportForm } from "@/api/formGenerator/form";
import { listFormModelByKeyAndVersion } from "@/api/formGenerator/formModel";

import Editor from '@/components/Editor';
import Parser from '@/components/parser/Parser'
import { getFormCategoryDict } from '@/api/dict'
export default {
  name: "Form",
  components: {
    Editor,
    Parser
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
      // 流程表单表格数据
      formList: [],
      formCategoryList:[],
      // 弹出层标题
      title: "",
      formConf: {}, // 默认表单数据
      formConfOpen: false,
      formTitle: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageIndex: 1,
        pageSize: 10,
        formName: null,
        formContent: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
      }
    };
  },
  created() {
    this.getList();
    this.getFormCategoryList();
  },
  methods: {
    /** 查询流程表单列表 */
    getList() {
      this.loading = true;
      listForm(this.queryParams).then(response => {
        this.formList = response.data;
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
        formId: null,
        formName: null,
        formContent: null,
        remark: null
      };
      this.resetForm("form");
    },
    async getFormCategoryList () {
      const { data } = await getFormCategoryDict();
      this.formCategoryList = data;
    },
    formatterFormCategory(row, column, cellValue) {
      return this.formCategoryList.find(item => item.id === cellValue)?.categoryName ?? ''
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
      this.ids = selection.map(item => item.modelInfoId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 表单配置信息 */
    handleDetail(row){
      this.formConfOpen = true;
      this.formTitle = "表单【"+row.formName+"】配置详细";

      //根据formKey和version查询模型信息
      listFormModelByKeyAndVersion(row.formKey,row.version).then(response => {
        this.formConf = JSON.parse(response.data.formJson)
      });
    },
    /** 新增按钮操作 */
    handleAdd() {
       this.reset();
       this.open = true;
       this.title = "添加流程表单";
    },
    /** 设计模型 */
    handleDesign() {
      this.$router.push({ path: '/processCore/formModel/formModel', query: {formId: null }})
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
       this.reset();
       const modelInfoId = row.modelInfoId || this.ids
       getForm(modelInfoId).then(response => {
         this.form = response.data;
         this.open = true;
         this.title = "修改流程表单";
       });
     // this.$router.push({ path: '/tool/build', query: {formId: row.formId }})
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.categoryId != null) {
            updateForm(this.form).then(response => {
              this.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addForm(this.form).then(response => {
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
      const formIds = row.formId || this.ids;
      this.$confirm('是否确认删除流程表单编号为"' + formIds + '"的数据项?', "警告", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(function() {
        return delForm(formIds);
      }).then(() => {
        this.getList();
        this.msgSuccess("删除成功");
      })
    },
    /** 导出按钮操作 */
    handleExport() {
      const queryParams = this.queryParams;
      this.$confirm('是否确认导出所有流程表单数据项?', "警告", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(function() {
        return exportForm(queryParams);
      }).then(response => {
        this.download(response.msg);
      })
    }
  }
};
</script>

<style lang="scss" scoped>
.test-form {
  margin: 15px auto;
  width: 800px;
  padding: 15px;
}

.el-dialog__body {
  max-height: 100vh;
}
</style>
