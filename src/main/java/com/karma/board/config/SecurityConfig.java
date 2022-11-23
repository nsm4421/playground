package com.karma.board.config;

import com.karma.board.domain.MyPrincipal;
import com.karma.board.service.UserAccountService;
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
        http.csrf().disable();
        return http
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers(PathRequest.toStaticResources().atCommonLocations())
                        .permitAll()
                        .anyRequest()
                        .permitAll()
                )
                .formLogin(withDefaults())
                .logout(logout -> logout.logoutSuccessUrl("/"))
                .build();
        // TODO : 테스트를 위해 임시로 주석처리
//        return http
//                .authorizeHttpRequests(auth -> auth
//                        .requestMatchers(PathRequest.toStaticResources().atCommonLocations())
//                        .permitAll()
//                        .mvcMatchers(
//                            HttpMethod.GET,
//                            "/",
//                            "/articles",
//                            "/articles/**",     // TODO : 제거 (테스트를 위해 열어놓음)ㄴ
//                            "/articles/search-hashtag")
//                        .permitAll()
//                        .anyRequest()
//                        .authenticated()
//                )
//                .formLogin(withDefaults())
//                .logout(logout -> logout.logoutSuccessUrl("/"))
//                .build();
    }

    @Bean
    public UserDetailsService userDetailsService(UserAccountService userAccountService) {
        return username -> MyPrincipal.from(userAccountService.findByUsername(username));
    }

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
