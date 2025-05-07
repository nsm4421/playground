package com.karma.prj.controller.response;

import com.karma.prj.model.dto.NotificationDto;
import com.karma.prj.model.dto.PostDto;
import com.karma.prj.model.dto.UserDto;
import com.karma.prj.model.util.NotificationType;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class GetNotificationResponse {
    private Long id;
    private Long postId;
    private NotificationType notificationType;
    private String message;
    private LocalDateTime createdAt;

    private GetNotificationResponse(Long id, Long postId, NotificationType notificationType, String message, LocalDateTime createdAt) {
        this.id = id;
        this.postId = postId;
        this.notificationType = notificationType;
        this.message = message;
        this.createdAt = createdAt;
    }

    public static GetNotificationResponse of(Long id, Long postId, NotificationType notificationType, String message, LocalDateTime createdAt) {
        return new GetNotificationResponse(id, postId, notificationType, message, createdAt);
    }

    public static GetNotificationResponse from(NotificationDto dto){
        return GetNotificationResponse.of(
                dto.getId(),
                dto.getPost().getId(),
                dto.getNotificationType(),
                dto.getMessage(),
                dto.getCreatedAt()
        );
    }
}
