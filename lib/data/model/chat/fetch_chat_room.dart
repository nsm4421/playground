import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_chat_room.freezed.dart';

part 'fetch_chat_room.g.dart';

@freezed
class FetchOpenChatModel with _$FetchOpenChatModel {
  const factory FetchOpenChatModel({
    @Default('') String id,
    @Default('') String title, // 방제
    @Default(<String>[]) List<String> hashtags,
    // 최신 메세지
    @Default('') String last_message_content,
    @Default('') String last_message_created_at,
    // 메타정보
    @Default('') String created_at,
    // 방장 정보
    @Default('') String host_uid,
    @Default('') String host_username,
    @Default('') String host_avatar_url,
  }) = _FetchOpenChatModel;

  factory FetchOpenChatModel.fromJson(Map<String, dynamic> json) =>
      _$FetchOpenChatModelFromJson(json);
}

@freezed
class FetchPrivateChatModel with _$FetchPrivateChatModel {
  const factory FetchPrivateChatModel({
    @Default('') String id,
    @Default('') String uid,
    @Default('') String opponent_uid,
    @Default('') String opponent_username,
    @Default('') String opponent_avatar_url,
    // 최신 메세지
    @Default('') String last_message_content,
    @Default('') String last_message_created_at,
    @Default('') String created_at,
  }) = _FetchPrivateChatModel;

  factory FetchPrivateChatModel.fromJson(Map<String, dynamic> json) =>
      _$FetchPrivateChatModelFromJson(json);
}
