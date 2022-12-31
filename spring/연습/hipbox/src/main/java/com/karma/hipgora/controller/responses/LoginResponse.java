package com.karma.hipgora.controller.responses;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginResponse {
    String username;
    String token;

    public static LoginResponse of(String username, String token){
        LoginResponse loginResponse = new LoginResponse();
        loginResponse.setUsername(username);
        loginResponse.setToken(token);
        return loginResponse;
    }
}
