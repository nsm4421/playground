import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/domain/model/chat/message.model.dart';
import 'package:my_app/domain/model/user/user.model.dart';

import '../../../core/constant/chat.enum.dart';

part 'message.dto.freezed.dart';

part 'message.dto.g.dart';

@freezed
class MessageDto with _$MessageDto {
  const factory MessageDto({
    @Default('') String messageId,
    @Default('') String chatId,
    @Default(MessageType.text) MessageType type,
    @Default('') String senderUid,
    @Default('') String content,
    @Default(false) bool isSeen,
    DateTime? createdAt,
  }) = _MessageDto;

  factory MessageDto.fromJson(Map<String, dynamic> json) =>
      _$MessageDtoFromJson(json);
}

extension MessageDtoEx on MessageDto {
  MessageModel toModel() => MessageModel(
      messageId: messageId,
      chatId: chatId,
      type: type,
      content: content,
      isSeen: isSeen,
      createdAt: createdAt);
}
