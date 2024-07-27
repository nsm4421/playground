import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio/features/auth/domain/entity/account.entity.dart';
import 'package:portfolio/features/chat/data/model/chat_message.model.dart';
import 'package:portfolio/features/chat/data/model/chat_message_with_user.model.dart';

part 'chat_message.entity.freezed.dart';

@freezed
class ChatMessageEntity with _$ChatMessageEntity {
  const factory ChatMessageEntity({
    String? id,
    String? chatId,
    String? content,
    AccountEntity? sender,
    DateTime? createdAt,
  }) = _ChatMessageEntity;

  factory ChatMessageEntity.fromModel(ChatMessageModel model) =>
      ChatMessageEntity(
          id: model.id.isNotEmpty ? model.id : null,
          chatId: model.chat_id.isNotEmpty ? model.chat_id : null,
          content: model.content.isNotEmpty ? model.content : null,
          sender: model.created_by.isNotEmpty
              ? AccountEntity(id: model.created_by)
              : null,
          createdAt: model.created_at);

  factory ChatMessageEntity.fromModelWithUser(ChatMessageWithUserModel model) =>
      ChatMessageEntity(
          id: model.id.isNotEmpty ? model.id : null,
          chatId: model.chat_id.isNotEmpty ? model.chat_id : null,
          content: model.content.isNotEmpty ? model.content : null,
          sender: model.user.id.isNotEmpty
              ? AccountEntity.fromModel(model.user)
              : null,
          createdAt: model.created_at);
}
