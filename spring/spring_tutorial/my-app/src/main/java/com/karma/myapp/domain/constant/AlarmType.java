package com.karma.myapp.domain.constant;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum AlarmType {
    NEW_EMOTION_ON_ARTICLE("new emotion on article"),
    NEW_COMMENT_ON_ARTICLE("new comment on article");
    private final String message;
}
