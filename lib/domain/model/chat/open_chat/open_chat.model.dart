import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/data/entity/chat/open_chat/open_chat.entity.dart';

part 'open_chat.model.freezed.dart';

part 'open_chat.model.g.dart';

@freezed
class OpenChatModel with _$OpenChatModel {
  const factory OpenChatModel({
    @Default('') String id,
    @Default('') String host_id,
    @Default('') String title,
    @Default(<String>[]) List<String> hashtags,
    DateTime? created_at,
  }) = _OpenChatModel;

  factory OpenChatModel.fromJson(Map<String, dynamic> json) =>
      _$OpenChatModelFromJson(json);

  factory OpenChatModel.fromEntity(OpenChatEntity openChat) => OpenChatModel(
      id: openChat.id ?? '',
      host_id: openChat.host?.id ?? '',
      title: openChat.title ?? '',
      hashtags: openChat.hashtags,
      created_at: openChat.createdAt);
}
