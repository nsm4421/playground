import 'package:flutter/foundation.dart';
import 'package:flutter_app/auth/domain/domain.export.dart';
import 'package:flutter_app/chat/data/dto/chat.dto.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat.entity.freezed.dart';

@freezed
class ChatEntity with _$ChatEntity {
  const factory ChatEntity({
    String? id,
    String? uid, // 채팅방을 조회할 수 있는 유저
    PresenceEntity? opponent,
    String? lastMessageContent,
    DateTime? lastMessageCreatedAt,
    @Default(0) int unReadMessageCount, // 읽지 않은 메세지 개수
  }) = _ChatEntity;

  factory ChatEntity.from(FetchChatDto dto) => ChatEntity(
      id: dto.id.isNotEmpty ? dto.id : null,
      uid: dto.uid.isNotEmpty ? dto.uid : null,
      opponent: dto.opponent_uid.isNotEmpty
          ? PresenceEntity(
              uid: dto.opponent_uid,
              username: dto.opponent_username,
              avatarUrl: dto.opponent_avatar_url)
          : null,
      lastMessageContent: dto.last_message_content,
      lastMessageCreatedAt: dto.last_message_created_at,
      unReadMessageCount: dto.un_read_message_count);
}
