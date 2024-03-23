import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/data/model/post/comment/post_comment.model.dart';
import 'package:hot_place/domain/entity/user/user.entity.dart';

part 'post_comment.entity.freezed.dart';

part 'post_comment.entity.g.dart';

@freezed
class PostCommentEntity with _$PostCommentEntity {
  const factory PostCommentEntity({
    String? id,
    String? postId,
    String? parentCommentId,
    UserEntity? user,
    String? content,
    DateTime? createdAt,
  }) = _PostCommentEntity;

  factory PostCommentEntity.fromJson(Map<String, dynamic> json) =>
      _$PostCommentEntityFromJson(json);

  static PostCommentEntity fromModel({
    required PostCommentModel comment,
    required UserEntity user,
  }) =>
      PostCommentEntity(
          id: comment.id,
          postId: comment.id,
          parentCommentId: comment.parentCommentId,
          user: user,
          createdAt: comment.createdAt);
}
