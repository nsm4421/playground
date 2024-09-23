import 'package:flutter/foundation.dart';
import 'package:flutter_app/shared/constant/constant.export.dart';
import 'package:flutter_app/shared/constant/dto/author.dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_feed_comments.dto.freezed.dart';

part 'fetch_feed_comments.dto.g.dart';

@freezed
class FetchParentCommentDto with _$FetchParentCommentDto {
  const factory FetchParentCommentDto({
    @Default('') String id,
    @Default('') String content,
    DateTime? created_at,
    @Default('') String author_id,
    @Default('') String author_username,
    @Default('') String author_avatar_url,
    @Default(0) int child_comment_count,
  }) = _FetchParentCommentDto;

  factory FetchParentCommentDto.fromJson(Map<String, dynamic> json) =>
      _$FetchParentCommentDtoFromJson(json);
}

@freezed
class FetchChildCommentDto with _$FetchChildCommentDto {
  const factory FetchChildCommentDto({
    @Default('') String id, // 자식댓글 id
    @Default('') String parent_id, // 부모댓글 id
    @Default('') String content,
    DateTime? created_at,
    @Default(AuthorDto()) AuthorDto author,
  }) = _FetchChildCommentDto;

  factory FetchChildCommentDto.fromJson(Map<String, dynamic> json) =>
      _$FetchChildCommentDtoFromJson(json);
}
