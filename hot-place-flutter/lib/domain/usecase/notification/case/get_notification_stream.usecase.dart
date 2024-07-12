import 'package:hot_place/data/entity/notification/notification.entity.dart';
import 'package:hot_place/domain/repository/notification/notification.repository.dart';

class GetNotificationStreamUseCase {
  final NotificationRepository _repository;

  GetNotificationStreamUseCase(this._repository);

  Stream<List<NotificationEntity>> call() => _repository.notificationStream;
}
