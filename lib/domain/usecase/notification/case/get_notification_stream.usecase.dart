import 'package:fpdart/fpdart.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/entity/notification/notification.entity.dart';
import 'package:hot_place/domain/repository/notification/notification.repository.dart';

class GetNotificationStreamUseCase {
  final NotificationRepository _repository;

  GetNotificationStreamUseCase(this._repository);

  Either<Failure, Stream<List<NotificationEntity>>> call() =>
      _repository.getNotificationStream();
}
