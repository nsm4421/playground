package com.karma.myapp.config;

import com.karma.myapp.exception.CustomAuthenticationEntryPoint;
import com.karma.myapp.service.UserAccountService;
import com.karma.myapp.utils.JwtFilter;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.security.servlet.PathRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;

import java.util.Arrays;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    private final UserAccountService userAccountService;
    @Value("${jwt.secret-key}") private String secretKey;

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        return http
                // csrf
                .csrf()
                .disable()                // cors : 모두 허용
                .cors(c -> {
                            CorsConfigurationSource source = request -> {
                                CorsConfiguration config = new CorsConfiguration();
                                config.setAllowedOrigins(
                                        Arrays.asList("http://localhost:3000")
                                );
                                config.setAllowedMethods(
                                        Arrays.asList("GET", "POST", "PUT", "DELETE")
                                );
                                config.setAllowedHeaders(Arrays.asList("Content-Type", "Authorization"));
                                return config;
                            };
                            c.configurationSource(source);
                        }
                )
                // session - JWT를 사용하므로 session은 사용하지 않으므로, Stateless
                .sessionManagement()
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and()
                .authorizeHttpRequests(
                        auth -> auth
                                // static files(html,css,js,favicon...) → permit all
                                .requestMatchers(PathRequest.toStaticResources().atCommonLocations()).permitAll()
                                // articles → GET request permit all
                                .requestMatchers(
                                        HttpMethod.GET,
                                        "/api/article", "api/article/*", "api/comment", "api/emotion"
                                ).permitAll()
                                // sign up, login → POST request permit all
                                .requestMatchers(
                                        HttpMethod.POST,
                                        "/api/user/signup", "api/user/login"
                                ).permitAll()
                                // others  → authenticated
                                .anyRequest().authenticated()
                )
                // exception handling
                .exceptionHandling()
                .authenticationEntryPoint(new CustomAuthenticationEntryPoint())
                .and()
                // JWT filter
                .addFilterBefore(new JwtFilter(userAccountService, secretKey), UsernamePasswordAuthenticationFilter.class)
                .build();
    }
}
