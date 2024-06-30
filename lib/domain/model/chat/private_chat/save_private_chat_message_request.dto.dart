import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/data/entity/chat/chat_message/private_chat_message.entity.dart';

import '../../../../core/constant/dto.constant.dart';

part 'save_private_chat_message_request.dto.freezed.dart';

part 'save_private_chat_message_request.dto.g.dart';

@freezed
class SavePrivateChatMessageRequestDto with _$SavePrivateChatMessageRequestDto {
  const factory SavePrivateChatMessageRequestDto({
    @Default('') String id,
    @Default('') String receiverUid,
    @Default('') String content,
    @Default(ChatMessageType.text) ChatMessageType type,
    @Default('') String chatId,
  }) = _SavePrivateChatMessageRequestDto;

  factory SavePrivateChatMessageRequestDto.fromJson(
          Map<String, dynamic> json) =>
      _$SavePrivateChatMessageRequestDtoFromJson(json);

  factory SavePrivateChatMessageRequestDto.fromEntity(
      PrivateChatMessageEntity entity) {
    return SavePrivateChatMessageRequestDto(
        id: entity.id!,
        receiverUid: entity.receiver!.id!,
        content: entity.content!,
        type: entity.type,
        chatId: entity.chatId!);
  }
}
