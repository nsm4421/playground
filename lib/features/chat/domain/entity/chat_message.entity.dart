import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio/features/chat/data/model/chat_message.model.dart';

part 'chat_message.entity.freezed.dart';

@freezed
class ChatMessageEntity with _$ChatMessageEntity {
  const factory ChatMessageEntity({
    String? id,
    String? chatId,
    String? content,
    String? createdBy,
    DateTime? createdAt,
  }) = _ChatMessageEntity;

  factory ChatMessageEntity.fromModel(ChatMessageModel model) =>
      ChatMessageEntity(
          id: model.id.isNotEmpty ? model.id : null,
          chatId: model.chat_id.isNotEmpty ? model.chat_id : null,
          content: model.content.isNotEmpty ? model.content : null,
          createdBy: model.created_by.isNotEmpty ? model.created_by : null,
          createdAt: model.created_at);
}
