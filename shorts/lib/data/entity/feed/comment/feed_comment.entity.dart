import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/data/entity/user/account.entity.dart';
import 'package:my_app/domain/model/feed/comment/feed_comment_payload.dto.dart';
import 'package:my_app/domain/model/feed/comment/fetch_feed_comment_response.dto.dart';

part 'feed_comment.entity.freezed.dart';

part 'feed_comment.entity.g.dart';

@freezed
class FeedCommentEntity with _$FeedCommentEntity {
  const factory FeedCommentEntity({
    String? id,
    String? feedId,
    String? content,
    DateTime? createdAt,
    AccountEntity? author,
  }) = _FeedCommentEntity;

  factory FeedCommentEntity.fromJson(Map<String, dynamic> json) =>
      _$FeedCommentEntityFromJson(json);

  factory FeedCommentEntity.fromDto(
          FetchFeedCommentResponseDto dto) =>
      FeedCommentEntity(
          id: dto.id.isEmpty ? null : dto.id,
          feedId: dto.feedId.isEmpty ? null : dto.feedId,
          content: dto.content.isEmpty ? null : dto.content,
          createdAt: dto.createdAt,
          author: AccountEntity.fromDto(dto.author));

  factory FeedCommentEntity.fromPayload(FeedCommentPayloadDto dto) =>
      FeedCommentEntity(
          id: dto.id.isEmpty ? null : dto.id,
          feedId: dto.feedId.isEmpty ? null : dto.feedId,
          content: dto.content.isEmpty ? null : dto.content,
          createdAt: dto.createdAt,
          author: AccountEntity(id: dto.createdBy));
}
