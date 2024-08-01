import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entity/chat/open_chat_message.entity.dart';

part 'open_chat_message.model.freezed.dart';

part 'open_chat_message.model.g.dart';

@freezed
class OpenChatMessageModel with _$OpenChatMessageModel {
  const factory OpenChatMessageModel({
    @Default('') String id,
    @Default('') String chat_id,
    @Default('') String content,
    @Default('') String created_by,
    DateTime? created_at,
  }) = _OpenChatMessageModel;

  factory OpenChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$OpenChatMessageModelFromJson(json);

  factory OpenChatMessageModel.fromEntity(OpenChatMessageEntity entity) =>
      OpenChatMessageModel(
          id: entity.id ?? "",
          chat_id: entity.chatId ?? "",
          content: entity.content ?? "",
          created_by: entity.sender?.id ?? "",
          created_at: entity.createdAt);
}
