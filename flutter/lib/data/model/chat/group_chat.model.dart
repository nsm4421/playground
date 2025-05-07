import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../auth/user.model.dart';

part 'group_chat.model.freezed.dart';
part 'group_chat.model.g.dart';

@freezed
class GroupChatDto with _$GroupChatDto {
  const factory GroupChatDto(
      {@Default('') String id,
        @Default('') String title,
        @Default(<String>[]) List<String> hashtags,
        @Default('') String createdAt,
        @Default('') String updatedAt,
        @Default(UserModel()) UserModel creator}) = _GroupChatDto;

  factory GroupChatDto.fromJson(Map<String, dynamic> json) =>
      _$GroupChatDtoFromJson(json);
}