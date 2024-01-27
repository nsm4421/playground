package com.karma.community.controller.request;

import lombok.Data;

@Data
public class AuthTokenRequest {
    private String code;
    public String  getAuthCode(){
        if (code.startsWith("Bearer ")){
            return code;
        } else{
            return "Bearer " + code.trim();
        }
    }
}
