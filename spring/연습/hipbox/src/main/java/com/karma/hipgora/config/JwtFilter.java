package com.karma.hipgora.config;


import com.karma.hipgora.model.user.User;
import com.karma.hipgora.service.user.UserService;
import com.karma.hipgora.utils.JwtUtil;
import io.jsonwebtoken.Claims;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Slf4j
@RequiredArgsConstructor
public class JwtFilter extends OncePerRequestFilter {

    private final UserService userService;
    private final String secretKey;

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain chain)
            throws ServletException, IOException {

        final String header = request.getHeader(HttpHeaders.AUTHORIZATION);

        // header가 null이면 에러처리
        if (header == null){
            log.error("Authorization Header is null {}", request.getRequestURL());
            chain.doFilter(request, response);
            return;
        }

        // 토큰이 Bearer로 시작하지 않으면 에러처리
        if (!header.startsWith("Bearer ")) {
            log.error("Authorization Header does not start with Bearer {}", request.getRequestURL());
            chain.doFilter(request, response);
            return;
        }

        try {
            final String token = header.split(" ")[1].trim();
            Claims claims = JwtUtil.getClaimsFromToken(token, secretKey);
            String username = claims.get("username", String.class);
            User userDetails = userService.loadUserByUsername(username);

            if (!JwtUtil.validate(token, userDetails.getUsername(), secretKey)) {
                chain.doFilter(request, response);
                return;
            }
            UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(
                    userDetails, null,
                    userDetails.getAuthorities()
            );
            authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
            SecurityContextHolder.getContext().setAuthentication(authentication);
        } catch (RuntimeException e) {
            chain.doFilter(request, response);
            return;
        }

        chain.doFilter(request, response);

    }
}