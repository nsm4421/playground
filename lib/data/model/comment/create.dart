import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create.freezed.dart';

part 'create.g.dart';

@freezed
class CreateCommentDto with _$CreateCommentDto {
  const factory CreateCommentDto({
    @Default('') String id,
    String? parent_id,
    @Default('') String reference_id,
    @Default('') String reference_table,
    @Default('') String content,
  }) = _CreateCommentDto;

  factory CreateCommentDto.fromJson(Map<String, dynamic> json) =>
      _$CreateCommentDtoFromJson(json);
}
