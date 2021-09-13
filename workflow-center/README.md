# 流程引擎系统简介

#### “作始也简，将毕也钜”

### API  DOC 文档地址
* [流程引擎-临时引擎后台管理](localhost)
* [流程引擎showdoc地址](http://47.105.165.206:8888/web/#/7?page_id=77)
* [流程引擎swagger文档地址](http://localhost:8080/swagger-ui/index.html)

### 流程引擎指南

####架构
![](docs/流程中心设计架构草图.png)

* 项目打包  mvn install -Dmaven.test.skip=true


* [Springboot]()
* [MybatisPlus]()
* [Flowable]()
* [Nacos]()
* [Openfeign]()

#### 开发参考模板文件，自行配置easyCode-实现基本增、删、改、查、分页

#### 开发计划| 
* tag① 完善流程引擎   
* tag② 完善自定义表单   
* tag③ 完善自定义报表 
* tag④ 完善决策引擎  
* tag⑤ 引入深度学习

#### 依赖服务部署
* 对象存储MINIO docker run  -d -it -p 9090:9000 -p 9999:9999 --name minio -e "MINIO_ACCESS_KEY=cykj"  -e "MINIO_SECRET_KEY=cykj123456"   minio/minio server  --address '0.0.0.0:9000'   --console-address '0.0.0.0:9999'   /data