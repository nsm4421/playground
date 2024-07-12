part of 'notification.bloc.dart';

@immutable
sealed class NotificationEvent {
  const NotificationEvent();
}

final class InitNotificationEvent extends NotificationEvent {}

final class DeleteNotificationEvent extends NotificationEvent {
  final String notificationId;

  const DeleteNotificationEvent(this.notificationId);
}

final class DeleteAllNotificationsEvent extends NotificationEvent {
  final String currentUid;

  const DeleteAllNotificationsEvent(this.currentUid);
}
