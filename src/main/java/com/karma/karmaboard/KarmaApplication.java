package com.karma.karmaboard;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.SpringBootConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.ConfigurationPropertiesScan;

@SpringBootApplication
@ConfigurationPropertiesScan
public class KarmaApplication {

    public static void main(String[] args) {
        SpringApplication.run(KarmaApplication.class, args);
    }

}
