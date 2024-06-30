import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_open_chat_response.dto.freezed.dart';

part 'fetch_open_chat_response.dto.g.dart';

@freezed
class FetchOpenChatResponseDto with _$FetchOpenChatResponseDto {
  const factory FetchOpenChatResponseDto({
    @Default('') String id,
    @Default('') String title,
    DateTime? createdAt,
    String? createdBy,
    DateTime? lastTalkAt,
    String? lastMessage,
  }) = _FetchOpenChatResponseDto;

  factory FetchOpenChatResponseDto.fromJson(Map<String, dynamic> json) =>
      _$FetchOpenChatResponseDtoFromJson(json);
}
