import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio/domain/entity/auth/presence.entity.dart';
import 'package:portfolio/domain/entity/emotion/emotion.entity.dart';

import '../../../data/model/feed/comment/feed_comment.model.dart';
import '../../../data/model/feed/comment/feed_comment_for_rpc.model.dart';

part 'feed_comment.entity.freezed.dart';

@freezed
class FeedCommentEntity with _$FeedCommentEntity {
  const factory FeedCommentEntity({
    String? id,
    String? feedId,
    String? content,
    PresenceEntity? createdBy,
    EmotionEntity? emotion,
    DateTime? createdAt,
  }) = _FeedCommentEntity;

  factory FeedCommentEntity.fromModel(FeedCommentModel model) =>
      FeedCommentEntity(
          id: model.id.isNotEmpty ? model.id : null,
          feedId: model.feed_id.isNotEmpty ? model.feed_id : null,
          content: model.content.isNotEmpty ? model.content : null,
          createdBy: PresenceEntity(
              id: model.created_by.isNotEmpty ? model.created_by : null),
          createdAt: model.created_at);

  factory FeedCommentEntity.fromRpcModel(FeedCommentModelForRpc model) =>
      FeedCommentEntity(
          id: model.id.isNotEmpty ? model.id : null,
          feedId: model.feed_id.isNotEmpty ? model.feed_id : null,
          content: model.content.isNotEmpty ? model.content : null,
          emotion: (model.emotion_id != null && model.emotion_type != null)
              ? EmotionEntity(id: model.emotion_id, type: model.emotion_type!)
              : null,
          createdBy: model.author_id.isNotEmpty
              ? PresenceEntity(
                  id: model.author_id,
                  nickname: model.author_nickname,
                  profileImage: model.author_profile_image)
              : null,
          createdAt: model.created_at);
}
