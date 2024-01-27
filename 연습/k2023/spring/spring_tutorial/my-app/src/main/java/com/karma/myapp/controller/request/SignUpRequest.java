package com.karma.myapp.controller.request;

import lombok.Data;

@Data
public class SignUpRequest {
    private String username;
    private String password;
    private String email;
    private String memo;
}
