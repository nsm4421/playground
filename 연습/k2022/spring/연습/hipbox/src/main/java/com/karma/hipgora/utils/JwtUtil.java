package com.karma.hipgora.utils;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;

import java.nio.charset.StandardCharsets;
import java.security.Key;
import java.util.Date;

public class JwtUtil {

    // 토큰 생성
    public static String generateToken(String username, long duration, String secretKey) {

        Claims claims = Jwts.claims();
        claims.put("username", username);
        Key encryptedKey = getEncryptedKey(secretKey);
        Date currentDate = new Date(System.currentTimeMillis());
        Date ExpireDate = new Date(System.currentTimeMillis()+duration);

        return Jwts.builder()
                .setClaims(claims)
                .setIssuedAt(currentDate)
                .setExpiration(ExpireDate)
                .signWith(encryptedKey, SignatureAlgorithm.HS256)
                .compact();
    }
    
    // 토큰 검사
    public static Boolean validate(String token, String username, String secretKey) {

        Claims claims = getClaimsFromToken(token, secretKey);

        String usernameFromToken = claims.get("username", String.class);
        Date expiration = claims.getExpiration();

        boolean usernameMatched = usernameFromToken.equals(username);
        boolean isExpired = expiration.before(new Date());

        return usernameMatched && !isExpired;
    }

    private static Key getEncryptedKey(String secretKey){
        byte[] bytes = secretKey.getBytes(StandardCharsets.UTF_8);
        return Keys.hmacShaKeyFor(bytes);
    }

    public static Claims getClaimsFromToken(String token, String secretKey){
        Key encryptedKey = getEncryptedKey(secretKey);
        return Jwts.parserBuilder()
                .setSigningKey(encryptedKey)
                .build()
                .parseClaimsJws(token)
                .getBody();
    }
}