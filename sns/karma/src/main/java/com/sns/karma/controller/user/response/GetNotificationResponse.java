package com.sns.karma.controller.user.response;

import com.sns.karma.model.notification.Notification;
import com.sns.karma.model.notification.NotificationArgs;
import com.sns.karma.model.notification.NotificationType;
import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor
@Data
public class GetNotificationResponse {
    private Long id;
    private NotificationType notificationType;
    private NotificationArgs args;
    private String message;

    public static GetNotificationResponse fromDto(Notification notification){
        return new GetNotificationResponse(
                notification.getId(),
                notification.getNotificationType(),
                notification.getArgs(),
                notification.getNotificationType().getMessage()
        );
    }
}
