package com.workflow.process.center.aspect;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.workflow.process.center.annotation.CacheDb;
import com.workflow.process.center.mapper.CommonSqlMapper;
import com.google.common.base.CaseFormat;
import com.google.common.collect.Lists;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.DefaultParameterNameDiscoverer;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.expression.spel.support.StandardEvaluationContext;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.workflow.process.center.utils.StringUtils.toCamelCase;


/**
 * @Author: 土豆仙
 * @Date: 2021/1/26 11:58
 * @Description: 走本地mysql缓存注解切面类
 */
@Aspect
@Component
@Slf4j
public class CacheDbAspect {

    /**
     * 用于SpEL表达式解析.
     */
    private static SpelExpressionParser parser = new SpelExpressionParser();
    /**
     * 用于获取方法参数定义名字.
     */
    private static DefaultParameterNameDiscoverer nameDiscoverer = new DefaultParameterNameDiscoverer();

    @Autowired
    private CommonSqlMapper commonSqlMapper;

    @Pointcut("@annotation(com.workflow.process.center.annotation.CacheDb)")
    public void cacheDbPoint() {
    }

    @Around(value = "cacheDbPoint()")
    public Object cacheDbAround(ProceedingJoinPoint point) throws Throwable {

        MethodSignature methodSignature = (MethodSignature) point.getSignature();
        Method method = methodSignature.getMethod();
        CacheDb annotation = method.getAnnotation(CacheDb.class);
        //得到被切面修饰的方法的参数列表
        Object[] args = point.getArgs();

        //默认执行db缓存，只有配置了false，不走db缓存
        String condition = annotation.condition();
        String conditionValue = parseKey(condition, method, args);
        if (StringUtils.isNotBlank(conditionValue) && "false".equals(conditionValue)) {
            return point.proceed();
        }

        //走缓存
        //先根据入参查询缓存中是否有记录=》有记录则组合结果返回
        //缓存中没有，则执行获取结果，获取库名+表名+列名，存入缓存中，返回结果
        //TODO 1.类型校验  2.摘要算法
        List proceed = (List) point.proceed();


        if (ArrayUtils.isNotEmpty(args)) {

            try {
                saveToDb(annotation, proceed);
            } catch (Exception e) {
                log.error("插入mysql缓存失败！！！");
            }

        }

        return proceed;
    }


    /**
     * @Description 存数据，异常不用理会
     * @Author 土豆仙
     * @Date 2021/1/27 17:00
     * @Param
     * @Return
     * @Exception
     */
    private void saveToDb(CacheDb annotation, List<Object> list) {
        String databaseName = annotation.cacheDbDatabaseName();
        String tableName = annotation.cacheDbTableName();

        Map<String, String> columns = new HashMap<>();
        log.info("库名：=【{}】  表名：=【{}】", databaseName, tableName);

        List<String> columnNames = Lists.newArrayList();
        List<Map<String, String>> maps = commonSqlMapper.queryColumns(tableName);
        for (Map<String, String> column : maps) {
            columnNames.add(column.get("columnName"));
        }

        if (CollectionUtils.isNotEmpty(list)) {

            list.stream()
                    .forEach(o -> {
                        JSONObject jsonObject = JSONObject.parseObject(JSON.toJSONString(o));
                        //遍历插入
                        for (String column : columnNames) {
                            String upCaseKey = toCamelCase(column);
                            String value = jsonObject.getString(upCaseKey);
                            log.info("列名：= 【{}】 值：=【{}】", column, value);
                            if (StringUtils.isNotBlank(value)) {
                                columns.put(CaseFormat.UPPER_CAMEL.to(CaseFormat.LOWER_UNDERSCORE, column), value);
                            }
                        }
                        commonSqlMapper.insertOrUpadteMap(columns, databaseName, tableName);

                    });

        }

    }


    /**
     * @Description 获取缓存的key  定义在注解上，支持SPEL表达式
     * @Author 土豆仙
     * @Date 2021/1/26 15:12
     * @Param
     * @Return
     * @Exception
     */
    private String parseKey(String key, Method method, Object[] args) {

        if (StringUtils.isEmpty(key)) {
            return null;
        }
        //获取被拦截方法参数名列表(使用Spring支持类库)
        //拦截类所有方法的参数名
        String[] paraNameArr = nameDiscoverer.getParameterNames(method);
        //SPEL上下文
        StandardEvaluationContext context = new StandardEvaluationContext();
        //把方法参数放入SPEL上下文中
        for (int i = 0; i < paraNameArr.length; i++) {
            context.setVariable(paraNameArr[i], args[i]);
        }
        //使用SPEL进行key的解析
        return parser.parseExpression(key).getValue(context, String.class);
    }
}
