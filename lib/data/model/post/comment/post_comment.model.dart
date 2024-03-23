import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/domain/entity/post/comment/post_comment.entity.dart';

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

  factory PostCommentModel.fromEntity(PostCommentEntity entity) =>
      PostCommentModel(
          id: entity.id ?? '',
          postId: entity.postId ?? '',
          parentCommentId: entity.parentCommentId,
          uid: entity.user?.uid ?? '',
          content: entity.content ?? '',
          createdAt: entity.createdAt);
}
