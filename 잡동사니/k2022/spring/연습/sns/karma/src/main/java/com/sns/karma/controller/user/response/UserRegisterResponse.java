package com.sns.karma.controller.user.response;

import com.sns.karma.model.user.User;
import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class UserRegisterResponse {
    private Long id;
    private String username;

    public static UserRegisterResponse from (User user){
        return new UserRegisterResponse(user.getId(), user.getUsername());
    }
}
