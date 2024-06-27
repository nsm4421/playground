import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constant/dto.constant.dart';

part 'private_chat_message.entity.freezed.dart';

part 'private_chat_message.entity.g.dart';

@freezed
class PrivateChatMessageEntity with _$PrivateChatMessageEntity {
  const factory PrivateChatMessageEntity({
    String? id,
    DateTime? createdAt,
    String? createdBy,
    String? senderUid,
    String? receiverUid,
    String? content,
    @Default(ChatMessageType.text) ChatMessageType type,
  }) = _PrivateChatMessageEntity;

  factory PrivateChatMessageEntity.fromJson(Map<String, dynamic> json) =>
      _$PrivateChatMessageEntityFromJson(json);
}
