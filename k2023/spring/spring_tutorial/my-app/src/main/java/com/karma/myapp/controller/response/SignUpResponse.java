package com.karma.myapp.controller.response;

import com.karma.myapp.domain.dto.UserAccountDto;

public record SignUpResponse (
        String username,
        String email,
        String memo
){
    public static SignUpResponse from(UserAccountDto dto){
        return new SignUpResponse(dto.username(), dto.email(), dto.memo());
    }
}
