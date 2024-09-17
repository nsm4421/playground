import 'package:flutter/foundation.dart';
import 'package:flutter_app/feed/data/data.export.dart';
import 'package:flutter_app/feed/data/dto/fetch_feed_by_rpc.dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../auth/domain/domain.export.dart';

part 'feed.entity.freezed.dart';

@freezed
class FeedEntity with _$FeedEntity {
  const factory FeedEntity({
    String? id,
    String? media,
    String? caption,
    List<String>? hashtags,
    String? createdAt,
    String? updatedAt,
    PresenceEntity? author,
    @Default(0) int likeCount,
    @Default(false) bool isLike,
  }) = _FeedEntity;

  factory FeedEntity.from(FetchFeedByRpcDto dto) {
    return FeedEntity(
        id: dto.feed_id.isNotEmpty ? dto.feed_id : null,
        media: dto.media.isNotEmpty ? dto.media : null,
        caption: dto.caption.isNotEmpty ? dto.caption : null,
        hashtags: dto.hashtags.isNotEmpty ? dto.hashtags : [],
        createdAt: dto.created_at.isNotEmpty ? dto.created_at : null,
        updatedAt: dto.updated_at.isNotEmpty ? dto.updated_at : null,
        author: PresenceEntity(
            uid: dto.author_id.isNotEmpty ? dto.author_id : null,
            username:
                dto.author_username.isNotEmpty ? dto.author_username : null,
            avatarUrl: dto.author_avatar_url.isNotEmpty
                ? dto.author_avatar_url
                : null),
        likeCount: dto.like_count,
        isLike: dto.is_like);
  }
}
