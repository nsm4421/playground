import 'package:injectable/injectable.dart';
import 'package:my_app/repository/notification/notification.repository.dart';

import '../base/remote.usecase.dart';

@singleton
class NotificationUsecase {
  final NotificationRepository _notificationRepository;

  NotificationUsecase(this._notificationRepository);

  Future execute<T>({required RemoteUsecase useCase}) async =>
      await useCase(_notificationRepository);
}
