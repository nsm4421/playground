import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/data/model/auth/author.model.dart';
import 'package:my_app/data/model/chat/fetch_chat.model.dart';

part 'message.model.freezed.dart';

part 'message.model.g.dart';

@freezed
class MessageDto with _$MessageDto {
  const factory MessageDto({
    @Default('') String id,
    @Default('') String content,
    @Default(AuthorDto()) AuthorDto creator,
    @Default(GroupChatDto()) GroupChatDto chat,
    @Default('') String createdAt,
    @Default('') String updatedAt,
    String? deletedAt,
  }) = _MessageDto;

  factory MessageDto.fromJson(Map<String, dynamic> json) =>
      _$MessageDtoFromJson(json);
}
