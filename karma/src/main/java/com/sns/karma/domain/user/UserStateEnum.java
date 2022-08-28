package com.sns.karma.domain.user;

import lombok.AllArgsConstructor;

@AllArgsConstructor
public enum UserStateEnum {
    ACTIVE("활성화"),
    DEACTIVATE("휴면계정"),
    GONE("종료");

    private final String name;
}
