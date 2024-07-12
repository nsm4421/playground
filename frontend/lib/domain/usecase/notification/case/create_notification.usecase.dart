import 'package:fpdart/fpdart.dart';
import 'package:hot_place/core/constant/notification.constant.dart';
import 'package:hot_place/core/util/uuid.util.dart';
import 'package:hot_place/data/entity/notification/notification.entity.dart';
import 'package:hot_place/domain/repository/notification/notification.repository.dart';

import '../../../../core/error/failure.constant.dart';

class CreateNotificationUseCase {
  final NotificationRepository _repository;

  CreateNotificationUseCase(this._repository);

  Future<Either<Failure, void>> call(
          {required String message,
          required String receiverId,
          required String createdBy,
          required NotificationType type}) async =>
      await _repository.createNotification(NotificationEntity(
          id: UuidUtil.uuid(),
          receiverId: receiverId,
          createdBy: createdBy,
          type: type,
          message: message));
}
