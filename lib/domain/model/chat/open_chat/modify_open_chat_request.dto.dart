import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'modify_open_chat_request.dto.freezed.dart';

part 'modify_open_chat_request.dto.g.dart';

@freezed
class ModifyOpenChatRequestDto with _$ModifyOpenChatRequestDto {
  const factory ModifyOpenChatRequestDto(
      {@Default('') String chatId,
      String? title,
      DateTime? lastTalkAt,
      String? lastMessage}) = _ModifyOpenChatRequestDto;

  factory ModifyOpenChatRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ModifyOpenChatRequestDtoFromJson(json);
}
