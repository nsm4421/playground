import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/domain/model/feed/like/like_feed.model.dart';

part 'like_feed.entity.freezed.dart';

part 'like_feed.entity.g.dart';

@freezed
class LikeFeedEntity with _$LikeFeedEntity {
  const factory LikeFeedEntity({String? id, String? userId, String? feedId}) =
      _LikeFeedEntity;

  factory LikeFeedEntity.fromJson(Map<String, dynamic> json) =>
      _$LikeFeedEntityFromJson(json);

  factory LikeFeedEntity.fromModel(LikeFeedModel like) => LikeFeedEntity(
      id: like.id.isNotEmpty ? like.id : null,
      userId: like.user_id.isNotEmpty ? like.user_id : null,
      feedId: like.feed_id.isNotEmpty ? like.feed_id : null);
}
