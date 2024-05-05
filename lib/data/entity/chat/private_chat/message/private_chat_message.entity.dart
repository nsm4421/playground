import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/domain/model/chat/private_chat/message/private_chat_message.local_model.dart';
import 'package:hot_place/domain/model/chat/private_chat/message/private_chat_message.model.dart';
import 'package:hot_place/domain/model/chat/private_chat/room/private_chat.model.dart';

import '../../../user/user.entity.dart';

part 'private_chat_message.entity.freezed.dart';

part 'private_chat_message.entity.g.dart';

@freezed
class PrivateChatMessageEntity with _$PrivateChatMessageEntity {
  const factory PrivateChatMessageEntity({
    String? id, // 메세지 id
    String? chatId, // 채팅방 id
    UserEntity? sender,
    UserEntity? receiver,
    String? content,
    bool? isSeen, // 채팅메세지 읽었는지 여부
    DateTime? createdAt,
  }) = _PrivateChatMessageEntity;

  factory PrivateChatMessageEntity.fromJson(Map<String, dynamic> json) =>
      _$PrivateChatMessageEntityFromJson(json);

  factory PrivateChatMessageEntity.fromModel(PrivateChatMessageModel model) =>
      PrivateChatMessageEntity(
          id: model.id,
          chatId: model.chat_id,
          sender: UserEntity(
              id: model.sender_id,
              nickname: model.sender_nickname,
              profileImage: model.sender_profile_image),
          receiver: UserEntity(
              id: model.receiver_id,
              nickname: model.receiver_nickname,
              profileImage: model.receiver_profile_image),
          content: model.content,
          createdAt: model.created_at);

  factory PrivateChatMessageEntity.fromLocalModel(
          LocalPrivateChatMessageModel model) =>
      PrivateChatMessageEntity(
          id: model.id,
          chatId: model.chat_id,
          sender: UserEntity(
              id: model.sender_id,
              nickname: model.sender_nickname,
              profileImage: model.sender_profile_image),
          receiver: UserEntity(
              id: model.receiver_id,
              nickname: model.receiver_id,
              profileImage: model.receiver_profile_image),
          content: model.content,
          createdAt: model.created_at);
}
