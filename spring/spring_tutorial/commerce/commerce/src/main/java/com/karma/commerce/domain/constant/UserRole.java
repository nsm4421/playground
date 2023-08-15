package com.karma.commerce.domain.constant;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum UserRole {
    USER("ROLE_USER"),
    MANAGER("ROLE_MANGER"),
    ADMIN("ROLE_ADMIN");
    private final String name;
}
