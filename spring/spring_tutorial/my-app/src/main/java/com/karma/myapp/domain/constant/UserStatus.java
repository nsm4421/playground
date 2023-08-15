package com.karma.myapp.domain.constant;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum UserStatus {
    /**
     * ACTIVE : 활성 유저
     * BLOCKED : 차단된 유저
     * DEACTIVATED : 비활성화된 유저
     */
    ACTIVE,
    BLOCKED,
    DEACTIVATED;
}
