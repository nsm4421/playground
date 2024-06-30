import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/model/chat/open_chat/fetch_open_chat_response.dto.dart';

part 'open_chat.entity.freezed.dart';

@freezed
class OpenChatEntity with _$OpenChatEntity {
  const factory OpenChatEntity({
    String? id,
    String? title,
    String? createdBy,
    DateTime? createdAt,
    DateTime? lastTalkAt,
    String? lastMessage,
  }) = _OpenChatEntity;

  factory OpenChatEntity.fromDto(FetchOpenChatResponseDto dto) {
    if (dto.id.isEmpty) {
      throw ArgumentError('chat id is not given');
    }
    return OpenChatEntity(
        id: dto.id.isEmpty ? null : dto.id,
        title: dto.title.isEmpty ? null : dto.title,
        createdBy: dto.createdBy,
        createdAt: dto.createdAt,
        lastTalkAt: dto.lastTalkAt,
        lastMessage: dto.lastMessage);
  }
}
