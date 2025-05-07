package com.karma.compass

import org.springframework.boot.test.context.SpringBootTest
import org.testcontainers.containers.GenericContainer
import spock.lang.Specification

@SpringBootTest
abstract class AbstractIntegrationBaseTest extends Specification {
    static final GenericContainer MY_REDIS_CONTAINER;
    static {
        /**
         * Container
         * name : redis
         * version : 6
         * port : 6379
         */
        MY_REDIS_CONTAINER = new GenericContainer<>("redis:6")
                .withExposedPorts(6379)
        MY_REDIS_CONTAINER.start();
        System.setProperty("spring.redis.host", MY_REDIS_CONTAINER.getHost());
        System.setProperty("spring.redis.port", MY_REDIS_CONTAINER.getMappedPort(6379).toString());
    }
}
