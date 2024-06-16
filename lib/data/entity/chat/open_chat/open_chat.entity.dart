import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/domain/model/chat/base/open_chat.model.dart';

part 'open_chat.entity.freezed.dart';

@freezed
class OpenChatEntity with _$OpenChatEntity {
  const factory OpenChatEntity({
    String? id,
    String? title,
    String? createdBy,
    DateTime? createdAt,
    DateTime? lastTalkAt,
    String? lastMessage,
  }) = _OpenChatEntity;

  factory OpenChatEntity.fromModel(OpenChatModel model) => OpenChatEntity(
      id: model.id.isEmpty ? null : model.id,
      title: model.title.isEmpty ? null : model.title,
      createdBy: model.createdBy,
      createdAt: model.createdAt,
      lastTalkAt: model.lastTalkAt,
      lastMessage: model.lastMessage.isEmpty ? null : model.lastMessage);
}
