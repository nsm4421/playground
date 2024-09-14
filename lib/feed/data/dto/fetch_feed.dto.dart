import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/shared.export.dart';

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
