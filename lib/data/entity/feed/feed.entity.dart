import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/domain/model/feed/feed.model.dart';

import '../../../core/constant/media.dart';

part 'feed.entity.freezed.dart';

part 'feed.entity.g.dart';

@freezed
class FeedEntity with _$FeedEntity {
  const factory FeedEntity({
    String? id,
    String? content,
    String? caption,
    String? media,
    @Default(MediaType.image) MediaType type,
    @Default(<String>[]) List<String> hashtags,
    DateTime? createdAt,
    String? createdBy,
  }) = _FeedEntity;

  factory FeedEntity.fromJson(Map<String, dynamic> json) =>
      _$FeedEntityFromJson(json);

  factory FeedEntity.fromModel(FeedModel model) => FeedEntity(
      id: model.id.isEmpty ? null : model.id,
      content: model.content.isEmpty ? null : model.content,
      caption: model.caption.isEmpty ? null : model.caption,
      media: model.media.isEmpty ? null : model.media,
      type: model.type,
      hashtags: model.hashtags,
      createdAt:
          model.createdAt == null ? null : DateTime.parse(model.createdAt!),
      createdBy: model.createdBy);
}
