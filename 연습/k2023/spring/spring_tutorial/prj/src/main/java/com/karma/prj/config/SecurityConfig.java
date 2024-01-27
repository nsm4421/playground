package com.karma.prj.config;

import com.karma.prj.service.UserService;
import com.karma.prj.util.CustomAuthenticationEntryPoint;
import com.karma.prj.util.JwtUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.boot.autoconfigure.security.servlet.PathRequest;
import static org.springframework.security.config.Customizer.withDefaults;

import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;


@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {
    private final UserService userService;
    @Value("${jwt.secret-key}") private String secretKey;
    @Bean
    public SecurityFilterChain securityFilterChain(
            HttpSecurity http
    ) throws Exception {
        return http
                .authorizeHttpRequests(auth -> auth
                        // Static(html, css, js, favicon...) 허용
                        .requestMatchers(PathRequest.toStaticResources().atCommonLocations())
                        .permitAll()
                        .requestMatchers(
                                HttpMethod.POST,
                                "/api/*/user/register", "/api/*/user/login")
                        .permitAll()
                        .requestMatchers("/api/**")
                        .authenticated()
                        .anyRequest().permitAll()

                )
                // JWT 필터
                .addFilterBefore(new JwtUtil(userService, secretKey), UsernamePasswordAuthenticationFilter.class)
                .exceptionHandling()
                .authenticationEntryPoint(new CustomAuthenticationEntryPoint())
                .and()
                .formLogin(withDefaults())
                .logout(logout -> logout.logoutSuccessUrl("/"))
                // csrf 풀기
                .csrf().disable()
                .build();
    }
}
