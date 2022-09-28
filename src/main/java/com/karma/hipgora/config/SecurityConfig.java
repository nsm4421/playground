package com.karma.hipgora.config;

import com.karma.hipgora.exception.ErrorCode;
import com.karma.hipgora.exception.MyException;
import com.karma.hipgora.model.security.MyPrincipal;
import com.karma.hipgora.model.user.User;
import com.karma.hipgora.repository.UserEntityRepository;
import org.springframework.boot.autoconfigure.security.servlet.PathRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity) throws Exception{
        return httpSecurity
                .authorizeHttpRequests(auth->auth
                        // static(css, js) 파일 허용
                        .requestMatchers(
                                PathRequest
                                        .toStaticResources()
                                        .atCommonLocations()
                        )
                        .permitAll()
                        // GET 요청 허용
                        .mvcMatchers(
                                HttpMethod.GET,
                                "/home", "music"
                        ).permitAll()
                        .anyRequest()
                        .authenticated()
                )
                // 폼 로그인
                .formLogin()
                .and()
                // 로그아웃 설정
                .logout()
                .logoutSuccessUrl("/login")
                .and()
                // 빌드
                .build();
    }

    @Bean
    public WebSecurityCustomizer webSecurityCustomizer(){
        return (web)->web
                .ignoring()
                .requestMatchers(
                        PathRequest
                                .toStaticResources()
                                .atCommonLocations()
                );
    }

    @Bean
    public UserDetailsService userDetailsService(UserEntityRepository userEntityRepository){
        return username -> userEntityRepository
                .findByUsername(username)
                .map(User::from)
                .map(MyPrincipal::from)
                .orElseThrow(()->new MyException(
                        ErrorCode.USER_NOT_FOUND,
                        String.format("유저명을 찾을 수 없습니다 - %s", username)));
    }

    @Bean
    public PasswordEncoder passwordEncoder(){
        return PasswordEncoderFactories.createDelegatingPasswordEncoder();
    }
}
