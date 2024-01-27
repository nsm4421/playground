import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/domain/model/feed/child_feed_comment.model.dart';

part 'child_feed_comment.dto.freezed.dart';

part 'child_feed_comment.dto.g.dart';

@freezed
class ChildFeedCommentDto with _$ChildFeedCommentDto {
  const factory ChildFeedCommentDto({
    @Default('') String cid,
    @Default('') String parentCid,
    @Default('') String fid,
    @Default('') String content,
    @Default('') String uid,
    DateTime? createdAt,
  }) = _ChildFeedCommentDto;

  factory ChildFeedCommentDto.fromJson(Map<String, dynamic> json) =>
      _$ChildFeedCommentDtoFromJson(json);
}

extension ChildFeedCommentDtoEx on ChildFeedCommentDto {
  ChildFeedCommentModel toModel() => ChildFeedCommentModel(
      cid: cid,
      parentCid: parentCid,
      fid: fid,
      content: content,
      uid: uid,
      createdAt: createdAt);
}
