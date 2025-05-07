package com.karma.myapp.controller.response;

public record LoginResponse(
        String username,
        String token
) {
}
