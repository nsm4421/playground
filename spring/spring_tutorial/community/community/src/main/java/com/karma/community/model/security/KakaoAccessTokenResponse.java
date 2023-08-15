package com.karma.community.model.security;

public record KakaoAccessTokenResponse(
        String access_token,
        String refresh_token,
        String scope,
        String token_type
) {
}
