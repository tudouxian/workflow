package com.workflow.process.center.service;


import java.util.List;
import java.util.Map;

public interface CommonMongoService<T> {

    public void createCollection(String name);

    public String createIndex(String collectionName, String filedName);

    public List<String> getAllIndexes(String collectionName);

    public void insert(T info, String collectionName);

    public void insertMulti(List<T> infos, String collectionName);

    public void updateById(String id, String collectionName, T info);

    public void deleteById(String id, Class<T> clazz, String collectionName);

    public T selectById(String id, Class<T> clazz, String collectionName);

    public List<T> selectList(String collectName, Class<T> clazz);

    public List<T> selectList(String collectName, Class<T> clazz, Integer currentPage, Integer pageSize);

    public List<T> selectByCondition(String collectName, Map<String, String> conditions, Class<T> clazz, Integer currentPage, Integer pageSize);
}
