import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_comment.dto.freezed.dart';

part 'feed_comment.dto.g.dart';

@freezed
class FeedCommentDto with _$FeedCommentDto {
  const factory FeedCommentDto({
    @Default('') String commentId,
    @Default('') String feedId,
    @Default('') String content,
    @Default('') String uid,
    DateTime? createdAt,
  }) = _FeedCommentDto;

  factory FeedCommentDto.fromJson(Map<String, dynamic> json) =>
      _$FeedCommentDtoFromJson(json);
}
