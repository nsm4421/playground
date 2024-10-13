import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:travel/data/model/chat/fetch_chat_message.dart';

import '../auth/presence.dart';

part 'chat_message.entity.freezed.dart';

@freezed
class OpenChatMessageEntity with _$OpenChatMessageEntity {
  const factory OpenChatMessageEntity({
    String? id,
    String? chatId,
    String? content,
    String? media,
    DateTime? createdAt,
    PresenceEntity? sender,
  }) = _OpenChatMessageEntity;

  factory OpenChatMessageEntity.from(FetchOpenChatMessageModel model) =>
      OpenChatMessageEntity(
          id: model.id.isNotEmpty ? model.id : null,
          chatId: model.chat_id.isNotEmpty ? model.chat_id : null,
          content: model.content.isNotEmpty ? model.content : null,
          media: model.media,
          createdAt: DateTime.tryParse(model.created_at),
          sender: model.sender_uid.isNotEmpty
              ? PresenceEntity(
                  uid: model.sender_uid,
                  username: model.sender_username,
                  avatarUrl: model.sender_avatar_url)
              : null);
}

@freezed
class PrivateChatMessageEntity with _$PrivateChatMessageEntity {
  const factory PrivateChatMessageEntity({
    String? id,
    String? chatId,
    PresenceEntity? sender,
    PresenceEntity? receiver,
    String? content,
    String? media,
    DateTime? createdAt,
  }) = _PrivateChatMessageEntity;
}
