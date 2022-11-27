package com.karma.meeting.config;

import com.karma.meeting.model.CustomPrincipal;
import com.karma.meeting.model.enums.CustomErrorCode;
import com.karma.meeting.model.exception.CustomException;
import com.karma.meeting.repository.UserAccountRepository;
import org.springframework.boot.autoconfigure.security.servlet.PathRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import static org.springframework.security.config.Customizer.withDefaults;

@Configuration
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(
            HttpSecurity http
    ) throws Exception {
        return http
                .authorizeHttpRequests(auth -> auth
                        // Static(html, css, js, favicon...) 허용
                        .requestMatchers(PathRequest.toStaticResources().atCommonLocations())
                        .permitAll()
                        // GET 요청 허용
                        .mvcMatchers(
                                HttpMethod.GET,
                                "/", "/register"
                        )
                        .permitAll()
                        // POST 요청 허용
                        .mvcMatchers(
                                HttpMethod.POST,
                                "/api/userAccount/register"
                        )
                        .permitAll()
                        // 이 외의 모든 기능은 인증 필요
                        .anyRequest()
                        .authenticated()
                )
                // 폼 로그인 사용 & 로그아웃 시 루트페이지로
                .formLogin(withDefaults())
                .logout(logout -> logout.logoutSuccessUrl("/"))
                // csrf 풀기
                .csrf().disable()
                .build();
    }
    @Bean
    public UserDetailsService userDetailsService(UserAccountRepository repository) {
        return username -> CustomPrincipal.from(
                repository
                        .findByUsername(username)
                        .orElseThrow(()->{
                            throw new CustomException(
                                    CustomErrorCode.ENTITY_NOT_FOUNDED,
                                    String.format("Username [%s] is not founded", username)
                            );
                        }));
    }
    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}