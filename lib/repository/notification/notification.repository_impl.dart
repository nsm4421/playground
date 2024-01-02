import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/constant/notification.eum.dart';
import 'package:my_app/domain/dto/notification/notification.dto.dart';
import 'package:my_app/domain/model/notification/notification.model.dart';
import 'package:uuid/uuid.dart';

import '../../api/notification/notification.api.dart';
import '../../api/user/user.api.dart';
import '../../core/response/response.dart';
import 'notification.repository.dart';

@Singleton(as: NotificationRepository)
class NotificationRepositoryImpl extends NotificationRepository {
  final UserApi _userApi;
  final NotificationApi _notificationApi;

  NotificationRepositoryImpl({required userApi, required notificationApi})
      : _userApi = userApi,
        _notificationApi = notificationApi;

  @override
  Future<Response<List<NotificationModel>>> getNotifications() async {
    try {
      final notifications = (await _notificationApi.getNotifications());
      // delete notification(update unSeen field as true)
      await Future.wait(notifications
          .map((e) => e.nid)
          .map((nid) => _notificationApi.deleteNotification(nid)));
      return Response<List<NotificationModel>>(
          status: Status.success,
          data: notifications.map((e) => e.toModel()).toList());
    } catch (err) {
      debugPrint(err.toString());
      return Response<List<NotificationModel>>(
          status: Status.error, message: err.toString());
    }
  }

  @override
  Future<Response<String>> createNotification(
      {required String title,
      required String message,
      required NotificationType type,
      required String receiverUid}) async {
    try {
      final nid = await _notificationApi.createNotification(NotificationDto(
          nid: const Uuid().v1(),
          title: title,
          message: message,
          type: type,
          receiverUid: receiverUid,
          createdAt: DateTime.now()));
      return Response<String>(status: Status.success, data: nid);
    } catch (err) {
      debugPrint(err.toString());
      return Response<String>(status: Status.error, message: err.toString());
    }
  }

  @override
  Future<Response<void>> deleteNotification(String nid) async {
    try {
      final notification = await _notificationApi.getNotificationByNid(nid);
      final currentUid = _userApi.currentUid;
      if (notification.receiverUid != currentUid) {
        throw const CertificateException('NOT_GRANT');
      }
      await _notificationApi.deleteNotification(nid);
      return const Response<void>(status: Status.success);
    } catch (err) {
      debugPrint(err.toString());
      return Response<void>(status: Status.error, message: err.toString());
    }
  }
}
