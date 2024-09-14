import 'package:flutter/foundation.dart';
import 'package:flutter_app/feed/data/data.export.dart';
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
  }) = _FeedEntity;

  factory FeedEntity.from(FetchFeedDto dto) {
    return FeedEntity(
        id: dto.id,
        media: dto.media,
        caption: dto.caption,
        hashtags: dto.hashtags,
        createdAt: dto.created_at,
        updatedAt: dto.updated_at,
        author: PresenceEntity(
          uid: dto.author.id,
          username: dto.author.username,
          avatarUrl: dto.author.avatar_url,
        ));
  }
}
