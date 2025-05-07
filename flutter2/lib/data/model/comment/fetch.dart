import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch.freezed.dart';

part 'fetch.g.dart';

@freezed
class FetchCommentDto with _$FetchCommentDto {
  const factory FetchCommentDto({
    @Default('') String id,
    @Default('') String content,
    @Default('') String reference_id,
    @Default('') String reference_table,
    String? parent_id,
    @Default('') String created_at,
    @Default('') String updated_at,
    @Default(0) int child_count,
    // 작성자
    @Default('') String author_id,
    @Default('') String author_username,
    @Default('') String author_avatar_url,
    // 좋아요
    @Default(false) bool is_like,
    @Default(0) int like_count,
  }) = _FetchCommentDto;

  factory FetchCommentDto.fromJson(Map<String, dynamic> json) =>
      _$FetchCommentDtoFromJson(json);
}
