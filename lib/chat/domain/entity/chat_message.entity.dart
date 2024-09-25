import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../auth/domain/domain.export.dart';
import '../../constant/chat_type.dart';
import '../../data/dto/chat_message.dto.dart';

part 'chat_message.entity.freezed.dart';

@freezed
class ChatMessageEntity with _$ChatMessageEntity {
  const factory ChatMessageEntity({
    String? id,
    String? chatId,
    @Default(ChatMessageType.text) ChatMessageType type,
    @Default(false) bool isSeen,
    String? content,
    PresenceEntity? sender,
    PresenceEntity? receiver,
    DateTime? createdAt,
  }) = _ChatMessageEntity;

  factory ChatMessageEntity.from(FetchChatMessageDto dto) => ChatMessageEntity(
      id: dto.id.isNotEmpty ? dto.id : null,
      chatId: dto.chat_id.isNotEmpty ? dto.chat_id : null,
      type: dto.type,
      isSeen: dto.is_seen,
      content: dto.content.isNotEmpty ? dto.content : null,
      sender: PresenceEntity(
          uid: dto.sender_uid,
          username: dto.sender_username,
          avatarUrl: dto.sender_avatar_url),
      receiver: PresenceEntity(
          uid: dto.receiver_uid,
          username: dto.receiver_username,
          avatarUrl: dto.receiver_avatar_url),
      createdAt: dto.created_at);
}
