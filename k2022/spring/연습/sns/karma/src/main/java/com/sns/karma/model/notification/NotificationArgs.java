package com.sns.karma.model.notification;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class NotificationArgs {
    private Long userIdWhoGetNotification;
    private Long postIdNotificationOccurs;
}
