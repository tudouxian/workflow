package com.workflow.process.center.annotation;

import java.lang.annotation.*;

/**
*   @Author: 土豆仙
*   @Date: 2021/1/26 12:55
*   @Description: 走mysql缓存注解
*/
@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface CacheDb {


    /**
    * @Description 缓存名
    * @Author  土豆仙
    * @Date   2021/1/26 14:54
    * @Param
    * @Return
    * @Exception
    *
    */
    String[] value() default {};

    /**
    * @Description 缓存库名
    * @Author  土豆仙
    * @Date   2021/1/26 12:54
    * @Param
    * @Return
    * @Exception
    *
    */
    String cacheDbDatabaseName() default "";

    /**
    * @Description 缓存表名
    * @Author  土豆仙
    * @Date   2021/1/26 12:54
    * @Param
    * @Return
    * @Exception
    *
    */
    String cacheDbTableName() default "";

    /**
    * @Description 缓存唯一标识
    * @Author  土豆仙
    * @Date   2021/1/26 12:54
    * @Param
    * @Return
    * @Exception
    *
    */
    String key() default "";

    /**
    * @Description 缓存id生成器=》
    * @Author  土豆仙
    * @Date   2021/1/26 12:53
    * @Param
    * @Return
    * @Exception
    *
    */
    String tableIdGenerator() default "";

    /**
    * @Description 缓存列名-驼峰
    * @Author  土豆仙
    * @Date   2021/1/26 12:53
    * @Param
    * @Return
    * @Exception
    *
    */
    String[] cacheColumnName() default {};

    /**
    * @Description Spring表达式语言(SpEL)用于制作方法的表达式缓存的条件。
     * 默认值，意味着方法结果总是缓存的。
    * @Author  土豆仙
    * @Date   2021/1/26 12:50
    * @Param
    * @Return
    * @Exception
    *
    */
    String condition() default "";
}
