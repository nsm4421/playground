package com.sns.karma.domain.user;

import lombok.AllArgsConstructor;

@AllArgsConstructor
public enum UserRoleEnum {
    USER("일반유저"),
    ADMIN("관리자");
    private final String name;
}
