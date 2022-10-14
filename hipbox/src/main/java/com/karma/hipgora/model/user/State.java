package com.karma.hipgora.model.user;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum State {
    ACTIVE("활성계정"),
    BLOCKED("차단계정"),
    GONE("탈퇴계정");
    
    private String description;
}
