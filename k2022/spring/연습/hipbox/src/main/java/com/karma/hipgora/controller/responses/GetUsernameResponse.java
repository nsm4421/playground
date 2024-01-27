package com.karma.hipgora.controller.responses;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class GetUsernameResponse {
    private String username;

    public static GetUsernameResponse of(String username){
        GetUsernameResponse getUsernameResponse = new GetUsernameResponse();
        getUsernameResponse.setUsername(username);
        return getUsernameResponse;
    }
}
