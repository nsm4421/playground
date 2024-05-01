import 'package:fpdart/fpdart.dart';
import 'package:hot_place/domain/repository/notification/notification.repository.dart';

import '../../../../core/error/failure.constant.dart';

class DeleteNotificationUseCase {
  final NotificationRepository _repository;

  DeleteNotificationUseCase(this._repository);

  Future<Either<Failure, void>> call({required String notificationId}) async =>
      await _repository.deleteNotification(notificationId);
}
