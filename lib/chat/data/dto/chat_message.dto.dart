import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../constant/chat_type.dart';

part 'chat_message.dto.freezed.dart';

part 'chat_message.dto.g.dart';

@freezed
class CreateChatMessageDto with _$CreateChatMessageDto {
  const factory CreateChatMessageDto({
    @Default('') String id,
    @Default('') String uid,
    @Default('') String chat_id,
    @Default(ChatMessageType.text) ChatMessageType type,
    @Default('') String content,
    @Default(false) bool is_seen,
    @Default('') String sender_uid,
    @Default('') String receiver_uid,
    DateTime? created_at,
  }) = _CreateChatMessageDto;

  factory CreateChatMessageDto.fromJson(Map<String, dynamic> json) =>
      _$CreateChatMessageDtoFromJson(json);
}

@freezed
class FetchChatMessageDto with _$FetchChatMessageDto {
  const factory FetchChatMessageDto({
    @Default('') String id,
    @Default('') String uid, // 해당 레코드를 조회할 수 있는 유저 id
    @Default('') String chat_id,
    @Default(ChatMessageType.text) ChatMessageType type,
    @Default('') String content,
    @Default(false) bool is_seen,
    @Default('') String sender_uid,
    @Default('') String sender_username,
    @Default('') String sender_avatar_url,
    @Default('') String receiver_uid,
    @Default('') String receiver_username,
    @Default('') String receiver_avatar_url,
    DateTime? created_at,
  }) = _FetchChatMessageDto;

  factory FetchChatMessageDto.fromJson(Map<String, dynamic> json) =>
      _$FetchChatMessageDtoFromJson(json);
}
