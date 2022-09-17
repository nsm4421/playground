package com.sns.karma.controller.user.request;

import lombok.Getter;

@Getter
public class UserRegisterRequest {
    private String email;
    private String username;
    private String password;
}
