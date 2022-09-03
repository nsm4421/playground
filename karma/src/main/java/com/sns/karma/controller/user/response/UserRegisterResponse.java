package com.sns.karma.controller.user.response;

import com.sns.karma.domain.user.User;
import com.sns.karma.domain.user.UserRoleEnum;
import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class UserRegisterResponse {
    private Long id;
    private String username;
    private UserRoleEnum role;

    public static UserRegisterResponse from(User user){
        return new UserRegisterResponse(
                user.getId(),
                user.getUsername(),
                user.getRole()
        );
    }
}
