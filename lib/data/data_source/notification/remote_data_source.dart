import 'package:hot_place/domain/model/notification/notification.model.dart';

abstract interface class RemoteNotificationDataSource {
  Stream<Iterable<NotificationModel>> getNotificationStream();

  Future<void> createNotification(NotificationModel notification);

  Future<void> deleteNotification(String notificationId);
}
