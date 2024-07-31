import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio/features/auth/domain/entity/presence.entity.dart';
import 'package:portfolio/features/emotion/core/constant/emotion_type.dart';
import 'package:portfolio/features/feed/data/model/feed/feed_model_for_rpc.model.dart';
import '../../../data/model/feed/feed.model.dart';

part 'feed.entity.freezed.dart';

@freezed
class FeedEntity with _$FeedEntity {
  const factory FeedEntity({
    String? id,
    String? content,
    @Default(<String>[]) List<String> media,
    @Default(<String>[]) List<String> hashtags,
    EmotionType? emotion,
    PresenceEntity? createdBy,
    @Default(false) isLike,
  }) = _FeedEntity;

  factory FeedEntity.fromModel(FeedModel model) => FeedEntity(
      id: model.id.isNotEmpty ? model.id : null,
      content: model.content.isNotEmpty ? model.content : null,
      media: model.media,
      hashtags: model.hashtags,
      createdBy: PresenceEntity(
          id: model.created_by.isNotEmpty ? model.created_by : null));

  factory FeedEntity.fromRpcModel(FeedModelForRpc model) => FeedEntity(
        id: model.id.isNotEmpty ? model.id : null,
        content: model.content.isNotEmpty ? model.content : null,
        media: model.media,
        hashtags: model.hashtags,
        isLike: model.emotion?.type,
        createdBy: PresenceEntity.fromModel(model.created_by),
      );
}
