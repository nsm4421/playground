import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/model/feed/comment/feed_comment.model.dart';

part 'feed_comment.entity.freezed.dart';

part 'feed_comment.entity.g.dart';

@freezed
class FeedCommentEntity with _$FeedCommentEntity {
  const factory FeedCommentEntity({
    String? id,
    String? feedId,
    String? content,
    DateTime? createdAt,
    String? createdBy,
  }) = _FeedCommentEntity;

  factory FeedCommentEntity.fromJson(Map<String, dynamic> json) =>
      _$FeedCommentEntityFromJson(json);

  factory FeedCommentEntity.fromModel(FeedCommentModel model) =>
      FeedCommentEntity(
          id: model.id.isEmpty ? null : model.id,
          feedId: model.feedId.isEmpty ? null : model.feedId,
          content: model.content.isEmpty ? null : model.content,
          createdAt:
              model.createdAt == null ? null : DateTime.parse(model.createdAt!),
          createdBy: model.createdBy);
}
