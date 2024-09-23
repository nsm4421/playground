import 'package:flutter/foundation.dart';
import 'package:flutter_app/feed/data/dto/fetch_feed_by_rpc.dto.dart';
import 'package:flutter_app/feed/domain/entity/feed_comment.entity.dart';
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
    DateTime? createdAt,
    String? updatedAt,
    PresenceEntity? author,
    @Default(0) int likeCount,
    @Default(false) bool isLike,
    @Default(0) int commentCount,
    ParentFeedCommentEntity? latestComment,
  }) = _FeedEntity;

  factory FeedEntity.from(FetchFeedByRpcDto dto) {
    return FeedEntity(
        id: dto.id.isNotEmpty ? dto.id : null,
        media: dto.media.isNotEmpty ? dto.media : null,
        caption: dto.caption.isNotEmpty ? dto.caption : null,
        hashtags: dto.hashtags.isNotEmpty ? dto.hashtags : [],
        createdAt: dto.created_at.isNotEmpty ? DateTime.parse(dto.created_at) : null,
        updatedAt: dto.updated_at.isNotEmpty ? dto.updated_at : null,
        author: PresenceEntity(
            uid: dto.author_id.isNotEmpty ? dto.author_id : null,
            username:
                dto.author_username.isNotEmpty ? dto.author_username : null,
            avatarUrl: dto.author_avatar_url.isNotEmpty
                ? dto.author_avatar_url
                : null),
        likeCount: dto.like_count,
        isLike: dto.is_like,
        commentCount: dto.comment_count,
        latestComment:
            dto.latest_comment_id != null && dto.latest_comment_id!.isNotEmpty
                ? ParentFeedCommentEntity(
                    id: dto.latest_comment_id,
                    content: dto.latest_comment_content,
                    createdAt: dto.lastet_comment_created_at != null
                        ? DateTime.parse(dto.lastet_comment_created_at!)
                        : null)
                : null);
  }
}
