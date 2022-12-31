package com.karma.hipgora;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@EnableJpaAuditing
@SpringBootApplication
public class HipboxApplication {

    public static void main(String[] args) {
        SpringApplication.run(HipboxApplication.class, args);
    }

}
