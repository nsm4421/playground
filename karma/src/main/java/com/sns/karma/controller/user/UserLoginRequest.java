package com.sns.karma.controller.user;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
public class UserLoginRequest {
    private String username;
    private String password;
}
