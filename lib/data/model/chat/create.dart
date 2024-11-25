import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:travel/core/constant/chat.constant.dart';

part 'create.freezed.dart';

part 'create.g.dart';

@freezed
class CreatePrivateChatDto with _$CreatePrivateChatDto {
  const factory CreatePrivateChatDto({
    @Default('') String opponent_id,
    @Default('') last_message,
  }) = _CreatePrivateChatDto;

  factory CreatePrivateChatDto.fromJson(Map<String, dynamic> json) =>
      _$CreatePrivateChatDtoFromJson(json);
}

@freezed
class CreatePrivateMessageDto with _$CreatePrivateMessageDto {
  const factory CreatePrivateMessageDto({
    @Default('') String chat_id,
    @Default('') String receiver_id,
    @Default('') String content,
    @Default(ChatTypes.text) ChatTypes type,
  }) = _CreatePrivateMessageDto;

  factory CreatePrivateMessageDto.fromJson(Map<String, dynamic> json) =>
      _$CreatePrivateMessageDtoFromJson(json);
}
