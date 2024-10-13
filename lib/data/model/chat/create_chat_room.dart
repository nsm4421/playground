import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_chat_room.freezed.dart';

part 'create_chat_room.g.dart';

@freezed
class CreateOpenChatModel with _$CreateOpenChatModel {
  const factory CreateOpenChatModel({
    @Default('') String title, // 방제
    @Default(<String>[]) List<String> hashtags,
    // 최신 메세지
    @Default('') String last_message_content,
  }) = _CreateOpenChatModel;

  factory CreateOpenChatModel.fromJson(Map<String, dynamic> json) =>
      _$CreateOpenChatModelFromJson(json);
}

@freezed
class CreatePrivateChatModel with _$CreatePrivateChatModel {
  const factory CreatePrivateChatModel({
    @Default('') String id,
    @Default('') String uid,
    @Default('') String opponent_uid,
    // 최신 메세지
    @Default('') String last_message_content,
    @Default('') String last_message_created_at,
    @Default('') String created_at,
  }) = _CreatePrivateChatModel;

  factory CreatePrivateChatModel.fromJson(Map<String, dynamic> json) =>
      _$CreatePrivateChatModelFromJson(json);
}
