import 'package:fpdart/fpdart.dart';
import 'package:hot_place/domain/repository/notification/notification.repository.dart';

import '../../../../core/error/failure.constant.dart';

class DeleteAllNotificationsUseCase {
  final NotificationRepository _repository;

  DeleteAllNotificationsUseCase(this._repository);

  Future<Either<Failure, void>> call(String currentUid) async =>
      await _repository.deleteAllNotifications(currentUid);
}
