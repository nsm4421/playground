import 'package:my_app/core/constant/notification.eum.dart';
import 'package:my_app/domain/model/notification/notification.model.dart';
import 'package:my_app/repository/base/repository.dart';

import '../../core/response/response.dart';

abstract class NotificationRepository extends Repository {
  Future<Response<List<NotificationModel>>> getNotifications();

  Future<Response<String>> createNotification(
      {required String title,
      required String message,
      required NotificationType type,
      required String receiverUid});

  Future<Response<void>> deleteNotification(String nid);
}
