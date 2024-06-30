import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/data/entity/feed/comment/feed_comment.entity.dart';

part 'save_feed_comment_request.dto.freezed.dart';

part 'save_feed_comment_request.dto.g.dart';

@freezed
class SaveFeedCommentRequestDto with _$SaveFeedCommentRequestDto {
  const factory SaveFeedCommentRequestDto({
    @Default('') String feedId,
    @Default('') String content,
  }) = _SaveFeedCommentRequestDto;

  factory SaveFeedCommentRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SaveFeedCommentRequestDtoFromJson(json);

  factory SaveFeedCommentRequestDto.fromEntity(FeedCommentEntity entity) {
    if (entity.feedId == null) {
      throw ArgumentError('feed id is not given');
    } else if (entity.content == null) {
      throw ArgumentError('comment content is empty');
    }
    return SaveFeedCommentRequestDto(
        feedId: entity.feedId!, content: entity.content!);
  }
}
