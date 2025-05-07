import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:travel/core/constant/chat.constant.dart';

part 'fetch.freezed.dart';

part 'fetch.g.dart';

@freezed
class FetchPrivateChatDto with _$FetchPrivateChatDto {
  const factory FetchPrivateChatDto({
    @Default('') String id,
    @Default('') String opponent_id,
    @Default('') String opponent_username,
    @Default('') String opponent_avatar_url,
    @Default('') last_message,
    @Default('') String created_at,
    @Default('') String updated_at,
    String? deleted_at,
    @Default('') String last_seen,
    @Default(0) int un_read_cnt,
  }) = _FetchPrivateChatDto;

  factory FetchPrivateChatDto.fromJson(Map<String, dynamic> json) =>
      _$FetchPrivateChatDtoFromJson(json);
}

@freezed
class FetchPrivateMessageDto with _$FetchPrivateMessageDto {
  const factory FetchPrivateMessageDto({
    @Default('') String id,
    @Default('') String chat_id,
    @Default('') String sender_id,
    @Default('') String sender_username,
    @Default('') String sender_avatar_url,
    @Default('') String receiver_id,
    @Default('') String receiver_username,
    @Default('') String receiver_avatar_url,
    @Default(ChatTypes.text) ChatTypes type,
    @Default('') String content,
    @Default('') String created_at,
    String? deleted_at,
  }) = _FetchPrivateMessageDto;

  factory FetchPrivateMessageDto.fromJson(Map<String, dynamic> json) =>
      _$FetchPrivateMessageDtoFromJson(json);
}
