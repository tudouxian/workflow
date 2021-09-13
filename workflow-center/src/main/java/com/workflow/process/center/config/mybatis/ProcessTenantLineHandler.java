package com.workflow.process.center.config.mybatis;

import com.baomidou.mybatisplus.extension.plugins.handler.TenantLineHandler;
import lombok.extern.slf4j.Slf4j;
import net.sf.jsqlparser.expression.Expression;

@Slf4j
public class ProcessTenantLineHandler implements TenantLineHandler {
    @Override
    public Expression getTenantId() {
        return null;
    }

    @Override
    public String getTenantIdColumn() {
        return null;
    }

    @Override
    public boolean ignoreTable(String tableName) {
        return false;
    }
}
