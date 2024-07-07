package com.karma.chat.util

import io.jsonwebtoken.Jwts
import io.jsonwebtoken.SignatureAlgorithm
import io.jsonwebtoken.io.Decoders
import io.jsonwebtoken.security.Keys
import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Component
import java.security.Key
import java.util.*

@Component
class JwtUtil(
    @Value("\${jwt.secret}")
    private val jwtSecret: String,
    @Value("\${jwt.expire}")
    private val expire: Int,
    @Value("\${jwt.issuer}")
    private val issuer: String
) {

    val key: Key by lazy {
        Keys.hmacShaKeyFor(Decoders.BASE64.decode(jwtSecret))
    }

    fun generateToken(subject: String) = Jwts.builder()
        .signWith(key, SignatureAlgorithm.HS512)
        .setSubject(subject)
        .setIssuer(issuer)
        .setIssuedAt(Date())
        .setExpiration(Date(System.currentTimeMillis() * 60 * expire))
        .compact()!!

    fun extractSubject(token: String): String? = Jwts.parserBuilder()
        .setSigningKey(key)
        .build()
        .parseClaimsJws(token)
        .body
        .subject
}