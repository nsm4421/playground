import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch.freezed.dart';

part 'fetch.g.dart';

@freezed
class FetchFeedDto with _$FetchFeedDto {
  const factory FetchFeedDto({
    @Default('') String id,
    @Default('') String content,
    @Default(<String>[]) List<String> hashtags,
    @Default(<String>[]) List<String> captions,
    @Default(<String>[]) List<String> images,
    // 작성자
    @Default('') String author_id,
    @Default('') String author_username,
    @Default('') String author_avatar_url,
    // 메타정보
    @Default('') String created_at,
    @Default('') String updated_at,
    // 좋아요
    @Default(false) bool is_like,
    @Default(0) int like_count,
    // 최근댓글
    String? latest_comment,
  }) = _FetchFeedDto;

  factory FetchFeedDto.fromJson(Map<String, dynamic> json) =>
      _$FetchFeedDtoFromJson(json);
}
