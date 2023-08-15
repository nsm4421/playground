package com.karma.prj.util;

import com.karma.prj.model.entity.UserEntity;
import com.karma.prj.service.UserService;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.Key;
import java.util.Date;
import java.util.Set;

@Slf4j
@RequiredArgsConstructor
public class JwtUtil extends OncePerRequestFilter {
    private final UserService userService;
    private final String secretKey;
    // 인증토큰이 json 형태로 넘어오지 않고, param 안에 있는 요청 경로
    // 예) axios.post("api/v1/notification/connect?token=~~~~~")
    private final static Set<String> URL_TOKEN_IN_PARAM = Set.of("api/v1/notification/connect");

    /**
     * JWT 생성
     * @param username 인코딩할 문자열에 유저명 사용
     * @param secretKey 보안키 값
     * @param duration 토큰 유효시간 (Milli Second)
     * @return jwt 토큰값
     */
    public static String generateToken(String username, String secretKey, long duration){
        Claims claims = Jwts.claims();
        claims.put("username", username);
        long currentTimeMillis = System.currentTimeMillis();
        return Jwts.builder()
                .setClaims(claims)
                .setIssuedAt(new Date(currentTimeMillis))
                .setExpiration(new Date(currentTimeMillis+duration))
                .signWith(
                        Keys.hmacShaKeyFor(secretKey.getBytes(StandardCharsets.UTF_8)),
                        SignatureAlgorithm.HS256
                ).compact();
    }

    /**
     * JWT에서 claims 추출
     * @param jwt 토큰
     * @param secretKey 비밀키
     * @return Claims
     */
    public static Claims extractClaimsFromJwt(String jwt, String secretKey){
        Key signingKey = Keys.hmacShaKeyFor(secretKey.getBytes(StandardCharsets.UTF_8));
        return Jwts.parserBuilder()
                .setSigningKey(signingKey)
                .build()
                .parseClaimsJws(jwt)
                .getBody();
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        final String jwt;
        if (URL_TOKEN_IN_PARAM.contains(request.getRequestURI())){
            jwt = request.getQueryString().split("=")[1].trim();
        } else {
            // 헤더가 유효한지 체크
            final String header = request.getHeader(HttpHeaders.AUTHORIZATION);
            if (header == null) {
                log.error("Header is null...");
                filterChain.doFilter(request, response);
                return;
            } else if (!header.startsWith("Bearer ")) {
                log.error("Authorization Header does not start with Bearer...");
                filterChain.doFilter(request, response);
                return;
            }
            // 인증토큰에서 JWT 분리
            jwt = header.split(" ")[1].trim();
        }

        Claims claims = extractClaimsFromJwt(jwt, secretKey);
        
        // 토큰 유효기간 체크
        if (claims.getExpiration().before(new Date())){
            log.error("Token is expired...");
            filterChain.doFilter(request, response);
            return;
        }

        try {
            String usernameFromJwt = claims.get("username", String.class);
            UserEntity user = userService.findByUsernameOrElseThrow(usernameFromJwt);
            UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(
                    user, null,
                    user.getAuthorities()
            );
            authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
            SecurityContextHolder.getContext().setAuthentication(authentication);

        } catch (RuntimeException e) {
            log.error(e.getMessage());
        } finally {
            filterChain.doFilter(request, response);
        }
    }
}
