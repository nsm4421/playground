package com.sns.karma.model.notification;

import com.sns.karma.model.user.User;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.sql.Timestamp;

@Getter
@AllArgsConstructor
public class Notification {
    private Long id;
    private User user;
    private NotificationType notificationType;
    private NotificationArgs args;
    private Timestamp registeredAt;
    private Timestamp updatedAt;
    private Timestamp removedAt;

    public static Notification fromEntity(NotificationEntity notificationEntity){
        return new Notification(
                notificationEntity.getId(),
                User.fromEntity(notificationEntity.getUser()),
                notificationEntity.getNotificationType(),
                notificationEntity.getArgs(),
                notificationEntity.getRegisteredAt(),
                notificationEntity.getUpdatedAt(),
                notificationEntity.getRemovedAt()
        );
    }
}
