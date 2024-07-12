package com.karma.chat.config.security

import com.karma.chat.constant.UserRole
import com.karma.chat.util.JwtUtil
import jakarta.servlet.FilterChain
import jakarta.servlet.http.HttpServletRequest
import jakarta.servlet.http.HttpServletResponse
import org.springframework.core.annotation.Order
import org.springframework.http.HttpHeaders
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.authority.SimpleGrantedAuthority
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.security.core.userdetails.User
import org.springframework.security.web.authentication.WebAuthenticationDetails
import org.springframework.stereotype.Component
import org.springframework.web.filter.OncePerRequestFilter

@Order(0)
@Component
class JwtAuthenticationFilter(
    private val jwtUtil: JwtUtil
) : OncePerRequestFilter() {
    override fun doFilterInternal(
        request: HttpServletRequest,
        response: HttpServletResponse,
        filterChain: FilterChain
    ) {
        // http 요청 시, 가로채서 AUTHORIZATION 헤더에서 jwt 문자열 추출
        val jwt = request.getHeader(HttpHeaders.AUTHORIZATION)
            .takeIf { it?.startsWith("Bearer ", true) ?: false }?.substring(7)
        // jwt 문자열에서 subject 추출
        val subject = (jwt?.takeIf { it.length >= 10 }
            ?.let { jwtUtil.extractSubject(it) }
            ?: "anonymous:${UserRole.ANONYMOUS}")
        // subject를 파싱하여 인증정보 생성
        // jwt 발급 시, [유저명]:[유저권한]과 같은 형태로 subject를 세팅해두었기 때문에, username와 권한 세팅
        val user = subject.split(":")
            .let { User(it[0], "", listOf(SimpleGrantedAuthority(it[1]))) }
        // Security Context에 현재 인증정보 넣기
        UsernamePasswordAuthenticationToken.authenticated(user, jwt, user.authorities)
            .apply { details = WebAuthenticationDetails(request) }
            .also { SecurityContextHolder.getContext().authentication = it }
        // http요청 계속 수행
        filterChain.doFilter(request, response)
    }
}