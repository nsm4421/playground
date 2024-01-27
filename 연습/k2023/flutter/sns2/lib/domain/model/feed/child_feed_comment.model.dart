import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'child_feed_comment.model.freezed.dart';

part 'child_feed_comment.model.g.dart';

@freezed
class ChildFeedCommentModel with _$ChildFeedCommentModel {
  const factory ChildFeedCommentModel({
    String? cid,
    String? parentCid,
    String? fid,
    String? content,
    String? uid,
    DateTime? createdAt,
    String? nickname,
    String? profileUrl,
  }) = _ChildFeedCommentModel;

  factory ChildFeedCommentModel.fromJson(Map<String, dynamic> json) =>
      _$ChildFeedCommentModelFromJson(json);
}
