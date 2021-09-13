package com.workflow.process.center.config.component;


import com.google.common.collect.Lists;
import org.springframework.core.io.ClassPathResource;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.script.DefaultRedisScript;
import org.springframework.scripting.support.ResourceScriptSource;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
/**
*   @Author: 土豆仙
*   @Date: 2021/7/13 14:10
*   @Description: redis锁
*/
@Component
public class LockUtils {
    @Resource
    private StringRedisTemplate stringRedisTemplate;

    /**
     * 获取🔐
     *
     * @param key
     * @param randomVal
     * @param timeOut   单位：秒
     */
    public boolean lock(String key, String randomVal, Long timeOut) {

        DefaultRedisScript<Long> redisScript = new DefaultRedisScript<>();
        redisScript.setScriptSource(new ResourceScriptSource(new ClassPathResource("lua/distributedLock.lua")));
        redisScript.setResultType(Long.class);

        Object result = stringRedisTemplate.execute(redisScript, Lists.newArrayList(key), randomVal, String.valueOf(timeOut));

        if ((long) result == 1) {
            return true;
        }
        return false;
    }

    /**
     * 释放🔐
     *
     * @param key
     * @param val
     * @return
     */
    public boolean releaseLock(String key, String val) {

        Class<Long> clazz = Long.class;
        DefaultRedisScript<Long> redisScript = new DefaultRedisScript<>();
        redisScript.setScriptSource(new ResourceScriptSource(new ClassPathResource("lua/releaseLock.lua")));
        redisScript.setResultType(clazz);

        Object result = stringRedisTemplate.execute(redisScript, Lists.newArrayList(key), val);

        if ((long) result == 1) {
            return true;
        }
        return false;
    }

}
