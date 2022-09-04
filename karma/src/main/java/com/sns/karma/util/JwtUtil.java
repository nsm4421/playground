package com.sns.karma.util;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;

import java.nio.charset.StandardCharsets;
import java.security.Key;
import java.util.Date;

public class JwtUtil {
    public static String generateToken(String username, String key, long duration){
        Claims claims = Jwts.claims();
        claims.put(key, username);
        Long currentTimeMillis = System.currentTimeMillis();
        return Jwts.builder()
                .setClaims(claims)
                .setIssuedAt(new Date(currentTimeMillis))               // 발행일자
                .setExpiration(new Date(currentTimeMillis+duration))    // 만료일자
                .signWith(generateKey(key) ,SignatureAlgorithm.HS256)   // 키 & 암호화 알고리즘
                .compact();                                             // toString
    }
    private static Key generateKey(String key){
        byte[] keyBytes = key.getBytes(StandardCharsets.UTF_8);
        return Keys.hmacShaKeyFor(keyBytes);
    }
}
