import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.entity.freezed.dart';

@freezed
class ChatMessageEntity with _$ChatMessageEntity {
  const factory ChatMessageEntity({
    String? id,
    String? chatId,
    String? content,
    String? sender,
    DateTime? createdAt,
  }) = _ChatMessageEntity;
}
