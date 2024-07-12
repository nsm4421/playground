import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/data/entity/user/account.entity.dart';

import '../../../../core/constant/dto.constant.dart';
import '../../../../domain/model/chat/message/local_private_chat_message.dto.dart';

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
    bool? isSuccess,
  }) = _PrivateChatMessageEntity;

  factory PrivateChatMessageEntity.fromLocalModel(
          LocalPrivateChatMessageDto dto) =>
      PrivateChatMessageEntity(
          id: dto.id.isEmpty ? null : dto.id,
          createdAt: dto.createdAt,
          sender: AccountEntity(
              id: dto.senderUid.isEmpty ? null : dto.senderUid,
              nickname: dto.senderNickname.isEmpty ? null : dto.senderNickname,
              profileUrl:
                  dto.senderProfileUrl.isEmpty ? null : dto.senderProfileUrl),
          receiver: AccountEntity(
              id: dto.receiverUid.isEmpty ? null : dto.receiverUid,
              nickname:
                  dto.receiverNickname.isEmpty ? null : dto.receiverNickname,
              profileUrl: dto.receiverProfileUrl.isEmpty
                  ? null
                  : dto.receiverProfileUrl),
          content: dto.content.isEmpty ? null : dto.content,
          type: ChatMessageType.values.firstWhere((i) => i.name == dto.type),
          chatId: dto.chatId.isEmpty ? null : dto.chatId,
          isSuccess: dto.isSuccess);
}
