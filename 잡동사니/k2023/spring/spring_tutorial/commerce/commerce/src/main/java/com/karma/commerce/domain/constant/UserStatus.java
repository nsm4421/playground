package com.karma.commerce.domain.constant;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum UserStatus {
    ACTIVE("활동중인 유저"),
    BLOCKED("차단된 유저"),
    DEACTIVATED("비활성화된 유저"),
    REMOVED("회원탈퇴한 유저");
    private final String description;
}
