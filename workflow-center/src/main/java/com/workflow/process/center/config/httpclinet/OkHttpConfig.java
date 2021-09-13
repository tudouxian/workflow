package com.workflow.process.center.config.httpclinet;

import okhttp3.ConnectionPool;
import okhttp3.OkHttpClient;
import okhttp3.Protocol;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.Arrays;
import java.util.concurrent.TimeUnit;

@Configuration
public class OkHttpConfig {

    @Bean
    public OkHttpClient okHttpClient() {
        //创建http客户端
        OkHttpClient.Builder okHttpClientBuilder = new OkHttpClient().newBuilder();

        //协议
        okHttpClientBuilder.protocols(Arrays.asList(Protocol.HTTP_1_1, Protocol.HTTP_2));

        // 设置超时
        okHttpClientBuilder.connectTimeout(3000, TimeUnit.MILLISECONDS);
        okHttpClientBuilder.readTimeout(3000, TimeUnit.MILLISECONDS);

        //连接池设置
        okHttpClientBuilder.connectionPool(
                new ConnectionPool(
                        2,
                        1000, TimeUnit.MILLISECONDS
                )
        );

        return okHttpClientBuilder.build();
    }
}
