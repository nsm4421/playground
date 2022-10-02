package com.karma.hipgora.controller.requests;

import lombok.Getter;

@Getter
public class RegisterRequest {
    private String email;
    private String username;
    private String password;
}
