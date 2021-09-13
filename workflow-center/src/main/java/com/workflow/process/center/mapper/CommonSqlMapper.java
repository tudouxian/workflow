package com.workflow.process.center.mapper;


import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface CommonSqlMapper {

    List<Map<String, String>> queryColumns(String tableName);

    int insertOrUpadteMap(Map<String, String> columnMap, String databaseName, String tableName);
}
