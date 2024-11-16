import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch.freezed.dart';

part 'fetch.g.dart';

@freezed
class FetchCommentDto with _$FetchCommentDto {
  const factory FetchCommentDto({
    @Default('') String id,
    String? parent_id,
    @Default('') String reference_id,
    @Default('') String reference_table,
    @Default('') String content,
    @Default('') String author_uid,
    @Default('') String author_username,
    @Default('') String author_avatar_url,
  }) = _FetchCommentDto;

  factory FetchCommentDto.fromJson(Map<String, dynamic> json) =>
      _$FetchCommentDtoFromJson(json);
}
