import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio/features/chat/domain/entity/open_chat.entity.dart';

part 'open_chat.model.freezed.dart';

part 'open_chat.model.g.dart';

@freezed
class OpenChatModel with _$OpenChatModel {
  const factory OpenChatModel({
    @Default('') String id,
    @Default('') String title,
    @Default('') String last_message,
    @Default(<String>[]) List<String> hashtags,
    @Default('') String created_by,
    DateTime? last_talk_at,
    DateTime? created_at,
  }) = _OpenChatModel;

  factory OpenChatModel.fromJson(Map<String, dynamic> json) =>
      _$OpenChatModelFromJson(json);

  factory OpenChatModel.fromEntity(OpenChatEntity entity) => OpenChatModel(
      id: entity.id ?? "",
      title: entity.title ?? "",
      last_message: entity.lastMessage ?? "",
      hashtags: entity.hashtags,
      created_by: entity.createdBy ?? "",
      last_talk_at: entity.lastTalkAt,
      created_at: entity.createdAt);
}
