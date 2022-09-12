package com.sns.karma.controller.user;

import lombok.Getter;

@Getter
public class UserRegisterRequest {
    private String email;
    private String username;
    private String password;
}
