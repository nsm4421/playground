import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/constant/message.constant.dart';
import '../../../domain/entity/chat/message.entity.dart';

part 'message.model.freezed.dart';

part 'message.model.g.dart';

@freezed
class MessageModel with _$MessageModel {
  const factory MessageModel({
    @Default('') String id,
    @Default('') String chatId,
    @Default('') String senderUid,
    @Default('') String receiverUid,
    @Default(MessageType.text) MessageType messageType,
    @Default('') String content,
    DateTime? createdAt,
    DateTime? seenAt,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  factory MessageModel.fromEntity(MessageEntity entity) => MessageModel(
        id: entity.id ?? '',
        chatId: entity.chatId ?? '',
        senderUid: entity.sender?.uid ?? '',
        receiverUid: entity.receiver?.uid ?? '',
        messageType: entity.messageType ?? MessageType.text,
        content: entity.content ?? '',
        createdAt: entity.createdAt,
        seenAt: entity.seenAt,
      );
}
