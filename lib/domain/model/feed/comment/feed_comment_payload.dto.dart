import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_comment_payload.dto.freezed.dart';

part 'feed_comment_payload.dto.g.dart';

@freezed
class FeedCommentPayloadDto with _$FeedCommentPayloadDto {
  const factory FeedCommentPayloadDto({
    @Default('') String id,
    @Default('') String feedId,
    @Default('') String content,
    DateTime? createdAt,
    @Default('') String createdBy,
  }) = _FeedCommentPayloadDto;

  factory FeedCommentPayloadDto.fromJson(Map<String, dynamic> json) =>
      _$FeedCommentPayloadDtoFromJson(json);
}
