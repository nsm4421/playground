import 'package:fpdart/src/either.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/data_source/notification/remote_data_source.dart';
import 'package:hot_place/data/entity/notification/notification.entity.dart';
import 'package:hot_place/domain/model/notification/notification.model.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/custom_exception.dart';
import '../../../domain/repository/notification/notification.repository.dart';

@Singleton(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  final RemoteNotificationDataSource _dataSource;

  NotificationRepositoryImpl(this._dataSource);

  @override
  Stream<List<NotificationEntity>> get notificationStream => _dataSource
      .getNotificationStream()
      .asyncMap((event) => event.map(NotificationEntity.fromModel).toList());

  @override
  Future<Either<Failure, void>> createNotification(
      NotificationEntity notification) async {
    try {
      return await _dataSource
          .createNotification(NotificationModel.fromEntity(notification))
          .then((_) => right(null));
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNotification(
      String notificationId) async {
    try {
      return await _dataSource
          .deleteNotification(notificationId)
          .then((_) => right(null));
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAllNotifications(
      String currentUid) async {
    try {
      return await _dataSource
          .deleteAllNotifications(currentUid)
          .then((_) => right(null));
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }
}
