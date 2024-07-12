import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/data/entity/feed/base/feed.entity.dart';

import '../../../../core/constant/dto.constant.dart';

part 'save_feed_request.dto.freezed.dart';

part 'save_feed_request.dto.g.dart';

@freezed
class SaveFeedRequestDto with _$SaveFeedRequestDto {
  const factory SaveFeedRequestDto({
    @Default('') String content,
    @Default('') String caption,
    String? media,
    @Default(MediaType.image) MediaType type,
    @Default(<String>[]) List<String> hashtags,
  }) = _SaveFeedRequestDto;

  factory SaveFeedRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SaveFeedRequestDtoFromJson(json);

  factory SaveFeedRequestDto.fromEntity(FeedEntity entity) {
    if (entity.content == null || entity.caption == null) {
      throw ArgumentError('content or caption value is null');
    }
    return SaveFeedRequestDto(
        content: entity.content!,
        caption: entity.caption!,
        media: entity.media,
        type: entity.type,
        hashtags: entity.hashtags);
  }
}
