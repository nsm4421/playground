package com.karma.hipgora.controller.responses;

import com.karma.hipgora.model.user.User;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Data
public class RegisterResponse {
    private String username;
    private String email;

    public static RegisterResponse from(User user){
        RegisterResponse registerResponse = new RegisterResponse();
        registerResponse.setUsername(user.getUsername());
        registerResponse.setEmail(user.getEmail());
        return registerResponse;
    }
}
