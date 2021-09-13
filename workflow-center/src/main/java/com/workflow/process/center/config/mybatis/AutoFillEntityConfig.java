package com.workflow.process.center.config.mybatis;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import com.workflow.process.center.service.AuthService;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;

/**
*   @Author: 土豆仙
*   @Date: 2021/6/27 20:09
*   @Description: 插入、修改自动填充属性
*/
@Component
public class AutoFillEntityConfig implements MetaObjectHandler {

    @Autowired
    private AuthService authService;


    @Override
    public void insertFill(MetaObject metaObject) {
        this.setFieldValByName("createTime", new Date(), metaObject);
        this.setFieldValByName("updateTime", new Date(), metaObject);
        this.setFieldValByName("creator", authService.getLoginUser().getUsername(), metaObject);
        this.setFieldValByName("updator", authService.getLoginUser().getUsername(), metaObject);
        this.setFieldValByName("delFlag", 0, metaObject);
    }

    @Override
    public void updateFill(MetaObject metaObject) {
        this.setFieldValByName("updateTime", new Date(), metaObject);
        this.setFieldValByName("updator",  authService.getLoginUser().getUsername(), metaObject);
    }
}
