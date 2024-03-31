import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:hot_place/domain/model/feed/feed.model.dart';
import 'package:hot_place/domain/model/user/user.model.dart';

part 'feed.entity.freezed.dart';

part 'feed.entity.g.dart';

@freezed
class FeedEntity with _$FeedEntity {
  const factory FeedEntity({
    String? id,
    @Default(UserEntity()) UserEntity user,
    String? content,
    @Default(<String>[]) List<String> hashtags,
    @Default(<String>[]) List<String> imageLinks,
  }) = _FeedEntity;

  factory FeedEntity.fromJson(Map<String, dynamic> json) =>
      _$FeedEntityFromJson(json);

  factory FeedEntity.fromModel(FeedModel feed, UserModel user) => FeedEntity(
        id: feed.id.isNotEmpty ? feed.id : null,
        user: UserEntity.fromModel(user),
        content: feed.content.isNotEmpty ? feed.content : null,
        hashtags: feed.hashtags,
        imageLinks: feed.imageLinks,
      );
}
