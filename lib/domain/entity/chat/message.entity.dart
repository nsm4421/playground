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
    @Default(true) bool isSender, // 현재 로그인한 유저가 보낸 메세지인지 여부
    UserEntity? receiver,
    MessageType? messageType,
    String? content,
    DateTime? createdAt,
    DateTime? seenAt,
  }) = _MessageEntity;

  factory MessageEntity.fromJson(Map<String, dynamic> json) =>
      _$MessageEntityFromJson(json);

  factory MessageEntity.fromModel({
    required MessageModel model,
    required UserEntity sender,
    required UserEntity receiver,
    required bool isSender,
  }) =>
      MessageEntity(
        id: model.id,
        chatId: model.chatId,
        sender: sender,
        isSender: isSender,
        receiver: receiver,
        messageType: model.messageType,
        content: model.content,
        createdAt: model.createdAt,
        seenAt: model.seenAt,
      );
}
