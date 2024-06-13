import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constant/dto.constant.dart';
import '../../../../data/entity/chat/message/chat_message.entity.dart';

part 'chat_message.model.freezed.dart';

part 'chat_message.model.g.dart';

@freezed
class ChatMessageModel with _$ChatMessageModel {
  const factory ChatMessageModel(
      {@Default('') String id,
      @Default('') String chatId,
      @Default(ChatMessageType.text) ChatMessageType type,
      @Default('') String content,
      String? createdAt,
      String? senderUid,
      String? receiverUid}) = _ChatMessageModel;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);

  factory ChatMessageModel.fromEntity(ChatMessageEntity entity) =>
      ChatMessageModel(
        id: entity.id ?? '',
        chatId: entity.chatId ?? '',
        content: entity.content ?? '',
        type: entity.type ?? ChatMessageType.text,
        createdAt: entity.createdAt,
        senderUid: entity.senderUid,
        receiverUid: entity.receiverUid,
      );
}
