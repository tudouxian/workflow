# workflow
后端基于flowable、前端基于bpmn.js二次开发，微服务化流程引擎管理功能，提供流程模型编辑到部署监控一站式解决方案，扩展了众多官方API，提供项目微服务化集成方案。
## 引擎简介
如果你是新手，那么这绝对是你拿来学习flowable流程引擎最佳的项目；如果你对流程引擎熟悉，并且着手用流程引擎来辅助项目，那么这绝对是你最好的流程引擎微服务管理端。

* 本项目用户体系测试环境依赖若依，开发者可以切换集成自己公司的。
* 本项目技术采用Spring Boot，微服务版本见下面链接。
* 文件存储Minio

## 友情链接
- BPMN.js封装不错的模型设计器项目[process-designer](https://miyuesc.github.io/process-designer/)
- 微服务集成版本 [process-cloud](https://github.com/tudouxian/process-cloud.git)

## 系统模块

~~~
workflow     
├── process-center              // 流程引擎核心
├── process-center-api         // 流程引擎核心接口
├── process-common            // 流程引擎通用模块
├── process-idm-api             // 流程-用户体系接口
├── workflow-admin         // 程序入口 [8080]
├── workflow-common          // 通用模块
├── workflow-framework         // spring集成
├── workflow-generator          // 流程引擎代码生成
├── workflow-quartz          // 流程引擎定时任务
├── workflow-system          // 流程引擎用户体系
├── workflow-ui          // 流程引擎前端                                                           
├──pom.xml                // 公共依赖
~~~

## 系统部署
* 安装redis、mysql、minio
* 执行sql脚本
* 更改相应配置
* 启动项目

## 架构图
![](http://image.zmxblog92.com/%E5%B7%A5%E4%BD%9C%E6%B5%81%E5%BC%95%E6%93%8E%E6%9E%B6%E6%9E%84%E5%9B%BE.png)
## 特色功能
![](http://image.zmxblog92.com/%E6%B5%81%E7%A8%8B%E8%B5%B0%E5%90%91%E5%9B%BE.png)

1.  辅助模型设计：将流程分类、流程表达式、流程监听器、流程审核按钮外置表单化，便于设计阶段选择。
2.  模型设计器：重新设计用户任务、服务任务、分支条件、表单挂载。
3.  流程服务管理：便于流程发布及版本管理。
4.  流程运行时管理：分为个人工作台和管理工作台，个人工作台仅仅展示当前登录用户相关任务，管理工作台展示所有人员相关任务，便于运行时干预。
5.  通用审核操作：审核同意、指定驳回、转办、委派、协同、前加签、后加签、归还任务、流程升级迁移等作了统一封装。
6.  跟踪监控：用BPMN.js重绘跟踪监控图，能动态展示各节点运行时状态。

## 接下来开发重点

1. 表单配置，配置节点对表单的访问权限及对表单字段的读写权限
2. 表单条件表达式配置，分支条件读取表单字段进行选择配置
3. 按钮配置，节点拥有审核按钮
4. 服务任务配置，主要是邮件任务、Http任务、Shell任务、Camel任务、服务任务
5. 其他配置例如业务规则
6. 事件配置，主要是定时器配置
7. 多实例交互完善
8. 运行时干预和监控：定时任务、实例升级迁移
9. 多租户的邮件、短信及对应模板开发
10. 数据源配置及sql语句执行
11. 统计报表功能
12. 对接示例开发

## 在线体验
- admin/123456
- 新的更新第一时间会在体验服务上出现

演示地址：http://localhost  
## 演示图
![](http://image.zmxblog92.com/%E6%A8%A1%E5%9E%8B%E8%AE%BE%E8%AE%A1%E5%99%A8.png)
![](http://image.zmxblog92.com/%E7%AE%A1%E7%90%86%E5%88%97%E8%A1%A8.png)
![](http://image.zmxblog92.com/%E8%B7%9F%E8%B8%AA%E7%9B%91%E6%8E%A7.png)


## 流程引擎交流群&公众号
微信搜索 土豆仙
后续会更新流程引擎学习文章 
公众号
![公众号](http://image.zmxblog92.com/%E5%85%AC%E4%BC%97%E5%8F%B7.jpg)


QQ群
![QQ群](http://image.zmxblog92.com/qq%E7%BE%A4.jpg)

##重点
star下，谢谢支持,也欢迎一起贡献，成为commiter,做一版完善的开源工作流引擎