import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio/domain/entity/auth/presence.entity.dart';

import '../../../data/model/chat/private_chat_message/private_chat_message.model.dart';
import '../../../data/model/chat/private_chat_message/private_chat_message_with_user.model.dart';

part 'private_chat_message.entity.freezed.dart';

@freezed
class PrivateChatMessageEntity with _$PrivateChatMessageEntity {
  const factory PrivateChatMessageEntity({
    String? id,
    String? chatId,
    String? content,
    PresenceEntity? sender,
    PresenceEntity? receiver,
    DateTime? createdAt,
    @Default(false) bool isRemoved,
  }) = _PrivateChatMessageEntity;

  factory PrivateChatMessageEntity.fromModel(PrivateChatMessageModel model) =>
      PrivateChatMessageEntity(
          id: model.id.isNotEmpty ? model.id : null,
          chatId: model.chat_id.isNotEmpty ? model.chat_id : null,
          content: model.content.isNotEmpty ? model.content : null,
          sender:
              model.sender.isNotEmpty ? PresenceEntity(id: model.sender) : null,
          receiver: model.receiver.isNotEmpty
              ? PresenceEntity(id: model.receiver)
              : null,
          createdAt: model.created_at);

  factory PrivateChatMessageEntity.fromWithUserModel(
          PrivateChatMessageWithUserModel model) =>
      PrivateChatMessageEntity(
          id: model.id.isNotEmpty ? model.id : null,
          chatId: model.chat_id.isNotEmpty ? model.chat_id : null,
          content: model.content.isNotEmpty ? model.content : null,
          sender: model.sender.id.isNotEmpty
              ? PresenceEntity.fromModel(model.sender)
              : null,
          receiver: model.receiver.id.isNotEmpty
              ? PresenceEntity.fromModel(model.receiver)
              : null,
          createdAt: model.created_at);

  factory PrivateChatMessageEntity.fromRpcModel(
          PrivateChatMessageWithUserModelForRpc model) =>
      PrivateChatMessageEntity(
          id: model.id.isNotEmpty ? model.id : null,
          chatId: model.chat_id.isNotEmpty ? model.chat_id : null,
          content: model.content.isNotEmpty ? model.content : null,
          sender: PresenceEntity(
            id: model.sender_uid.isNotEmpty ? model.sender_uid : null,
            nickname:
                model.sender_nickname.isNotEmpty ? model.sender_nickname : null,
            profileImage: model.sender_profile_image.isNotEmpty
                ? model.sender_profile_image
                : null,
          ),
          receiver: PresenceEntity(
            id: model.receiver_uid.isNotEmpty ? model.receiver_uid : null,
            nickname: model.receiver_nickname.isNotEmpty
                ? model.receiver_nickname
                : null,
            profileImage: model.receiver_profile_image.isNotEmpty
                ? model.receiver_profile_image
                : null,
          ),
          createdAt: model.created_at);
}
