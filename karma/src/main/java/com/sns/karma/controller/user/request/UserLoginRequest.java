package com.sns.karma.controller.user.request;

import com.sns.karma.domain.user.OAuthProviderEnum;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class UserLoginRequest {
    private String username;
    private String password;
    private OAuthProviderEnum provider;
}
