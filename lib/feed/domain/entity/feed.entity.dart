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
        id: dto.id.isNotEmpty ? dto.id : null,
        media: dto.media.isNotEmpty ? dto.media : null,
        caption: dto.caption.isNotEmpty ? dto.caption : null,
        hashtags: dto.hashtags.isNotEmpty ? dto.hashtags : [],
        createdAt: dto.created_at.isNotEmpty ? dto.created_at : null,
        updatedAt: dto.updated_at.isNotEmpty ? dto.updated_at : null,
        author: PresenceEntity(
            uid: dto.author.id.isNotEmpty ? dto.author.id : null,
            username:
                dto.author.username.isNotEmpty ? dto.author.username : null,
            avatarUrl: dto.author.avatar_url.isNotEmpty
                ? dto.author.avatar_url
                : null));
  }
}
