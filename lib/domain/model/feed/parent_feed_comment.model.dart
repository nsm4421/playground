import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'parent_feed_comment.model.freezed.dart';

part 'parent_feed_comment.model.g.dart';

@freezed
class ParentFeedCommentModel with _$ParentFeedCommentModel {
  const factory ParentFeedCommentModel({
    String? cid,
    String? fid,
    String? content,
    String? uid,
    DateTime? createdAt,
    String? nickname,
    String? profileUrl,
    int? childCommentCount,
  }) = _ParentFeedCommentModel;

  factory ParentFeedCommentModel.fromJson(Map<String, dynamic> json) =>
      _$ParentFeedCommentModelFromJson(json);
}
