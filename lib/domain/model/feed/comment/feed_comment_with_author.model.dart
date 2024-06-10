import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/data/entity/feed/base/feed.entity.dart';

import '../../../../data/entity/feed/comment/feed_comment.entity.dart';
import '../../user/account.model.dart';

part 'feed_comment_with_author.model.freezed.dart';

part 'feed_comment_with_author.model.g.dart';

@freezed
class FeedCommentWithAuthorModel with _$FeedCommentWithAuthorModel {
  const factory FeedCommentWithAuthorModel({
    @Default('') String id,
    @Default('') String feedId,
    @Default('') String content,
    @Default('') createdAt,
    @Default(AccountModel()) AccountModel author,
  }) = _FeedCommentWithAuthorModel;

  factory FeedCommentWithAuthorModel.fromJson(Map<String, dynamic> json) =>
      _$FeedCommentWithAuthorModelFromJson(json);

  factory FeedCommentWithAuthorModel.fromEntity(FeedCommentEntity entity) =>
      FeedCommentWithAuthorModel(
          id: entity.id ?? '',
          feedId: entity.feedId ?? '',
          content: entity.content ?? '',
          createdAt: entity.createdAt?.toIso8601String(),
          author: AccountModel.fromEntity(entity.author!));
}
