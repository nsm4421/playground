import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_feed.dto.freezed.dart';

part 'edit_feed.dto.g.dart';

@freezed
class EditFeedDto with _$EditFeedDto {
  const factory EditFeedDto({
    @Default('') String id,
    String? media,
    String? caption,
    List<String>? hashtags,
    @Default('') String updated_at,
  }) = _EditFeedDto;

  factory EditFeedDto.fromJson(Map<String, dynamic> json) =>
      _$EditFeedDtoFromJson(json);
}
