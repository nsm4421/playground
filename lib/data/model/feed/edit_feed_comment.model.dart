import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_feed_comment.model.freezed.dart';

part 'edit_feed_comment.model.g.dart';

@freezed
class CreateFeedCommentDto with _$CreateFeedCommentDto {
  const factory CreateFeedCommentDto({
    @Default(0) int feedId,
    @Default('') String content,
  }) = _CreateFeedCommentDto;

  factory CreateFeedCommentDto.fromJson(Map<String, dynamic> json) =>
      _$CreateFeedCommentDtoFromJson(json);
}

@freezed
class ModifyFeedCommentDto with _$ModifyFeedCommentDto {
  const factory ModifyFeedCommentDto({
    @Default(0) int commentId,
    @Default('') String content,
  }) = _ModifyFeedCommentDto;

  factory ModifyFeedCommentDto.fromJson(Map<String, dynamic> json) =>
      _$ModifyFeedCommentDtoFromJson(json);
}
