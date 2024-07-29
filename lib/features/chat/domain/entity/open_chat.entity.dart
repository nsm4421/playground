import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio/features/chat/data/model/open_chat/open_chat.model.dart';

part 'open_chat.entity.freezed.dart';

@freezed
class OpenChatEntity with _$OpenChatEntity {
  const factory OpenChatEntity({
    String? id,
    String? title,
    String? lastMessage,
    @Default(<String>[]) List<String> hashtags,
    String? createdBy,
    DateTime? lastTalkAt,
    DateTime? createdAt,
  }) = _OpenChatEntity;

  factory OpenChatEntity.fromModel(OpenChatModel model) => OpenChatEntity(
      id: model.id.isNotEmpty ? model.id : null,
      title: model.title.isNotEmpty ? model.title : null,
      lastMessage: model.last_message.isNotEmpty ? model.last_message : null,
      hashtags: model.hashtags,
      createdBy: model.created_by.isNotEmpty ? model.created_by : null,
      lastTalkAt: model.last_talk_at,
      createdAt: model.created_at);
}
