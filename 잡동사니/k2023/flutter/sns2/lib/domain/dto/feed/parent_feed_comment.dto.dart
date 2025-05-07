import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/domain/model/feed/parent_feed_comment.model.dart';

part 'parent_feed_comment.dto.freezed.dart';

part 'parent_feed_comment.dto.g.dart';

@freezed
class ParentFeedCommentDto with _$ParentFeedCommentDto {
  const factory ParentFeedCommentDto({
    @Default('') String cid,
    @Default('') String fid,
    @Default('') String content,
    @Default('') String uid,
    @Default(<String>[]) List<String> childCidList,
    DateTime? createdAt,
  }) = _ParentFeedCommentDto;

  factory ParentFeedCommentDto.fromJson(Map<String, dynamic> json) =>
      _$ParentFeedCommentDtoFromJson(json);
}

extension ParentFeedCommentDtoEx on ParentFeedCommentDto {
  ParentFeedCommentModel toModel() => ParentFeedCommentModel(
      cid: cid,
      fid: fid,
      content: content,
      uid: uid,
      createdAt: createdAt,
      childCommentCount: childCidList.length);
}
