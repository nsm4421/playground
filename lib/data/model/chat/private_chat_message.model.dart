import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../auth/user.model.dart';

part 'private_chat_message.model.freezed.dart';

part 'private_chat_message.model.g.dart';

@freezed
class PrivateChatMessageDto with _$PrivateChatMessageDto {
  const factory PrivateChatMessageDto({
    @Default('') String id,
    @Default('') String content,
    @Default(UserModel()) UserModel sender,
    @Default(UserModel()) UserModel receiver,
    @Default('') String createdAt,
    @Default('') String updatedAt,
    String? deletedAt,
  }) = _PrivateChatMessageDto;

  factory PrivateChatMessageDto.fromJson(Map<String, dynamic> json) =>
      _$PrivateChatMessageDtoFromJson(json);
}
