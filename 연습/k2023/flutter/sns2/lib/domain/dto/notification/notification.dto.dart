import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/domain/model/notification/notification.model.dart';

import '../../../core/constant/notification.eum.dart';

part 'notification.dto.freezed.dart';

part 'notification.dto.g.dart';

@freezed
class NotificationDto with _$NotificationDto {
  const factory NotificationDto({@Default('') String nid,
    @Default('') String title,
    @Default('') String message,
    @Default(NotificationType.none) NotificationType type,
    @Default('') String receiverUid,
    @Default(false) bool isSeen,
    DateTime? createdAt}) = _NotificationDto;

  factory NotificationDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationDtoFromJson(json);
}

extension NotificationDtoEx on NotificationDto {
  NotificationModel toModel() =>
      NotificationModel(
          message: message,
          createdAt: createdAt,
          nid: nid,
          receiverUid: receiverUid,
          type: type,
          isSeen: isSeen,
          title: title
      );
}