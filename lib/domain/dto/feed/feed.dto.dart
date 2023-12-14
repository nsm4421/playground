import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed.dto.freezed.dart';

part 'feed.dto.g.dart';

@freezed
class FeedDto with _$FeedDto {
  const factory FeedDto({
    @Default('') String fid,
    @Default('') String uid,
    @Default('') String profileImageUrl,
    @Default('') String message,
    DateTime? createdAt,
    @Default(0) int likeCount,
    @Default(0) int shareCount,
    @Default(0) int commentCount,
  }) = _FeedDto;

  factory FeedDto.fromJson(Map<String, dynamic> json) =>
      _$FeedDtoFromJson(json);
}
