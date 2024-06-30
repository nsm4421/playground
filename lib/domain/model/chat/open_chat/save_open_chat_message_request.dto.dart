import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/data/entity/chat/chat_message/open_chat_message.entity.dart';

import '../../../../core/constant/dto.constant.dart';

part 'save_open_chat_message_request.dto.freezed.dart';

part 'save_open_chat_message_request.dto.g.dart';

@freezed
class SaveOpenChatMessageRequestDto with _$SaveOpenChatMessageRequestDto {
  const factory SaveOpenChatMessageRequestDto({
    @Default('') String chatId,
    @Default(ChatMessageType.text) ChatMessageType type,
    @Default('') String content,
  }) = _SaveOpenChatMessageRequestDto;

  factory SaveOpenChatMessageRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SaveOpenChatMessageRequestDtoFromJson(json);

  factory SaveOpenChatMessageRequestDto.fromEntity(
      OpenChatMessageEntity entity) {
    if (entity.chatId == null || entity.content == null) {
      throw ArgumentError('chat id or content is not given');
    }
    return SaveOpenChatMessageRequestDto(
        chatId: entity.chatId!, type: entity.type, content: entity.content!);
  }
}
