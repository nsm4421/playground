package com.sns.karma.fixture;

import com.sns.karma.domain.user.OAuthProviderEnum;
import com.sns.karma.domain.user.UserEntity;

public class UserEntityFixture {
    public static UserEntity getUserEntityFixture(String username, String password){
        UserEntity userEntity = UserEntity.of(username, password, OAuthProviderEnum.NONE);
        userEntity.setId(1L);
        return userEntity;
    }
}
