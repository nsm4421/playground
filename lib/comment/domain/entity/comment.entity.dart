import 'package:flutter/foundation.dart';
import 'package:flutter_app/auth/domain/domain.export.dart';
import 'package:flutter_app/shared/shared.export.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/dto/fetch_feed_comments.dto.dart';

part 'comment.entity.freezed.dart';

@freezed
class CommentEntity with _$CommentEntity {
  const factory CommentEntity({
    String? id,
    String? referenceId,
    Tables? referenceTable,
    String? parentId,
    String? content,
    PresenceEntity? author,
    @Default(0) int childCommentCount,
    DateTime? createdAt,
  }) = _CommentEntity;

  factory CommentEntity.fromParentCommentDto(FetchParentCommentDto dto,
          {required String referenceId, required Tables referenceTable}) =>
      CommentEntity(
          id: dto.id.isNotEmpty ? dto.id : null,
          referenceId: referenceId,
          referenceTable: referenceTable,
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
          createdAt: dto.created_at);

  factory CommentEntity.fromChildCommentDto(FetchChildCommentDto dto,
          {required String referenceId,
          required Tables referenceTable,
          required String parentId}) =>
      CommentEntity(
          id: dto.id.isNotEmpty ? dto.id : null,
          referenceId: referenceId,
          referenceTable: referenceTable,
          parentId: parentId,
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
