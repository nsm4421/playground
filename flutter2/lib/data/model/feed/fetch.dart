import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch.freezed.dart';

part 'fetch.g.dart';

@freezed
class FetchFeedReqDto with _$FetchFeedReqDto {
  const factory FetchFeedReqDto({
    String? search_field,
    String? search_text,
    @Default('') String before_at,
    @Default(20) int take,
  }) = _FetchFeedReqDto;
}

extension FetchFeedReqDtoExt on FetchFeedReqDto {
  Map<String, dynamic> get rpcParam => Map<String, dynamic>.of({
        '_search_field': search_field,
        '_search_text': search_text,
        '_before_at': before_at,
        '_take': take,
      });
}

@freezed
class FetchFeedResDto with _$FetchFeedResDto {
  const factory FetchFeedResDto({
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
  }) = _FetchFeedResDto;

  factory FetchFeedResDto.fromJson(Map<String, dynamic> json) =>
      _$FetchFeedResDtoFromJson(json);
}
