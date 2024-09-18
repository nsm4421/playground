import '../../../auth/domain/domain.export.dart';
import '../../../comment/comment.export.dart';
import '../../../shared/shared.export.dart';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_comment.entity.freezed.dart';

/// 자식 댓글
@freezed
class ChildFeedCommentEntity with _$ChildFeedCommentEntity {
  const factory ChildFeedCommentEntity({
    String? id,
    String? feedId,
    String? parentId,
    String? content,
    PresenceEntity? author,
    DateTime? createdAt,
  }) = _ChildFeedCommentEntity;

  factory ChildFeedCommentEntity.from(FetchChildCommentDto dto,
          {String? feedId}) =>
      ChildFeedCommentEntity(
          id: dto.id.isNotEmpty ? dto.id : null,
          feedId: feedId,
          parentId: dto.parent_id.isNotEmpty ? dto.parent_id : null,
          content: dto.content.isNotEmpty ? dto.content : null,
          author: PresenceEntity(
            uid: dto.author.id.isNotEmpty ? dto.author.id : null,
            username:
                dto.author.username.isNotEmpty ? dto.author.username : null,
            avatarUrl:
                dto.author.avatar_url.isNotEmpty ? dto.author.avatar_url : null,
          ),
          createdAt: dto.created_at);
}

/// 부모 댓글
@freezed
class ParentFeedCommentEntity with _$ParentFeedCommentEntity {
  const factory ParentFeedCommentEntity({
    String? id,
    String? feedId,
    String? parentId,
    String? content,
    PresenceEntity? author,
    DateTime? createdAt,
    @Default(<ChildFeedCommentEntity>[]) List<ChildFeedCommentEntity> children,
    @Default(0) int childCommentCount,
  }) = _ParentFeedCommentEntity;

  factory ParentFeedCommentEntity.from(FetchParentCommentDto dto,
          {String? feedId, List<ChildFeedCommentEntity>? children}) =>
      ParentFeedCommentEntity(
          id: dto.id.isNotEmpty ? dto.id : null,
          feedId: feedId,
          parentId: null,
          content: dto.content.isNotEmpty ? dto.content : null,
          author: PresenceEntity(
            uid: dto.author_id.isNotEmpty ? dto.author_id : null,
            username:
                dto.author_username.isNotEmpty ? dto.author_username : null,
            avatarUrl:
                dto.author_avatar_url.isNotEmpty ? dto.author_avatar_url : null,
          ),
          childCommentCount: dto.child_comment_count,
          children: children ?? [],
          createdAt: dto.created_at);
}
