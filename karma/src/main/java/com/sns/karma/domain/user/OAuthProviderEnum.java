package com.sns.karma.domain.user;

import lombok.AllArgsConstructor;

@AllArgsConstructor
public enum OAuthProviderEnum {
    NONE("null"),
    Google("구글");
    private final String name;
}
