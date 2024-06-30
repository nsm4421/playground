import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constant/dto.constant.dart';

part 'private_chat_message.dto.freezed.dart';

part 'private_chat_message.dto.g.dart';

@freezed
class PrivateChatMessageDto with _$PrivateChatMessageDto {
  const factory PrivateChatMessageDto(
      {@Default('') String id,
      DateTime? createdAt,
      @Default('') String senderUid,
      @Default('') String receiverUid,
      @Default('') String content,
      @Default(ChatMessageType.text) ChatMessageType type,
      @Default('') String chatId}) = _PrivateChatMessageDto;

  factory PrivateChatMessageDto.fromJson(Map<String, dynamic> json) =>
      _$PrivateChatMessageDtoFromJson(json);
}
