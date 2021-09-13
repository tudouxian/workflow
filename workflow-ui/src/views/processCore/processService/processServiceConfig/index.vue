<template>
  <div class="app-container process-service">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="服务名称" prop="serviceName">
        <el-input
          v-model="queryParams.serviceName"
          placeholder="请输入服务名称"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="服务编码" prop="serviceCode">
        <el-input
          v-model="queryParams.serviceCode"
          placeholder="请输入服务编码"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="服务类型" prop="type">
        <el-select v-model="queryParams.type" placeholder="请选择服务类型" clearable size="small">
          <el-option v-for="item in dict.type" :key="item.value" :label="item.name" :value="item.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="服务分类" prop="serviceCategoryId">
        <el-select v-model="queryParams.serviceCategoryId" placeholder="请选择服务分类" clearable size="small">
          <el-option v-for="item in categoryList" :key="item.id" :label="item.categoryName" :value="item.id" />
        </el-select>
      </el-form-item>
      <el-form-item label="流程定义" prop="processDefId">
        <el-cascader v-model="queryParams.processDefId" :props="dict.difinition" :show-all-levels="false"></el-cascader>
      </el-form-item>
      <el-form-item label="是否发布" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择是否发布" clearable size="small">
          <el-option v-for="item in dict.publish" :key="item.value" :label="item.name" :value="item.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="租户" prop="tenantId">
        <el-select v-model="queryParams.tenantId" placeholder="请选择租户" clearable size="small">
          <el-option v-for="item in dict.tenant" :key="item.value" :label="item.name" :value="item.value" />
        </el-select>
      </el-form-item>
     <!-- <el-form-item label="创建人" prop="creator">
        <el-input
          v-model="queryParams.creator"
          placeholder="请输入创建人"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>-->
     <!-- <el-form-item label="创建时间" prop="createTime">
        <el-date-picker clearable size="small"
          v-model="queryParams.createTime"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="选择创建时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="更新人" prop="updator">
        <el-input
          v-model="queryParams.updator"
          placeholder="请输入更新人"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="更新时间" prop="updateTime">
        <el-date-picker clearable size="small"
          v-model="queryParams.updateTime"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="选择更新时间">
        </el-date-picker>
      </el-form-item>-->
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
          v-hasPermi="['processmanager:processService:add']"
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
          v-hasPermi="['processmanager:processService:edit']"
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
          v-hasPermi="['processmanager:processService:remove']"
        >删除</el-button>
      </el-col>
      <!-- <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['processmanager:processService:export']"
        >导出</el-button>
      </el-col> -->
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="processServiceList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="主键" align="center" prop="id" />
      <el-table-column label="服务名称" align="center" prop="serviceName" />
      <el-table-column label="服务编码" align="center" prop="serviceCode" />
      <el-table-column label="服务类型" align="center" prop="type" :formatter="formatterType" />
      <el-table-column label="服务分类" align="center" prop="serviceCategoryId" :formatter="formatterServiceCategory" />
      <el-table-column label="流程定义ID" align="center" prop="processDefId" />
      <el-table-column  width="200" label="流程定义名称" align="center">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.processDefName" size="medium" >{{'【'+scope.row.processDefName+'】' + 'v'+scope.row.processDefVersion }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="是否发布" align="center" prop="status" :formatter="formatterPublish" />
      <el-table-column label="排序" align="center" prop="orderNum" />
      <el-table-column label="备注" align="center" prop="desc" />
      <el-table-column label="租户名称" align="center" prop="tenantName" />
      <!--<el-table-column label="创建人" align="center" prop="creator" />
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="更新人" align="center" prop="updator" />
      <el-table-column label="更新时间" align="center" prop="updateTime" width="180">
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
            v-hasPermi="['processmanager:processService:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['processmanager:processService:remove']"
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

    <!-- 添加或修改服务对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="服务名称" prop="serviceName">
          <el-input v-model="form.serviceName" placeholder="请输入服务名称" />
        </el-form-item>
        <el-form-item label="服务编码" prop="serviceCode">
          <el-input v-model="form.serviceCode" placeholder="请输入服务编码" />
        </el-form-item>
        <el-form-item label="服务类型" prop="type">
          <el-select v-model="form.type" placeholder="请选择服务类型">
            <el-option v-for="item in dict.type" :key="item.value" :label="item.name" :value="item.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="服务分类" prop="serviceCategoryId">
          <el-select v-model="form.serviceCategoryId" placeholder="请选择服务分类">
            <el-option v-for="item in categoryList" :key="item.id" :label="item.categoryName" :value="item.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="流程定义" prop="processDefId" :class="form.processDefName ? 'process' : ''">
          <el-cascader v-model="form.processDefId" :placeholder="form.processDefName ? `${form.processDefName} 版本：v${form.processDefVersion}` : '请选择流程'" :props="dict.difinition" :show-all-levels="false"></el-cascader>
        </el-form-item>
        <el-form-item label="是否发布">
          <el-radio-group v-model="form.status">
            <el-radio v-for="item in dict.publish" :key="item.value" :label="item.value">{{ item.name }}</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="打开方式" prop="openWay">
          <el-select v-model="form.openWay" placeholder="请选择打开方式">
            <el-option v-for="item in dict.open" :key="item.value" :label="item.name" :value="item.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="排序" prop="orderNum">
          <el-input v-model="form.orderNum" placeholder="请输入排序" />
        </el-form-item>
        <el-form-item label="备注" prop="desc">
          <el-input v-model="form.desc" placeholder="请输入备注" />
        </el-form-item>
        <el-form-item label="租户" prop="tenantId">
          <el-select v-model="form.tenantId" placeholder="租户ID">
            <el-option v-for="item in dict.tenant" :key="item.value" :label="item.name" :value="item.value"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="图片" prop="iconUrl">
          <ImageUpload :value="form.iconUrl" @input="iconUrlInput" />
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
import { listProcessService, getProcessService, delProcessService, addProcessService, updateProcessService } from "@/api/processManagement/processServiceConfig";
import { getCategoryDict } from '@/api/dict'
import dict from './dict'
import ImageUpload from '@/components/ImageUpload/index'
export default {
  name: "ProcessService",
  components: {
    ImageUpload
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
      // 服务表格数据
      processServiceList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        serviceName: null,
        serviceCode: null,
        type: null,
        processDefId: null,
        status: null,
        tenantId: null,
        creator: null,
        createTime: null,
        updator: null,
        updateTime: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        serviceName: [
          { required: true, message: "服务名称不能为空", trigger: "blur" }
        ],
        serviceCode: [
          { required: true, message: "服务编码不能为空", trigger: "blur" }
        ],
        status: [
          { required: true, message: "是否发布不能为空", trigger: "blur" }
        ],
        createTime: [
          { required: true, message: "创建时间不能为空", trigger: "blur" }
        ],
      },
      // 服务分类列表
      categoryList: [],
    };
  },
  created() {
    this.getList();
    this.getCategoryList();
  },
  methods: {
    /** 查询服务列表 */
    getList() {
      this.loading = true;
      listProcessService(this.queryParams).then(response => {
        this.processServiceList = response.data;
        this.total = response.totalNum;
        this.loading = false;
      });
    },
    // 查询分类下拉项
    async getCategoryList () {
      const { data } = await getCategoryDict();
      this.categoryList = data;
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
        serviceName: null,
        serviceCode: null,
        type: null,
        processDefId: null,
        status: 0,
        openWay: null,
        orderNum: null,
        desc: null,
        tenantId: null,
        creator: null,
        createTime: null,
        updator: null,
        updateTime: null,
        iconUrl: ''
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
      this.title = "添加服务";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getProcessService(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改服务";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateProcessService(this.form).then(response => {
              this.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addProcessService(this.form).then(response => {
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
      this.$confirm('是否确认删除服务编号为"' + ids + '"的数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return delProcessService(ids);
        }).then(() => {
          this.getList();
          this.msgSuccess("删除成功");
        }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('processmanager/processService/export', {
        ...this.queryParams
      }, `processmanager_processService.xlsx`)
    },
    iconUrlInput (url) {
      this.form.iconUrl = url;
    },
    formatterServiceCategory(row, column, cellValue) {
      return this.categoryList.find(item => item.id === cellValue)?.categoryName ?? ''
    },
  }
};
</script>
<style lang="scss" scoped>
.process-service {
  .process {
    input:-moz-placeholder,
    textarea:-moz-placeholder {
        color: #606266;
    }
    input:-ms-input-placeholder,
    textarea:-ms-input-placeholder {
        color: #606266;
    }
    input::-webkit-input-placeholder,
    textarea::-webkit-input-placeholder {
        color: #606266 ;
    }
  }
}
</style>
