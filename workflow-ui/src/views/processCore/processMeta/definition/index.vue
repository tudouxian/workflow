<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="名称" prop="name">
        <el-input
          v-model="queryParams.name"
          placeholder="请输入名称"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="开始时间" prop="deployTime">
        <el-date-picker clearable size="small"
                        v-model="queryParams.deployTime"
                        type="date"
                        value-format="yyyy-MM-dd"
                        placeholder="选择时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

   <!-- <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-upload"
          size="mini"
          @click="handleImport"
        >导入</el-button>
      </el-col>-->
     <!-- <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleLoadXml"
        >新增</el-button>
      </el-col>-->
     <!-- <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:deployment:remove']"
        >删除</el-button>
      </el-col>-->
      <!--<el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:deployment:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>-->

    <el-table v-loading="loading" fit :data="definitionList" border   @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="流程编号" width="55" align="center" prop="deploymentId" />
      <el-table-column label="流程标识" align="center" prop="key" />
      <el-table-column label="流程分类" align="center" prop="category" :formatter="formatterCategoryId" />
      <el-table-column label="流程名称(流程图)" align="center">
        <template slot-scope="scope">
          <el-button type="text" @click="handleReadImage(scope.row.deploymentId)">
            <span>{{ scope.row.name }}</span>
          </el-button>
        </template>
      </el-table-column>
      <el-table-column label="挂载表单" align="center">
        <template slot-scope="scope">
          <el-button v-if="scope.row.formId" type="text" @click="handleForm(scope.row.formId)">
            <span>{{ scope.row.formName }}</span>
          </el-button>
          <label v-else>暂无表单</label>
        </template>
      </el-table-column>
      <el-table-column label="流程版本" align="center">
        <template slot-scope="scope">
          <el-tag size="medium" >v{{ scope.row.version }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="状态" align="center">
        <template slot-scope="scope">
          <el-tag type="success" v-if="scope.row.suspensionState === 1">激活</el-tag>
          <el-tag type="warning" v-if="scope.row.suspensionState === 2">挂起</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="部署时间" align="center" prop="deploymentTime" width="180"/>
      <el-table-column label="操作" align="center" width="300" class-name="small-padding fixed-width">
        <template slot-scope="scope">
        <!--  <el-button
            size="mini"
            type="text"
            icon="el-icon-edit-outline"
            @click="handleLoadXml(scope.row)"
          >编辑</el-button>-->
<!--          <el-button-->
<!--            size="mini"-->
<!--            type="text"-->
<!--            icon="el-icon-picture-outline"-->
<!--            @click="handleReadImage(scope.row)"-->
<!--          >流程图</el-button>-->
<!--          <el-button-->
<!--            size="mini"-->
<!--            type="text"-->
<!--            icon="el-icon-caret-right"-->
<!--            @click="handleDefinitionStart(scope.row)"-->
<!--          >启动</el-button>-->
          <el-button
            size="mini"
            type="text"
            icon="el-icon-connection"
            v-if="scope.row.formId == null"
            @click="handleAddForm(scope.row)"
          >配置表单</el-button>
<!--          <el-button-->
<!--            size="mini"-->
<!--            type="text"-->
<!--            icon="el-icon-connection"-->
<!--            v-else-->
<!--            @click="handleAddForm(scope.row)"-->
<!--          >更换表单</el-button>-->
          <el-button
            size="mini"
            type="text"
            icon="el-icon-video-pause"
            style="color: #f56c6c"
            v-if="scope.row.suspensionState === 1"
            @click="handleUpdateSuspensionState(scope.row)"
          >挂起</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-video-play"
            style="color: #11c629"
            v-if="scope.row.suspensionState === 2"
            @click="handleUpdateSuspensionState(scope.row)"
          >激活</el-button>
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
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改流程定义对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="看看" prop="name">
          <el-input v-model="form.name" placeholder="请输入看看" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>


    <!-- bpmn20.xml导入对话框 -->
    <el-dialog :title="upload.title" :visible.sync="upload.open" width="400px" append-to-body>
      <el-upload
        ref="upload"
        :limit="1"
        accept=".xml"
        :headers="upload.headers"
        :action="upload.url + '?processName=' + upload.processName+'&category='+ upload.category"
        :disabled="upload.isUploading"
        :on-progress="handleFileUploadProgress"
        :on-success="handleFileSuccess"
        :auto-upload="false"
        drag
      >
        <i class="el-icon-upload"></i>
        <div class="el-upload__text">
          将文件拖到此处，或
          <em>点击上传</em>
        </div>
        <div class="el-upload__tip" slot="tip">
          流程名称：<el-input v-model="upload.processName"/>
          流程分类：<el-input v-model="upload.category"/>
        </div>
        <div class="el-upload__tip" style="color:red" slot="tip">提示：仅允许导入“bpmn20.xml”格式文件！</div>
      </el-upload>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitFileForm">确 定</el-button>
        <el-button @click="upload.open = false">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 流程图 -->
    <el-dialog :title="readImage.title" :visible.sync="readImage.open" width="70%" append-to-body>
      <!-- <el-image :src="readImage.src"></el-image> -->
       <flow :xmlData="xmlData"/>
    </el-dialog>

    <!--表单配置详情-->
    <el-dialog :title="formTitle" :visible.sync="formConfOpen" width="50%" append-to-body>
      <div class="test-form">
        <parser :key="new Date().getTime()"  :form-conf="formConf" />
      </div>
    </el-dialog>

    <!--挂载表单-->
    <el-dialog :title="formDeployTitle" :visible.sync="formDeployOpen" width="30%" append-to-body>
      <el-select v-model="formDeployParam.formId" placeholder="请选择表单">
        <el-option v-for="form in formList" :key="form.formId" :label="form.formName" :value="form.formId"/>
      </el-select>
      <el-button type="primary" @click="submitFormDeploy">确 定</el-button>
    </el-dialog>
  </div>
</template>

<script>
import { listDefinition, updateState, delDeployment, addDeployment, updateDeployment, exportDeployment, definitionStart, saveXml, readXml} from "@/api/processCenter/definition";
import dict from './dict'
import { getToken } from "@/utils/auth";
import Parser from '@/components/parser/Parser'
import flow from '@/views/processCore/processMeta/task/record/flow'

export default {
  name: "Definition",
  components: {
    Parser,
    flow
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
      // 流程定义表格数据
      definitionList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      formConfOpen: false,
      formTitle: "",
      formDeployOpen: false,
      formDeployTitle: "",
      formList: null,
      formConf: {}, // 默认表单数据
      readImage:{
        open: false,
        src: "",
      },
      // bpmn.xml 导入
      upload: {
        // 是否显示弹出层（xml导入）
        open: false,
        // 弹出层标题（xml导入）
        title: "",
        // 是否禁用上传
        isUploading: false,
        tenantIds:null,
        processName: null,
        category: null,
        // 设置上传的请求头部
        headers: { Authorization: "Bearer " + getToken() },
        // 上传的地址
        url: process.env.VUE_APP_BASE_API + "/processCenter/flowable/definition/upload"
      },
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        name: null,
        category: null,
        key: null,
        tenantId: null,
        deployTime: null,
        derivedFrom: null,
        derivedFromRoot: null,
        parentDeploymentId: null,
        engineVersion: null
      },
      formDeployParam:{
        formId: 0,
        deployId: null

      },
      // xml
      xmlData:"",
      // 表单参数
      form: {},
      // 表单校验
      rules: {
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询流程定义列表 */
    getList() {
      this.loading = true;
      listDefinition(this.queryParams).then(response => {
        this.definitionList = response.data;
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
        name: null,
        category: null,
        key: null,
        tenantId: null,
        deployTime: null,
        derivedFrom: null,
        derivedFromRoot: null,
        parentDeploymentId: null,
        engineVersion: null
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
      this.title = "添加流程定义";
    },
    /** 跳转到流程设计页面 */
    handleLoadXml(row){
      this.$router.push({ path: '/processcenter/definition/model',query: { deployId: row.deploymentId, bpmn: { saveXml, readXml }}})
    },
    /** 流程图查看 */
    handleReadImage(deploymentId){
      this.readImage.title = "流程图";
      this.readImage.open = true;
      // this.readImage.src = process.env.VUE_APP_BASE_API + "/flowable/definition/readImage/" + deploymentId;
       // 发送请求，获取xml
      readXml(deploymentId).then(res =>{
        this.xmlData = res.data
      })
    },
    /** 表单查看 */
   /* handleForm(formId){
      getForm(formId).then(res =>{
        this.formTitle = "表单详情";
        this.formConfOpen = true;
        this.formConf = JSON.parse(res.data.formContent)
      })
    },*/
    /** 启动流程 */
    handleDefinitionStart(row){
      definitionStart(row.id).then(res =>{
        this.msgSuccess(res.msg);
      })
    },
    /** 挂载表单弹框 */
    handleAddForm(row){
     /* this.formDeployParam.deployId = row.deploymentId
      const queryParams = {
            pageNum: 1,
            pageSize: 10
         }
      listForm(queryParams).then(res =>{
        this.formList = res.rows;
        this.formDeployOpen = true;
        this.formDeployTitle = "挂载表单";
      })*/
      alert("暂时未开发挂载表单！")
    },
    // /** 更改挂载表单弹框 */
    // handleEditForm(row){
    //   this.formDeployParam.deployId = row.deploymentId
    //   const queryParams = {
    //     pageNum: 1,
    //     pageSize: 10
    //   }
    //   listForm(queryParams).then(res =>{
    //     this.formList = res.rows;
    //     this.formDeployOpen = true;
    //     this.formDeployTitle = "挂载表单";
    //   })
    // },
   /* /!** 挂载表单 *!/
    submitFormDeploy(){
      addDeployForm(this.formDeployParam).then(res =>{
        this.msgSuccess(res.msg);
        this.formDeployOpen = false;
        this.getList();
      })
    },*/
    /** 挂起/激活流程 */
    handleUpdateSuspensionState(row){
      let state = 1;
      if (row.suspensionState === 1) {
          state = 2
      }
      const params = {
        deployId: row.deploymentId,
        state: state
      }
      updateState(params).then(res => {
        this.msgSuccess(res.msg);
        this.getList();
      });
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getDeployment(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改流程定义";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateDeployment(this.form).then(response => {
              this.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addDeployment(this.form).then(response => {
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
      // const ids = row.deploymentId || this.ids;
      const params = {
        deployId: row.deploymentId
      }
      this.$confirm('是否确认删除流程定义编号为"' + params.deployId + '"的数据项?', "警告", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(function() {
        return delDeployment(params);
      }).then(() => {
        this.getList();
        this.msgSuccess("删除成功");
      })
    },
    /** 导出按钮操作 */
    handleExport() {
      const queryParams = this.queryParams;
      this.$confirm('是否确认导出所有流程定义数据项?', "警告", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(function() {
        return exportDeployment(queryParams);
      }).then(response => {
        this.download(response.msg);
      })
    },
    /** 导入bpmn.xml文件 */
    handleImport(){
      this.upload.title = "bpmn20.xml文件导入";
      this.upload.open = true;
    },
    // 文件上传中处理
    handleFileUploadProgress(event, file, fileList) {
      this.upload.isUploading = true;
    },
    // 文件上传成功处理
    handleFileSuccess(response, file, fileList) {
      this.upload.open = false;
      this.upload.isUploading = false;
      this.$refs.upload.clearFiles();
      this.$message(response.msg);
      this.getList();
    },
    // 提交上传文件
    submitFileForm() {
      this.$refs.upload.submit();
    }
  }
};
</script>
