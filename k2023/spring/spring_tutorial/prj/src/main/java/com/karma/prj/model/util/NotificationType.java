package com.karma.prj.model.util;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@AllArgsConstructor
public enum NotificationType {
    NEW_COMMENT_ON_POST("new comment!"),
    NEW_LIKE_ON_POST("new like!")
    ;
    private final String description;
}
