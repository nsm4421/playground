import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/data/model/auth/author.model.dart';

part 'fetch_chat.model.freezed.dart';

part 'fetch_chat.model.g.dart';

@freezed
class GroupChatDto with _$GroupChatDto {
  const factory GroupChatDto({
    @Default('') String id,
    @Default('') String title,
    @Default(<String>[]) List<String> hashtags,
    @Default('') String createdAt,
    @Default('') String updatedAt,
    @Default(AuthorDto()) AuthorDto creater
  }) = _GroupChatDto;

  factory GroupChatDto.fromJson(Map<String, dynamic> json) =>
      _$GroupChatDtoFromJson(json);
}
