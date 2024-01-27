import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.dto.freezed.dart';

part 'chat_message.dto.g.dart';

@freezed
class ChatMessageDto with _$ChatMessageDto {
  const factory ChatMessageDto({
    @Default('') String? chatRoomId,
    @Default('') String? senderUid,
    @Default('') String? message,
    DateTime? createdAt
  }) = _ChatMessageDto;

  factory ChatMessageDto.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageDtoFromJson(json);
}
