import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_feed.dto.freezed.dart';

part 'create_feed.dto.g.dart';

@freezed
class CreateFeedDto with _$CreateFeedDto {
  const factory CreateFeedDto({
    @Default('') String id,
    @Default('') String media,
    @Default('') String caption,
    @Default(<String>[]) List<String> hashtags,
    @Default('') String created_by,
    @Default('') String created_at,
  }) = _CreateFeedDto;

  factory CreateFeedDto.fromJson(Map<String, dynamic> json) =>
      _$CreateFeedDtoFromJson(json);
}
