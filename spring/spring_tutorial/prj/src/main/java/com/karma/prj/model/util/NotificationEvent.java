package com.karma.prj.model.util;

import com.karma.prj.model.entity.NotificationEntity;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class NotificationEvent {
    private Long notificationId;
    private Long userId;    // receiver
    private Long postId = null;
    private NotificationType notificationType;
    private String message;

    private NotificationEvent(Long notificationId, Long userId, Long postId, NotificationType notificationType, String message) {
        this.notificationId = notificationId;
        this.userId = userId;
        this.postId = postId;
        this.notificationType = notificationType;
        this.message = message;
    }

    protected NotificationEvent(){}

    public static NotificationEvent of(Long notificationId, Long userId, Long postId, NotificationType notificationType, String message) {
        return new NotificationEvent(notificationId, userId, postId, notificationType, message);
    }

    public static NotificationEvent from(NotificationEntity entity){
        return NotificationEvent.of(
                entity.getId(),
                entity.getUser().getId(),
                entity.getPost().getId(),
                entity.getNotificationType(),
                entity.getMessage()
        );
    }
}
