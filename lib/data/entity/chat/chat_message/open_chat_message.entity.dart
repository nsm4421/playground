import '../../../../core/constant/dto.constant.dart';
import '../../../../domain/model/chat/message/open_chat_message.model.dart';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'open_chat_message.entity.freezed.dart';

@freezed
class OpenChatMessageEntity with _$OpenChatMessageEntity {
  const factory OpenChatMessageEntity({
    String? id,
    DateTime? createdAt,
    String? createdBy,
    String? content,
    String? chatId,
    @Default(ChatMessageType.text) ChatMessageType type,
  }) = _OpenChatMessageEntity;

  factory OpenChatMessageEntity.fromModel(OpenChatMessageModel model) =>
      OpenChatMessageEntity(
          id: model.id.isEmpty ? null : model.id,
          createdAt: model.createdAt,
          createdBy: model.createdBy,
          content: model.content.isEmpty ? null : model.content,
          chatId: model.chatId.isEmpty ? null : model.chatId,
          type: model.type);
}
