import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/domain/model/feed/like/like_feed.model.dart';

part 'like_feed.entity.freezed.dart';

@freezed
class LikeFeedEntity with _$LikeFeedEntity {
  const factory LikeFeedEntity({
    String? userId,
    String? feedId,
    DateTime? createdAt,
  }) = _LikeFeedEntity;

  factory LikeFeedEntity.fromModel(LikeFeedModel like) => LikeFeedEntity(
      userId: like.user_id.isNotEmpty ? like.user_id : null,
      feedId: like.feed_id.isNotEmpty ? like.feed_id : null,
      createdAt: like.created_at);
}
