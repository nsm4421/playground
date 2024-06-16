import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constant/dto.constant.dart';
import '../../../../data/entity/chat/chat_message/open_chat_message.entity.dart';

part 'open_chat_message.model.freezed.dart';

part 'open_chat_message.model.g.dart';

@freezed
class OpenChatMessageModel with _$OpenChatMessageModel {
  const factory OpenChatMessageModel(
      {@Default('') String id,
      @Default('') String chatId,
      @Default(ChatMessageType.text) ChatMessageType type,
      @Default('') String content,
      String? createdBy,
      DateTime? createdAt}) = _OpenChatMessageModel;

  factory OpenChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$OpenChatMessageModelFromJson(json);

  factory OpenChatMessageModel.fromEntity(OpenChatMessageEntity entity) =>
      OpenChatMessageModel(
          id: entity.id ?? '',
          chatId: entity.chatId ?? '',
          type: entity.type,
          content: entity.content ?? '',
          createdBy: entity.createdBy,
          createdAt: entity.createdAt);
}
