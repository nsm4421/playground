import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:hot_place/domain/model/chat/open_chat/room/open_chat.model.dart';

part 'open_chat.entity.freezed.dart';

part 'open_chat.entity.g.dart';

@freezed
class OpenChatEntity with _$OpenChatEntity {
  const factory OpenChatEntity({
    String? id,
    UserEntity? host,
    String? title,
    @Default(<String>[]) List<String> hashtags,
    String? lastMessage,
    DateTime? createdAt,
    DateTime? lastTalkAt,
  }) = _OpenChatEntity;

  factory OpenChatEntity.fromJson(Map<String, dynamic> json) =>
      _$OpenChatEntityFromJson(json);

  factory OpenChatEntity.fromModel(OpenChatModel openChat) => OpenChatEntity(
      id: openChat.id.isNotEmpty ? openChat.id : null,
      host: UserEntity(
          id: openChat.user_id,
          nickname: openChat.nickname.isNotEmpty ? openChat.nickname : null,
          profileImage: openChat.profile_image),
      title: openChat.title.isNotEmpty ? openChat.title : null,
      hashtags: openChat.hashtags.isNotEmpty ? openChat.hashtags : [],
      lastMessage:
          openChat.last_message.isNotEmpty ? openChat.last_message : null,
      createdAt: openChat.created_at,
      lastTalkAt: openChat.last_talk_at);
}
