import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/constant/notification.eum.dart';

part 'notification.model.freezed.dart';

part 'notification.model.g.dart';

@freezed
class NotificationModel with _$NotificationModel {
  const factory NotificationModel(
      {String? nid,
      String? title,
      String? message,
      @Default(NotificationType.none) NotificationType type,
      String? receiverUid,
      bool? isSeen,
      DateTime? createdAt}) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}
