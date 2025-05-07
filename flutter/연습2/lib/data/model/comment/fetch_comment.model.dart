import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../auth/user.model.dart';

part 'fetch_comment.model.freezed.dart';

part 'fetch_comment.model.g.dart';

@freezed
class CommentDto with _$CommentDto {
  const factory CommentDto({
    @Default(0) int id,
    @Default('') String content,
    @Default(UserModel()) UserModel creator,
    @Default('') String createdAt,
    @Default('') String updatedAt,
  }) = _CommentDto;

  factory CommentDto.fromJson(Map<String, dynamic> json) =>
      _$CommentDtoFromJson(json);
}
