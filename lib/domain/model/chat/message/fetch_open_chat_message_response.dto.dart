import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/data/entity/chat/chat_message/open_chat_message.entity.dart';

import '../../../../core/constant/dto.constant.dart';

part 'fetch_open_chat_message_response.dto.freezed.dart';

part 'fetch_open_chat_message_response.dto.g.dart';

@freezed
class FetchOpenChatMessageResponseDto with _$FetchOpenChatMessageResponseDto {
  const factory FetchOpenChatMessageResponseDto(
      {@Default('') String id,
      @Default('') String chatId,
      @Default(ChatMessageType.text) ChatMessageType type,
      @Default('') String content,
      String? createdBy,
      DateTime? createdAt}) = _FetchOpenChatMessageResponseDto;

  factory FetchOpenChatMessageResponseDto.fromJson(Map<String, dynamic> json) =>
      _$FetchOpenChatMessageResponseDtoFromJson(json);

  factory FetchOpenChatMessageResponseDto.fromEntity(
          OpenChatMessageEntity entity) =>
      FetchOpenChatMessageResponseDto(
          id: entity.id ?? '',
          chatId: entity.chatId ?? '',
          type: entity.type,
          content: entity.content ?? '',
          createdBy: entity.createdBy,
          createdAt: entity.createdAt);
}
