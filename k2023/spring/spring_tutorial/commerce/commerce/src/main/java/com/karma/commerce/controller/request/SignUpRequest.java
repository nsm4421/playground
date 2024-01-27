package com.karma.commerce.controller.request;

import lombok.Data;

@Data
public class SignUpRequest {
    private String username;
    private String email;
    private String imgUrl;
    private String password;
}
