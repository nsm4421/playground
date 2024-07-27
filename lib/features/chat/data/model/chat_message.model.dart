import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio/features/chat/domain/entity/chat_message.entity.dart';

part 'chat_message.model.freezed.dart';

part 'chat_message.model.g.dart';

@freezed
class ChatMessageModel with _$ChatMessageModel {
  const factory ChatMessageModel({
    @Default('') String id,
    @Default('') String chat_id,
    @Default('') String content,
    @Default('') String created_by,
    DateTime? created_at,
  }) = _ChatMessageModel;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);

  factory ChatMessageModel.fromEntity(ChatMessageEntity entity) =>
      ChatMessageModel(
          id: entity.id ?? "",
          chat_id: entity.chatId ?? "",
          content: entity.content ?? "",
          created_by: entity.sender?.id ?? "",
          created_at: entity.createdAt);
}