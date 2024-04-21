import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/entity/feed/comment/feed_comment.entity.dart';

part 'feed_comment.model.freezed.dart';

part 'feed_comment.model.g.dart';

@freezed
class FeedCommentModel with _$FeedCommentModel {
  const factory FeedCommentModel({
    @Default('') String id,
    @Default('') String feed_id,
    @Default('') String user_id,
    @Default('') String nickname,
    @Default('') String profile_image,
    @Default('') String content,
    DateTime? created_at,
  }) = _FeedCommentModel;

  factory FeedCommentModel.fromJson(Map<String, dynamic> json) =>
      _$FeedCommentModelFromJson(json);

  factory FeedCommentModel.fromEntity(FeedCommentEntity entity) =>
      FeedCommentModel(
        id: entity.id ?? '',
        feed_id: entity.feedId ?? '',
        user_id: entity.author?.id ?? '',
        nickname: entity.author?.nickname ?? '',
        profile_image: entity.author?.profileImage ?? '',
        content: entity.content ?? '',
        created_at: entity.createdAt,
      );
}
