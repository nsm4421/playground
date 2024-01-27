package com.karma.compass.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.retry.annotation.EnableRetry;

@EnableRetry
@Configuration
public class RetryConfig {
    /**
     * Annotation(@Retryable)만으로 작성하기 원한다면 추가적인 코드 작성 불피요
     * Want to customize retry template, then add bean
     * @Bean
     * public RetryTemplate retryTemplate(){
     *     return new RetryTemplate();
     * }
     */
}
