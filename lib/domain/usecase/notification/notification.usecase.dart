import 'package:hot_place/domain/repository/notification/notification.repository.dart';
import 'package:hot_place/domain/usecase/notification/case/create_notification.usecase.dart';
import 'package:hot_place/domain/usecase/notification/case/delete_all_notifications.usecase.dart';
import 'package:hot_place/domain/usecase/notification/case/delete_notification.usecase.dart';
import 'package:hot_place/domain/usecase/notification/case/get_notification_stream.usecase.dart';
import 'package:hot_place/presentation/notification/bloc/notification.bloc.dart';
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
  DeleteAllNotificationsUseCase get deleteAll =>
      DeleteAllNotificationsUseCase(_repository);

  @injectable
  GetNotificationStreamUseCase get getStream =>
      GetNotificationStreamUseCase(_repository);
}
