package com.karma.community.config;

import com.karma.community.exception.CustomError;
import com.karma.community.exception.CustomErrorCode;
import com.karma.community.model.security.CustomPrincipal;
import com.karma.community.model.security.KakaoUserInfoResponse;
import com.karma.community.service.UserAccountService;
import org.springframework.boot.autoconfigure.security.servlet.PathRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(
            HttpSecurity http,
            OAuth2UserService<OAuth2UserRequest, OAuth2User> oAuth2UserService
    ) throws Exception {
        return http
                .authorizeHttpRequests(auth -> auth
                        // static(html,css,js,favicon...) → permit all
                        .requestMatchers(PathRequest.toStaticResources().atCommonLocations())
                        .permitAll()
                        // 회원기능 API(회원가입,로그인,카카오인증) → permit all
                        .requestMatchers("/api/user/**")
                        .permitAll()
                        // index 페이지, 게시글 조회 →  Get 요청 허용하는 url
                        .requestMatchers(
                                HttpMethod.GET,
                                "/",
                                "/api/article"
                        ).permitAll()
                        // else → 인증기능 활성화
                        .anyRequest().authenticated()
                )
                // 로그인
                .formLogin()
                .usernameParameter("username")
                .passwordParameter("password")
                .loginProcessingUrl("/api/login")
                .and()
                // 로그아웃 시 쿠키 제거
                .logout(logout -> logout.logoutSuccessUrl("/").deleteCookies("JSESSIONID"))
                // csrf
                .csrf(csrf -> csrf.ignoringRequestMatchers("/api/**"))
                // oAuth
                .oauth2Login(oAuth -> oAuth.userInfoEndpoint(
                        userInfo -> userInfo.userService(oAuth2UserService)
                ))
                .build();
    }

    @Bean
    public UserDetailsService userDetailsService(UserAccountService userAccountService) {
        return username -> userAccountService
                .findByUsername(username)
                .map(CustomPrincipal::from)
                .orElseThrow(() -> {
                    throw CustomError.of(
                            CustomErrorCode.USER_NOT_FOUND,
                            String.format("유저명[ %s]는 존재하지 않는 유저명입니다...", username)
                    );
                });
    }

    @Bean
    public OAuth2UserService<OAuth2UserRequest, OAuth2User> oAuth2UserService(UserAccountService userAccountService) {
        final DefaultOAuth2UserService delegate = new DefaultOAuth2UserService();
        return userRequest -> {
            OAuth2User oAuth2User = delegate.loadUser(userRequest);
            KakaoUserInfoResponse kakaoUserInfoResponse = KakaoUserInfoResponse.from(oAuth2User.getAttributes());
            // username
            String registrationId = userRequest.getClientRegistration().getRegistrationId();
            String providerId = String.valueOf(kakaoUserInfoResponse.id());
            String username = String.format("%s_%s", registrationId, providerId);

            return userAccountService.findByUsername(username)
                    .map(CustomPrincipal::from)
                    // DB에 저장된 회원이 아닌 경우 회원가입
                    .orElseGet(() ->
                            CustomPrincipal.from(
                                    userAccountService.kakaoRegister(
                                            username,
                                            kakaoUserInfoResponse.email(),
                                            kakaoUserInfoResponse.nickname()
                                    )
                            )
                    );
        };
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return PasswordEncoderFactories.createDelegatingPasswordEncoder();
    }

}
