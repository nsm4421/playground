import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/domain/model/notification/notification.model.dart';
import 'dart:convert';
import '../../../core/constant/notification.constant.dart';

part 'notification.entity.freezed.dart';

part 'notification.entity.g.dart';

@freezed
class NotificationEntity with _$NotificationEntity {
  const factory NotificationEntity(
      {String? id,
      String? receiverId,
      String? createdBy,
      NotificationType? type,
      String? message,
      DateTime? createdAt}) = _NotificationEntity;

  factory NotificationEntity.fromJson(Map<String, dynamic> json) =>
      _$NotificationEntityFromJson(json);

  factory NotificationEntity.fromModel(NotificationModel model) =>
      NotificationEntity(
          id: model.id.isNotEmpty ? model.id : null,
          receiverId: model.receiver_id.isNotEmpty ? model.receiver_id : null,
          createdBy: model.created_by,
          type: model.type,
          message: model.message.isNotEmpty ? model.message : null,
          createdAt: model.created_at);
}
