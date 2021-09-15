<template>
  <div class="app-container home">
    <el-row :gutter="20">
      <el-col :sm="24" :lg="12" style="padding-left: 20px">
        <h2>流程引擎后台管理框架</h2>
        <p>
          <b>当前版本:</b> <span>v{{ version }}</span>
        </p>
        <p>
          <el-tag type="danger">&yen;免费开源</el-tag>
        </p>
        <p>
          <el-button
            type="primary"
            size="mini"
            icon="el-icon-cloudy"
            plain
            @click="goTarget('https://github.com/tudouxian/process-cloud.git')"
          >微服务版本</el-button>
          <el-button
            type="primary"
            size="mini"
            icon="el-icon-cloudy"
            plain
            @click="goTarget('https://github.com/tudouxian/process-cloud.git')"
          >单体架构版本</el-button>
          <el-button
            size="mini"
            icon="el-icon-s-home"
            plain
            @click="goTarget('http://47.96.74.120')"
          >访问主页</el-button
          >
        </p>
      </el-col>

      <el-col :sm="24" :lg="12" style="padding-left: 50px">
        <el-row>
          <el-col :span="12">
            <h2>技术选型</h2>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="6">
            <h4>后端技术</h4>
            <ul>
              <li>SpringBoot</li>
              <li>Spring Security</li>
              <li>JWT</li>
              <li>MyBatis</li>
              <li>Druid</li>
              <li>Fastjson</li>
              <li>flowable</li>
            </ul>
          </el-col>
          <el-col :span="6">
            <h4>前端技术</h4>
            <ul>
              <li>Vue</li>
              <li>Vuex</li>
              <li>Element-ui</li>
              <li>Axios</li>
              <li>Sass</li>
              <li>Quill</li>
              <li>...</li>
            </ul>
          </el-col>
        </el-row>
      </el-col>
    </el-row>
    <el-row :gutter="20">
      <el-col :sm="24" :lg="24">
        <blockquote class="text-success" style="font-size: 14px">
          1.  辅助模型设计：将流程分类、流程表达式、流程监听器、流程审核按钮外置表单化，便于设计阶段选择。
          <br />
          2.  模型设计器：重新设计用户任务、服务任务、分支条件、表单挂载。
          <br />
          <br />
          3.  流程服务管理：便于流程发布及版本管理。
          <br />
          <h4 class="text-success">
            4.  流程运行时管理：分为个人工作台和管理工作台，个人工作台仅仅展示当前登录用户相关任务，管理工作台展示所有人员相关任务，便于运行时干预。
          </h4>
          <h4 class="text-success">
            5.  通用审核操作：审核同意、指定驳回、转办、委派、协同、前加签、后加签、归还任务、流程升级迁移等作了统一封装。
          </h4>
          <h4 class="text-success">
            6.  跟踪监控：用BPMN.js重绘跟踪监控图，能动态展示各节点运行时状态。
          </h4>
        </blockquote>

        <hr />
      </el-col>
    </el-row>

    <el-divider />
    <el-row :gutter="20">
      <el-col :xs="24" :sm="24" :md="12" :lg="8">
        <el-card class="update-log">
          <div slot="header" class="clearfix">
            <span>联系信息</span>
          </div>
          <div class="body">
            <p>
              <i class="el-icon-s-promotion"></i> 官网：<el-link
                href="http://47.96.74.120"
                target="_blank"
                >http://47.96.74.120</el-link
              >
            </p>
            <p>
              <i class="el-icon-user-solid"></i> QQ群：
              <a href="https://jq.qq.com/?_wv=1027&k=TULPgzYe" target="_blank">
                689352649</a
              >
            </p>
          </div>
        </el-card>
      </el-col>
      <el-col :xs="24" :sm="24" :md="12" :lg="8">
        <el-card class="update-log">
          <div slot="header" class="clearfix">
            <span>开发计划</span>
          </div>
          <el-collapse accordion>
            <el-collapse-item title="v2.0.0 - 2021-10-12">
              <ol>
                <li>表单配置，配置节点对表单的访问权限及对表单字段的读写权限</li>
                <li>表单条件表达式配置，分支条件读取表单字段进行选择配置</li>
                <li>按钮配置，节点拥有审核按钮</li>
                <li>服务任务配置，主要是邮件任务、Http任务、Shell任务、Camel任务、服务任务</li>
                <li>其他配置例如业务规则</li>
                <li>事件配置，主要是定时器配置</li>
                <li>多实例交互完善</li>
                <li>运行时干预和监控：定时任务、实例升级迁移</li>
                <li>多租户的邮件、短信及对应模板开发</li>
                <li>数据源配置及sql语句执行</li>
                <li>统计报表功能</li>
                <li>对接示例开发</li>
              </ol>
            </el-collapse-item>
            <el-collapse-item title="v1.0.0 - 2021-09-13">
              <ol>
                <li>流程引擎前后端分离单体架构正式发布</li>
              </ol>
            </el-collapse-item>
          </el-collapse>
        </el-card>
      </el-col>
      <el-col :xs="24" :sm="24" :md="12" :lg="8">
        <el-card class="update-log">
          <div slot="header" class="clearfix">
            <span>关注作者</span>
          </div>
          <div class="body">
            <img
              src="http://image.zmxblog92.com/%E5%85%AC%E4%BC%97%E5%8F%B7.jpg"
              alt="donate"
              width="100%"
            />
            <span style="display: inline-block; height: 30px; line-height: 30px"
              >你可以请作者喝杯咖啡表示鼓励</span
            >
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
export default {
  name: "Index",
  data() {
    return {
      // 版本号
      version: "1.0.0",
    };
  },
  methods: {
    goTarget(href) {
      window.open(href, "_blank");
    },
  },
};
</script>

<style scoped lang="scss">
.home {
  blockquote {
    padding: 10px 20px;
    margin: 0 0 20px;
    font-size: 17.5px;
    border-left: 5px solid #eee;
  }
  hr {
    margin-top: 20px;
    margin-bottom: 20px;
    border: 0;
    border-top: 1px solid #eee;
  }
  .col-item {
    margin-bottom: 20px;
  }

  ul {
    padding: 0;
    margin: 0;
  }

  font-family: "open sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
  font-size: 13px;
  color: #676a6c;
  overflow-x: hidden;

  ul {
    list-style-type: none;
  }

  h4 {
    margin-top: 0px;
  }

  h2 {
    margin-top: 10px;
    font-size: 26px;
    font-weight: 100;
  }

  p {
    margin-top: 10px;

    b {
      font-weight: 700;
    }
  }

  .update-log {
    ol {
      display: block;
      list-style-type: decimal;
      margin-block-start: 1em;
      margin-block-end: 1em;
      margin-inline-start: 0;
      margin-inline-end: 0;
      padding-inline-start: 40px;
    }
  }
}
</style>

