import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'likeOnFeed.dto.freezed.dart';
part 'likeOnFeed.dto.g.dart';

@freezed
class LikeOnFeedDto with _$LikeOnFeedDto {
  const factory LikeOnFeedDto({
    @Default('') String id,
    @Default('') String feedId,
    String? createdBy,
    String? createdAt,
  }) = _LikeOnFeedDto;

  factory LikeOnFeedDto.fromJson(Map<String, dynamic> json) =>
      _$LikeOnFeedDtoFromJson(json);
}