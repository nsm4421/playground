package com.karma.chat.config.security

import org.springframework.boot.autoconfigure.condition.ConditionalOnWebApplication
import org.springframework.boot.autoconfigure.security.ConditionalOnDefaultWebSecurity
import org.springframework.boot.autoconfigure.security.servlet.PathRequest
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity
import org.springframework.security.config.http.SessionCreationPolicy
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter

@Configuration
@EnableWebSecurity
@ConditionalOnDefaultWebSecurity
@ConditionalOnWebApplication(type = ConditionalOnWebApplication.Type.SERVLET)
class SecurityConfig(
    private val jwtAuthenticationFilter: JwtAuthenticationFilter
) {

    // 인증권한 없이 요청을 날릴 수 있는 end point
    private val permitUrls = arrayOf("/swagger-ui/**", "/api/auth/signup/**", "/api/auth/signin/**")

    @Bean
    fun filterChain(http: HttpSecurity) = http
        .csrf { it.disable() }
        .headers { it.frameOptions { frameOptions -> frameOptions.sameOrigin() } }
        .authorizeHttpRequests {
            it.requestMatchers(*permitUrls).permitAll()
                .anyRequest().authenticated()
        }
        // session대신 jwt를 사용하기 때문에, stateless로 설정
        .sessionManagement { it.sessionCreationPolicy(SessionCreationPolicy.STATELESS) }
        // jwt 인증필터 → 기본 인증필터 순으로 chaining
        .addFilterBefore(jwtAuthenticationFilter, BasicAuthenticationFilter::class.java)
        .build()!!

    @Bean
    fun passwordEncoder() = BCryptPasswordEncoder()
}
