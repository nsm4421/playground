import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/constant/chat.dart';
import '../../../domain/model/chat/chat_message.model.dart';

part 'chat_message.entity.freezed.dart';

part 'chat_message.entity.g.dart';

@freezed
class ChatMessageEntity with _$ChatMessageEntity {
  const factory ChatMessageEntity({
    String? id,
    String? chatId,
    String? content,
    ChatMessageType? type,
    String? createdAt,
    String? senderUid,
    String? receiverUid,
  }) = _ChatMessageEntity;

  factory ChatMessageEntity.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageEntityFromJson(json);

  factory ChatMessageEntity.fromModel(ChatMessageModel model) =>
      ChatMessageEntity(
        id: model.id.isEmpty ? null : model.id,
        chatId: model.chatId.isEmpty ? null : model.chatId,
        content: model.content.isEmpty ? null : model.content,
        type: model.type,
        createdAt: model.createdAt,
        senderUid: model.senderUid,
        receiverUid: model.receiverUid,
      );
}
