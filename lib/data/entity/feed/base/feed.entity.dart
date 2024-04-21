import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:hot_place/domain/model/feed/base/feed.model.dart';

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

  factory FeedEntity.fromModel(FeedModel feed) => FeedEntity(
      id: feed.id.isNotEmpty ? feed.id : null,
      user: UserEntity(
          id: feed.user_id,
          nickname: feed.nickname.isNotEmpty ? feed.nickname : null,
          profileImage: feed.profile_image),
      content: feed.content.isNotEmpty ? feed.content : null,
      hashtags: feed.hashtags,
      images: feed.images,
      createdAt: feed.created_at);
}
