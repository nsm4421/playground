import 'package:hot_place/domain/repository/notification/notification.repository.dart';
import 'package:hot_place/domain/usecase/notification/case/create_notification.usecase.dart';
import 'package:hot_place/domain/usecase/notification/case/delete_notification.usecase.dart';
import 'package:hot_place/domain/usecase/notification/case/get_notification_stream.usecase.dart';
import 'package:injectable/injectable.dart';

@singleton
class NotificationUseCase {
  final NotificationRepository _repository;

  NotificationUseCase(this._repository);

  @injectable
  CreateNotificationUseCase get create =>
      CreateNotificationUseCase(_repository);

  @injectable
  DeleteNotificationUseCase get delete =>
      DeleteNotificationUseCase(_repository);

  @injectable
  GetNotificationStreamUseCase get getStream =>
      GetNotificationStreamUseCase(_repository);
}
