import 'package:fpdart/fpdart.dart';
import 'package:hot_place/data/entity/notification/notification.entity.dart';

import '../../../core/error/failure.constant.dart';

abstract interface class NotificationRepository {
  Stream<List<NotificationEntity>> get notificationStream;

  Future<Either<Failure, void>> createNotification(
      NotificationEntity notification);

  Future<Either<Failure, void>> deleteNotification(String notificationId);

  Future<Either<Failure, void>> deleteAllNotifications(String currentUid);
}
