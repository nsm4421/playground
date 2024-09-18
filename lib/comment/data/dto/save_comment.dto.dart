import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'save_comment.dto.freezed.dart';

part 'save_comment.dto.g.dart';

@freezed
class SaveCommentDto with _$SaveCommentDto {
  const factory SaveCommentDto({
    @Default('') String id,
    @Default('') String reference_id,
    @Default('') String reference_table,
    String? parent_id,
    @Default('') String content,
  }) = _SaveCommentDto;

  factory SaveCommentDto.fromJson(Map<String, dynamic> json) =>
      _$SaveCommentDtoFromJson(json);
}
