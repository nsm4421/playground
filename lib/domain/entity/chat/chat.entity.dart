import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:travel/data/model/chat/fetch_chat_room.dart';

import '../auth/presence.dart';

part 'chat.entity.freezed.dart';

@freezed
class OpenChatEntity with _$OpenChatEntity {
  const factory OpenChatEntity({
    String? id,
    String? title, // 방제
    @Default(<String>[]) List<String> hashtags,
    String? lastMessageContent,
    DateTime? lastMessageCreatedAt,
    DateTime? createdAt,
    PresenceEntity? host, // 방장
  }) = _OpenChatEntity;

  factory OpenChatEntity.from(FetchOpenChatModel model) => OpenChatEntity(
      id: model.id.isNotEmpty ? model.id : null,
      title: model.title.isNotEmpty ? model.title : null,
      hashtags: model.hashtags,
      lastMessageContent: model.last_message_content.isNotEmpty
          ? model.last_message_content
          : null,
      lastMessageCreatedAt: DateTime.tryParse(model.last_message_created_at),
      createdAt: DateTime.tryParse(model.created_at),
      host: model.host_uid.isNotEmpty
          ? PresenceEntity(
              uid: model.host_uid,
              username: model.host_username,
              avatarUrl: model.host_avatar_url)
          : null);
}

@freezed
class PrivateChatEntity with _$PrivateChatEntity {
  const factory PrivateChatEntity({
    String? id,
    PresenceEntity? opponent,
    String? lastMessageContent,
    DateTime? lastMessageCreatedAt,
    DateTime? createdAt
  }) = _PrivateChatEntity;
}
