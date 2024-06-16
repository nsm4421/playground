import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/data/entity/chat/open_chat/open_chat.entity.dart';

part 'open_chat.model.freezed.dart';

part 'open_chat.model.g.dart';

@freezed
class OpenChatModel with _$OpenChatModel {
  const factory OpenChatModel({
    @Default('') String id,
    @Default('') String title,
    String? createdBy,
    DateTime? createdAt,
    DateTime? lastTalkAt,
    @Default('') String lastMessage,
  }) = _OpenChatModel;

  factory OpenChatModel.fromJson(Map<String, dynamic> json) =>
      _$OpenChatModelFromJson(json);

  factory OpenChatModel.fromEntity(OpenChatEntity entity) => OpenChatModel(
      id: entity.id ?? '',
      title: entity.title ?? '',
      createdBy: entity.createdBy,
      createdAt: entity.createdAt,
      lastTalkAt: entity.lastTalkAt,
      lastMessage: entity.lastMessage ?? '');
}
