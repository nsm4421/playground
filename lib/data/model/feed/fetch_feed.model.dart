import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_feed.model.freezed.dart';

part 'fetch_feed.model.g.dart';

@freezed
class FeedDto with _$FeedDto {
  const factory FeedDto({
    @Default(0) int id,
    @Default('') String content,
    @Default(<String>[]) List<String> images,
    @Default(<String>[]) List<String> hashtags,
    @Default(AuthorDto()) AuthorDto author,
    @Default('') String createdAt,
    @Default('') String updatedAt,
  }) = _FeedDto;

  factory FeedDto.fromJson(Map<String, dynamic> json) =>
      _$FeedDtoFromJson(json);
}

@freezed
class AuthorDto with _$AuthorDto {
  const factory AuthorDto({@Default('') String id}) = _AuthorDto;

  factory AuthorDto.fromJson(Map<String, dynamic> json) =>
      _$AuthorDtoFromJson(json);
}
