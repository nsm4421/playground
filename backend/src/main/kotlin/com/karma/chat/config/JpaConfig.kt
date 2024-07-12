package com.karma.chat.config

import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.data.domain.AuditorAware
import org.springframework.data.jpa.repository.config.EnableJpaAuditing
import org.springframework.security.core.context.SecurityContextHolder
import java.util.*

@EnableJpaAuditing
@Configuration
class JpaConfig {
    @Bean
    fun auditAware(): AuditorAware<String> = AuditorAware<String> {
        Optional.ofNullable(SecurityContextHolder.getContext())
            .map { it.authentication }
            .filter { it !=null && it.isAuthenticated }
            .map { it.name }
    }
}