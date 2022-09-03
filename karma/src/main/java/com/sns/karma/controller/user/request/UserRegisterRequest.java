package com.sns.karma.controller.user.request;

import com.sns.karma.domain.user.OAuthProviderEnum;
import com.sns.karma.domain.user.UserRoleEnum;
import com.sns.karma.domain.user.UserStateEnum;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class UserRegisterRequest {

    private String username;
    private String password;
//    TODO
//    private String email;
//    private UserRoleEnum role;
    private OAuthProviderEnum provider;

}
