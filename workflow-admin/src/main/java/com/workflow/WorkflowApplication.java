package com.workflow;

import com.workflow.process.center.utils.SnowIdUtils;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.context.annotation.Bean;

/**
 * 启动程序
 *
 * @author workflow
 */
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class})
public class WorkflowApplication {
    public static void main(String[] args) {
        // System.setProperty("spring.devtools.restart.enabled", "false");
        SpringApplication.run(WorkflowApplication.class, args);
        System.out.println("(♥◠‿◠)ﾉﾞ  流程引擎启动成功   ლ(´ڡ`ლ)ﾞ  \n");
    }


    @Bean
    public SnowIdUtils snowIdUtils() {
        return new SnowIdUtils(1, 1);
    }
}
