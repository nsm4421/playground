import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch.freezed.dart';

part 'fetch.g.dart';

@freezed
class FetchReelsDto with _$FetchReelsDto {
  const factory FetchReelsDto({
    @Default('') String id,
    @Default('') caption,
    @Default('') String video,
    // 작성자
    @Default('') String author_id,
    @Default('') String author_username,
    @Default('') String author_avatar_url,
    // 메타정보
    @Default('') String created_at,
    @Default('') String updated_at,
    @Default(false) bool is_like,
    @Default(0) int like_count,
  }) = _FetchReelsDto;

  factory FetchReelsDto.fromJson(Map<String, dynamic> json) =>
      _$FetchReelsDtoFromJson(json);
}
