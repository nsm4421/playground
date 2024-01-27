package com.karma.board.config;

import com.karma.board.domain.MyPrincipal;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.domain.AuditorAware;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.Optional;

@EnableJpaAuditing
@Configuration
public class JpaConfig {
    @Bean
    public AuditorAware<String> auditorAware() {
        return () -> Optional
                // ⅰ) Security Context 가져오기
                .ofNullable(SecurityContextHolder.getContext())
                // ⅱ) 인증정보 꺼내기
                .map(SecurityContext::getAuthentication)
                // ⅲ) 인증여부 확인
                .filter(Authentication::isAuthenticated)
                // ⅳ) Principal 꺼내기
                .map(Authentication::getPrincipal)
                // ⅴ) Type Casting
                .map(MyPrincipal.class::cast)
                // ⅵ) 유저명 꺼내기
                .map(MyPrincipal::getUsername);
    }
}