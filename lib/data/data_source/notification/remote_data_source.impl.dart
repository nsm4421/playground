import 'package:hot_place/data/data_source/notification/remote_data_source.dart';
import 'package:hot_place/domain/model/notification/notification.model.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constant/supbase.constant.dart';
import '../../../core/util/exeption.util.dart';

class RemoteNotificationDataSourceImpl implements RemoteNotificationDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  RemoteNotificationDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  Stream<Iterable<NotificationModel>> getNotificationStream() {
    try {
      return _client
          .from(TableName.notification.name)
          .stream(primaryKey: ['id'])
          .order('created_at', ascending: false)
          .asyncMap(
              (data) => data.map((json) => NotificationModel.fromJson(json)));
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  Future<void> createNotification(NotificationModel notification) async {
    try {
      await _client.rest
          .from(TableName.notification.name)
          .insert(notification.copyWith(created_at: DateTime.now()).toJson());
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    try {
      await _client.rest
          .from(TableName.notification.name)
          .delete()
          .eq('id', notificationId);
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  Future<void> deleteAllNotifications(String currentUid) async {
    try {
      await _client.rest
          .from(TableName.notification.name)
          .delete()
          .eq('receiver_id', currentUid);
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }
}
