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
    bool? isSender,
    PresenceEntity? opponent,
    DateTime? createdAt,
    @Default(false) bool isRemoved,
  }) = _PrivateChatMessageEntity;

  factory PrivateChatMessageEntity.fromModel(PrivateChatMessageModel model,
      {required String currentUid}) {
    final isSender = model.sender == currentUid;
    return PrivateChatMessageEntity(
        id: model.id.isNotEmpty ? model.id : null,
        chatId: model.chat_id.isNotEmpty ? model.chat_id : null,
        content: model.content.isNotEmpty ? model.content : null,
        opponent: PresenceEntity(id: isSender ? model.receiver : model.sender),
        createdAt: model.created_at,
        isSender: isSender);
  }

  factory PrivateChatMessageEntity.fromWithUserModel(
      PrivateChatMessageWithUserModel model,
      {required String currentUid}) {
    final isSender = model.sender.id == currentUid;
    return PrivateChatMessageEntity(
        id: model.id.isNotEmpty ? model.id : null,
        chatId: model.chat_id.isNotEmpty ? model.chat_id : null,
        content: model.content.isNotEmpty ? model.content : null,
        opponent:
            PresenceEntity.fromModel(isSender ? model.receiver : model.sender),
        createdAt: model.created_at,
        isSender: isSender);
  }

  factory PrivateChatMessageEntity.fromRpcModel(
      PrivateChatMessageWithUserModelForRpc model,
      {required String currentUid}) {
    final isSender = model.sender_uid == currentUid;
    return PrivateChatMessageEntity(
        id: model.id.isNotEmpty ? model.id : null,
        chatId: model.chat_id.isNotEmpty ? model.chat_id : null,
        content: model.content.isNotEmpty ? model.content : null,
        opponent: isSender
            ? PresenceEntity(
                id: model.receiver_uid.isNotEmpty ? model.receiver_uid : null,
                nickname: model.receiver_nickname.isNotEmpty
                    ? model.receiver_nickname
                    : null,
                profileImage: model.receiver_profile_image.isNotEmpty
                    ? model.receiver_profile_image
                    : null,
              )
            : PresenceEntity(
                id: model.sender_uid.isNotEmpty ? model.sender_uid : null,
                nickname: model.sender_nickname.isNotEmpty
                    ? model.sender_nickname
                    : null,
                profileImage: model.sender_profile_image.isNotEmpty
                    ? model.sender_profile_image
                    : null,
              ),
        createdAt: model.created_at,
        isSender: model.sender_uid == currentUid);
  }
}
