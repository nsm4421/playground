import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/data/model/chat/chat.model.dart';
import 'package:hot_place/domain/entity/user/user.entity.dart';

part 'chat.entity.freezed.dart';

@freezed
class ChatEntity with _$ChatEntity {
  const factory ChatEntity({
    String? id,
    @Default(UserEntity()) UserEntity sender,
    @Default(UserEntity()) UserEntity receiver,
    String? lastMessage,
    DateTime? createdAt,
    num? unReadCount,
  }) = _ChatEntity;
}

extension ChatEntityEx on ChatEntity {
  ChatModel toModel() => ChatModel(
      id: id ?? '',
      senderUid: sender.uid ?? '',
      receiverUid: receiver.uid ?? '',
      lastMessage: lastMessage ?? '',
      createdAt: createdAt,
      unReadCount: unReadCount ?? 0);
}
