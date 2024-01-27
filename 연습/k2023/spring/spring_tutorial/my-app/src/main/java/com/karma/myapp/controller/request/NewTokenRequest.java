package com.karma.myapp.controller.request;

import lombok.Data;

@Data
public class NewTokenRequest {
    String username;
    String token;
}
