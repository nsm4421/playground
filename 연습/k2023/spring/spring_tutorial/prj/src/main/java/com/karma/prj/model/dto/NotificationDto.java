package com.karma.prj.model.dto;

import com.karma.prj.model.util.NotificationType;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class NotificationDto {
    private Long id;
    private UserDto user;
    private PostDto post;
    private NotificationType notificationType;
    private String message;
    private LocalDateTime createdAt;

    private NotificationDto(Long id, UserDto user, PostDto post, NotificationType notificationType, String message, LocalDateTime createdAt) {
        this.id = id;
        this.user = user;
        this.post = post;
        this.notificationType = notificationType;
        this.message = message;
        this.createdAt = createdAt;
    }

    protected NotificationDto(){}

    public static NotificationDto of(Long id, UserDto user, PostDto post, NotificationType notificationType, String message, LocalDateTime createdAt) {
        return new NotificationDto(id, user, post, notificationType, message, createdAt);
    }
}