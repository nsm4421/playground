import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio/domain/entity/auth/presence.entity.dart';
import 'package:portfolio/core/constant/emotion_type.dart';
import 'package:portfolio/domain/entity/emotion/emotion.entity.dart';

import '../../../data/model/feed/feed/feed.model.dart';
import '../../../data/model/feed/feed/feed_model_for_rpc.model.dart';

part 'feed.entity.freezed.dart';

@freezed
class FeedEntity with _$FeedEntity {
  const factory FeedEntity(
      {String? id,
      String? content,
      @Default(<String>[]) List<String> media,
      @Default(<String>[]) List<String> hashtags,
      EmotionEntity? emotion,
      PresenceEntity? createdBy,
      DateTime? createdAt}) = _FeedEntity;

  factory FeedEntity.fromModel(FeedModel model) => FeedEntity(
      id: model.id.isNotEmpty ? model.id : null,
      content: model.content.isNotEmpty ? model.content : null,
      media: model.media,
      hashtags: model.hashtags,
      createdBy: PresenceEntity(
          id: model.created_by.isNotEmpty ? model.created_by : null),
      createdAt: model.created_at);

  factory FeedEntity.fromRpcModel(FeedModelForRpc model) => FeedEntity(
      id: model.id.isNotEmpty ? model.id : null,
      content: model.content.isNotEmpty ? model.content : null,
      media: model.media,
      hashtags: model.hashtags,
      emotion: (model.emotion_id != null && model.emotion_type != null)
          ? EmotionEntity(id: model.emotion_id, type: model.emotion_type!)
          : null,
      createdBy: model.author_id.isNotEmpty
          ? PresenceEntity(
              id: model.author_id,
              nickname: model.author_nickname,
              profileImage: model.author_profile_image)
          : null,
      createdAt: model.created_at);
}
