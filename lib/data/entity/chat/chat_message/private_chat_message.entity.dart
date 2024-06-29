import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/data/entity/user/account.entity.dart';
import 'package:my_app/domain/model/chat/message/private_chat_message.model.dart';

import '../../../../core/constant/dto.constant.dart';

part 'private_chat_message.entity.freezed.dart';

@freezed
class PrivateChatMessageEntity with _$PrivateChatMessageEntity {
  const factory PrivateChatMessageEntity({
    String? id,
    DateTime? createdAt,
    AccountEntity? sender,
    AccountEntity? receiver,
    String? content,
    @Default(ChatMessageType.text) ChatMessageType type,
    String? chatId,
  }) = _PrivateChatMessageEntity;

  factory PrivateChatMessageEntity.fromModel(PrivateChatMessageModel model) =>
      PrivateChatMessageEntity(
          id: model.id.isEmpty ? null : model.id,
          createdAt: model.createdAt,
          sender: AccountEntity(
              id: model.senderUid.isEmpty ? null : model.senderUid),
          receiver: AccountEntity(
              id: model.senderUid.isEmpty ? null : model.senderUid),
          content: model.content.isEmpty ? null : model.content,
          type: model.type,
          chatId: model.chatId.isEmpty ? null : model.chatId);
}
