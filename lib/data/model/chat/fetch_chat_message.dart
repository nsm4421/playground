import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_chat_message.freezed.dart';

part 'fetch_chat_message.g.dart';

@freezed
class FetchOpenChatMessageModel with _$FetchOpenChatMessageModel {
  const factory FetchOpenChatMessageModel({
    @Default('') String id,
    @Default('') String chat_id,
    @Default('') String content,
    String? media,
    @Default('') String created_at,
    @Default('') String sender_uid,
    @Default('') String sender_username,
    @Default('') String sender_avatar_url,
  }) = _FetchOpenChatMessageModel;

  factory FetchOpenChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$FetchOpenChatMessageModelFromJson(json);
}

@freezed
class FetchPrivateChatMessageModel with _$FetchPrivateChatMessageModel {
  const factory FetchPrivateChatMessageModel({
    @Default('') String id,
    @Default('') String chat_id,
    @Default('') String sender_uid,
    @Default('') String sender_username,
    @Default('') String sender_avatar_url,
    @Default('') String receiver_uid,
    @Default('') String receiver_username,
    @Default('') String receiver_avatar_url,
    @Default('') String content,
    String? media,
    @Default('') String created_at,
    @Default('') String created_by,
  }) = _FetchPrivateChatMessageModel;

  factory FetchPrivateChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$FetchPrivateChatMessageModelFromJson(json);
}
