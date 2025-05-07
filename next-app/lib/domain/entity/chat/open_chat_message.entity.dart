import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio/domain/entity/auth/presence.entity.dart';

import '../../../data/model/chat/open_chat_message/open_chat_message.model.dart';
import '../../../data/model/chat/open_chat_message/open_chat_message_with_user.model.dart';

part 'open_chat_message.entity.freezed.dart';

@freezed
class OpenChatMessageEntity with _$OpenChatMessageEntity {
  const factory OpenChatMessageEntity({
    String? id,
    String? chatId,
    String? content,
    PresenceEntity? sender,
    DateTime? createdAt,
  }) = _OpenChatMessageEntity;

  factory OpenChatMessageEntity.fromModel(OpenChatMessageModel model) =>
      OpenChatMessageEntity(
          id: model.id.isNotEmpty ? model.id : null,
          chatId: model.chat_id.isNotEmpty ? model.chat_id : null,
          content: model.content.isNotEmpty ? model.content : null,
          sender: model.created_by.isNotEmpty
              ? PresenceEntity(id: model.created_by)
              : null,
          createdAt: model.created_at);

  factory OpenChatMessageEntity.fromModelWithUser(
          OpenChatMessageWithUserModel model) =>
      OpenChatMessageEntity(
          id: model.id.isNotEmpty ? model.id : null,
          chatId: model.chat_id.isNotEmpty ? model.chat_id : null,
          content: model.content.isNotEmpty ? model.content : null,
          sender: model.user.id.isNotEmpty
              ? PresenceEntity.fromModel(model.user)
              : null,
          createdAt: model.created_at);
}
