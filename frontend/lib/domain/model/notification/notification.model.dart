import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/core/constant/notification.constant.dart';
import 'package:hot_place/data/entity/notification/notification.entity.dart';

part 'notification.model.freezed.dart';

part 'notification.model.g.dart';

@freezed
class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    @Default('') String id,
    @Default('') String receiver_id, // 알림을 받는 유저
    @Default('') String created_by, // 알림을 발생시키는 유저
    @Default(NotificationType.none) NotificationType type,
    @Default('') String message,
    DateTime? created_at,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  factory NotificationModel.fromEntity(NotificationEntity entity) =>
      NotificationModel(
        id: entity.id ?? '',
        receiver_id: entity.receiverId ?? '',
        created_by: entity.createdBy ?? '',
        type: entity.type ?? NotificationType.none,
        message: entity.message ?? '',
        created_at: entity.createdAt,
      );
}
