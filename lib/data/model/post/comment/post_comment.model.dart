import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_comment.model.freezed.dart';

part 'post_comment.model.g.dart';

@freezed
class PostCommentModel with _$PostCommentModel {
  const factory PostCommentModel({
    @Default('') String id,
    @Default('') String postId,
    String? parentCommentId, // 부모 댓글 id - 해당 컬럼이 null이면 부모 댓글
    @Default('') String uid, // 댓쓴이 id
    @Default('') String content,
    DateTime? createdAt,
  }) = _PostCommentModel;

  factory PostCommentModel.fromJson(Map<String, dynamic> json) =>
      _$PostCommentModelFromJson(json);
}
