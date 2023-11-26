import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed.dto.freezed.dart';

part 'feed.dto.g.dart';

@freezed
class FeedDto with _$FeedDto {
  const factory FeedDto({
    @Default('') String? feedId,
    @Default('') String? content,
    @Default(<String>[]) List<String> hashtags,
    @Default(<String>[]) List<String> images,
    @Default('') String? uid,
    DateTime? createdAt
  }) = _FeedDto;

  factory FeedDto.fromJson(Map<String, dynamic> json) =>
      _$FeedDtoFromJson(json);
}
