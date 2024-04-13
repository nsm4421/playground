import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/data/entity/feed/feed.entity.dart';

part 'feed.model.freezed.dart';

part 'feed.model.g.dart';

@freezed
class FeedModel with _$FeedModel {
  const factory FeedModel(
      {@Default('') String id,
      @Default('') String user_id,
      @Default('') String nickname,
      String? profile_image,
      @Default('') String content,
      @Default(<String>[]) List<String> hashtags,
      @Default(<String>[]) List<String> images,
      DateTime? created_at}) = _FeedModel;

  factory FeedModel.fromJson(Map<String, dynamic> json) =>
      _$FeedModelFromJson(json);

  factory FeedModel.fromEntity(FeedEntity feed) => FeedModel(
        id: feed.id!,
        user_id: feed.user.id ?? '',
        nickname: feed.user.nickname ?? '',
        profile_image: feed.user.profileImage,
        content: feed.content ?? '',
        hashtags: feed.hashtags,
        images: feed.images,
        created_at: feed.createdAt,
      );
}
