package com.sns.karma.model.notification;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum NotificationType {
    NEW_COMMENT_ON_POST("New Comment"),
    NEW_LIKE_ON_POST("New Like");
    private final String message;
}
