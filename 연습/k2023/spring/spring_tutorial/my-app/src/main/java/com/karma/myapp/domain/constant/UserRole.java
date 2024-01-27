package com.karma.myapp.domain.constant;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum UserRole {
    /**
     * 유저 권한 설정
     */
    USER("ROLE_USER"),
    MANAGER("ROLE_MANGER"),
    ADMIN("ROLE_ADMIN");
    private final String name;
}
