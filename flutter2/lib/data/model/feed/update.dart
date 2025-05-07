import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update.freezed.dart';

part 'update.g.dart';

@freezed
class UpdateFeedDto with _$UpdateFeedDto {
  const factory UpdateFeedDto({
    List<String>? hashtags,
    List<String>? captions,
    List<String>? images,
  }) = _UpdateFeedDto;

  factory UpdateFeedDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateFeedDtoFromJson(json);
}
