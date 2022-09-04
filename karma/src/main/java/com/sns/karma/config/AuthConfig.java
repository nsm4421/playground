package com.sns.karma.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;

@Configuration
@EnableWebSecurity
public class AuthConfig extends WebSecurityConfigurerAdapter {
    @Override
    protected void configure(HttpSecurity http) throws Exception{
        http
                .csrf().disable()
                .authorizeHttpRequests()
                // 회원가입, 로그인 페이지는 허용
                .antMatchers(
                        "api/*/user/register",
                        "api/*/user/login").permitAll()
                // 그 外 페이지는 인증 필요
                .antMatchers("api*/").authenticated()
                .and()
                .sessionManagement()
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS);
//                TODO
//                .and()
//                .exceptionHandling()
//                .authenticationEntryPoint();
    }
}
