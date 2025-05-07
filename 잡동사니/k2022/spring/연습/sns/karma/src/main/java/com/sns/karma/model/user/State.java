package com.sns.karma.model.user;

import lombok.AllArgsConstructor;

@AllArgsConstructor
public enum State {

    ACTIVE("활동중"),
    BLOCKED("차단계정"),
    DEACTIVATED("휴면계정");

    private final String description;
}
