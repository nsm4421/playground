package com.sns.karma.model.user;

import lombok.AllArgsConstructor;

@AllArgsConstructor
public enum Role {
    USER("유저"),
    ADMIN("관리자");

    private final String name;
}
