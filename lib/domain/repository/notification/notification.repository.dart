import 'package:fpdart/fpdart.dart';
import 'package:hot_place/data/entity/notification/notification.entity.dart';

import '../../../core/error/failure.constant.dart';

abstract interface class NotificationRepository {
  Either<Failure, Stream<List<NotificationEntity>>> getNotificationStream();

  Future<Either<Failure, void>> createNotification(
      NotificationEntity notification);

  Future<Either<Failure, void>> deleteNotification(String notificationId);
}
