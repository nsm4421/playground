import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:hot_place/domain/model/feed/comment/feed_comment.model.dart';

part 'feed_comment.entity.freezed.dart';

part 'feed_comment.entity.g.dart';

@freezed
class FeedCommentEntity with _$FeedCommentEntity {
  const factory FeedCommentEntity({
    String? id,
    String? feedId,
    UserEntity? author, // 댓쓴이
    String? content,
    DateTime? createdAt,
  }) = _FeedCommentEntity;

  factory FeedCommentEntity.fromJson(Map<String, dynamic> json) =>
      _$FeedCommentEntityFromJson(json);

  factory FeedCommentEntity.fromModel(FeedCommentModel model) =>
      FeedCommentEntity(
          id: model.id.isNotEmpty ? model.id : null,
          feedId: model.feed_id.isNotEmpty ? model.feed_id : null,
          author: UserEntity(
            id: model.user_id.isNotEmpty ? model.user_id : null,
            nickname: model.nickname.isNotEmpty ? model.nickname : null,
            profileImage:
                model.profile_image.isNotEmpty ? model.profile_image : null,
          ),
          content: model.content.isNotEmpty ? model.content : null,
          createdAt: model.created_at);
}
