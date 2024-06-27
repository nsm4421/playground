import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/data/entity/chat/chat_message/private_chat_message.entity.dart';

import '../../../../core/constant/dto.constant.dart';

part 'private_chat_message.model.freezed.dart';

part 'private_chat_message.model.g.dart';

@freezed
class PrivateChatMessageModel with _$PrivateChatMessageModel {
  const factory PrivateChatMessageModel({
    @Default('') String id,
    DateTime? createdAt,
    @Default('') String senderUid,
    @Default('') String receiverUid,
    @Default('') String content,
    @Default(ChatMessageType.text) ChatMessageType type,
  }) = _PrivateChatMessageModel;

  factory PrivateChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$PrivateChatMessageModelFromJson(json);

  factory PrivateChatMessageModel.fromEntity(PrivateChatMessageEntity entity) =>
      PrivateChatMessageModel(
        id: entity.id ?? '',
        createdAt: entity.createdAt,
        senderUid: entity.senderUid ?? '',
        receiverUid: entity.receiverUid ?? '',
        content: entity.content ?? '',
        type: entity.type,
      );
}
