import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/data/model/chat/message.model.dart';
import 'package:hot_place/domain/entity/user/user.entity.dart';

import '../../../core/constant/message.constant.dart';

part 'message.entity.freezed.dart';

part 'message.entity.g.dart';

@freezed
class MessageEntity with _$MessageEntity {
  const factory MessageEntity({
    String? id,
    String? chatId,
    UserEntity? sender,
    UserEntity? receiver,
    MessageType? messageType,
    String? content,
    DateTime? createdAt,
    bool? isSeen,
  }) = _MessageEntity;

  factory MessageEntity.fromJson(Map<String, dynamic> json) =>
      _$MessageEntityFromJson(json);

  static fromModel({
    required MessageModel model,
    required UserEntity sender,
    required UserEntity receiver,
  }) =>
      MessageEntity(
        id: model.id,
        chatId: model.chatId,
        sender: sender,
        receiver: receiver,
        messageType: model.messageType,
        content: model.content,
        createdAt: model.createdAt,
        isSeen: model.isSeen,
      );
}

extension MessageEntityEx on MessageEntity {
  MessageModel toModel() => MessageModel(
        id: id ?? '',
        chatId: chatId ?? '',
        senderUid: sender?.uid ?? '',
        receiverUid: receiver?.uid ?? '',
        messageType: messageType ?? MessageType.text,
        content: content ?? '',
        createdAt: createdAt,
        isSeen: isSeen ?? false,
      );
}
