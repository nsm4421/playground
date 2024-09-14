import 'package:flutter/foundation.dart';
import 'package:flutter_app/auth/domain/domain.export.dart';
import 'package:flutter_app/auth/domain/entity/presence.entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_feed.dto.freezed.dart';

part 'fetch_feed.dto.g.dart';

@freezed
class FetchFeedDto with _$FetchFeedDto {
  const factory FetchFeedDto({
    @Default('') String id,
    @Default('') String media,
    @Default('') String caption,
    @Default(<String>[]) List<String> hashtags,
    @Default('') String created_at,
    @Default('') String updated_at,
    // 작성자
    @Default(AuthorDto()) AuthorDto author,
  }) = _FetchFeedDto;

  factory FetchFeedDto.fromJson(Map<String, dynamic> json) =>
      _$FetchFeedDtoFromJson(json);
}

@freezed
class AuthorDto with _$AuthorDto {
  const factory AuthorDto({
    @Default('') String id,
    @Default('') String username,
    @Default('') String avatar_url,
  }) = _AuthorDto;

  factory AuthorDto.fromJson(Map<String, dynamic> json) =>
      _$AuthorDtoFromJson(json);
}