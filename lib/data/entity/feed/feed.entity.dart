import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:hot_place/domain/model/feed/feed.model.dart';
import 'package:hot_place/domain/model/feed/feed_with_author.model.dart';
import 'package:hot_place/domain/model/user/user.model.dart';

part 'feed.entity.freezed.dart';

@freezed
class FeedEntity with _$FeedEntity {
  const factory FeedEntity(
      {String? id,
      @Default(UserEntity()) UserEntity user,
      String? content,
      @Default(<String>[]) List<String> hashtags,
      @Default(<String>[]) List<String> images,
      int? numLike,
      DateTime? createdAt}) = _FeedEntity;

  factory FeedEntity.fromModel(FeedModel feed, UserModel user) => FeedEntity(
      id: feed.id.isNotEmpty ? feed.id : null,
      user: UserEntity.fromModel(user),
      content: feed.content.isNotEmpty ? feed.content : null,
      hashtags: feed.hashtags,
      images: feed.images);

  factory FeedEntity.fromModelWithAuthor(FeedWithAuthorModel feed) =>
      FeedEntity(
          id: feed.id.isNotEmpty ? feed.id : null,
          user: UserEntity.fromModel(feed.author),
          content: feed.content.isNotEmpty ? feed.content : null,
          hashtags: feed.hashtags,
          images: feed.images,
          numLike: feed.num_like,
          createdAt: feed.created_at);
}
