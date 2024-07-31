import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio/features/auth/domain/entity/presence.entity.dart';
import 'package:portfolio/features/emotion/core/constant/emotion_type.dart';
import 'package:portfolio/features/feed/data/model/comment/feed_comment.model.dart';
import 'package:portfolio/features/feed/data/model/comment/feed_comment_for_rpc.model.dart';

part 'feed_comment.entity.freezed.dart';

@freezed
class FeedCommentEntity with _$FeedCommentEntity {
  const factory FeedCommentEntity({
    String? id,
    String? feedId,
    String? content,
    PresenceEntity? createdBy,
    EmotionType? emotion,
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
          emotion: model.emotion?.type,
          createdBy: PresenceEntity.fromModel(model.created_by),
          createdAt: model.created_at);
}
