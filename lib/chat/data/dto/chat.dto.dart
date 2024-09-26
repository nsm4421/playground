import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat.dto.freezed.dart';

part 'chat.dto.g.dart';

@freezed
class CreateChatDto with _$CreateChatDto {
  const factory CreateChatDto({
    @Default('') String id,
    @Default('') String uid,
    @Default('') String opponent_uid,
    // 최신 메세지
    String? last_message_id,
    String? last_message_content,
    DateTime? last_message_created_at,
    DateTime? created_at,
  }) = _CreateChatDto;

  factory CreateChatDto.fromJson(Map<String, dynamic> json) =>
      _$CreateChatDtoFromJson(json);
}

@freezed
class FetchChatDto with _$FetchChatDto {
  const factory FetchChatDto({
    @Default('') String id,
    // 현재 유저id
    @Default('') String uid,
    // 대화방 유저
    @Default('') String opponent_uid,
    @Default('') String opponent_username,
    @Default('') String opponent_avatar_url,
    // 최신 메세지
    String? last_message_id,
    String? last_message_content,
    DateTime? last_message_created_at,
    // 읽지 않은 메세지 개수
    @Default(0) un_read_message_count,
  }) = _FetchChatDto;

  factory FetchChatDto.fromJson(Map<String, dynamic> json) =>
      _$FetchChatDtoFromJson(json);
}
