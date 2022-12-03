package com.karma.meeting.config;

import com.karma.meeting.model.util.CustomPrincipal;
import com.karma.meeting.model.util.CustomResponse;
import com.karma.meeting.repository.UserAccountRepository;
import org.springframework.boot.autoconfigure.security.servlet.PathRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

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
                                "/register", "/login"
                        )
                        .permitAll()
                        // POST 요청 허용
                        .mvcMatchers(
                                HttpMethod.POST,
                                "/register", "/login"
                        )
                        .permitAll()
                        // 이 외의 모든 기능은 인증 필요
                        .anyRequest()
                        .authenticated()
                )
                // 로그인 폼
                /**
                 * loginPage : 인증이 필요한 경우 이동할 URL
                 * defaultSuccessUrl : 로그인 성공시 이동할 URL
                 * failureUrl : 로그인 실패시 이동할 URL
                 * usernameParameter : form-data 에서 username name 태그
                 * passwordParameter : form-data 에서 password name 태그
                 * loginProcessingUrl : login 인증을 처리할 URL
                 */
                .formLogin()
                .defaultSuccessUrl("/")                 // 로그인 성공시 이동할 URL
                .failureUrl("/login?error")
                .usernameParameter("username")          // username parameter name
                .passwordParameter("password")         // password parameter name
                .loginProcessingUrl("/login")			// 로그인 Form Action Url
                .and()
                // csrf 풀기
                .csrf().disable()
                .build();
    }
    @Bean
    public UserDetailsService userDetailsService(UserAccountRepository repository) {
        return username -> CustomPrincipal.from(
                repository.findByUsername(username)
                        .orElseThrow(()->{throw new UsernameNotFoundException(String.format("Username [%s] is not founded...", username));}));
    }
    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}