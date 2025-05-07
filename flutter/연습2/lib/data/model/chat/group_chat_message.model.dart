import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../auth/user.model.dart';
import 'group_chat.model.dart';

part 'group_chat_message.model.freezed.dart';
part 'group_chat_message.model.g.dart';

@freezed
class GroupChatMessageDto with _$GroupChatMessageDto {
  const factory GroupChatMessageDto({
    @Default('') String id,
    @Default('') String content,
    @Default(UserModel()) UserModel creator,
    @Default(GroupChatDto()) GroupChatDto chat,
    @Default('') String createdAt,
    @Default('') String updatedAt,
    String? deletedAt,
  }) = _GroupChatMessageDto;

  factory GroupChatMessageDto.fromJson(Map<String, dynamic> json) =>
      _$GroupChatMessageDtoFromJson(json);
}
