import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constant/dto.constant.dart';
import '../../../../data/entity/feed/base/feed.entity.dart';

part 'feed.model.freezed.dart';

part 'feed.model.g.dart';

@freezed
class FeedModel with _$FeedModel {
  const factory FeedModel({
    @Default('') String id,
    @Default('') String content,
    @Default('') String caption,
    @Default('') String media,
    @Default(MediaType.image) MediaType type,
    @Default(<String>[]) List<String> hashtags,
    @Default('') String createdAt,
    @Default('') String createdBy,
  }) = _FeedModel;

  factory FeedModel.fromJson(Map<String, dynamic> json) =>
      _$FeedModelFromJson(json);

  factory FeedModel.fromEntity(FeedEntity entity) => FeedModel(
        id: entity.id ?? '',
        content: entity.content ?? '',
        caption: entity.caption ?? '',
        media: entity.media ?? '',
        type: entity.type,
        hashtags: entity.hashtags,
        createdAt: entity.createdAt == null
            ? DateTime.now().toIso8601String()
            : entity.createdAt!.toIso8601String(),
        createdBy: entity.createdBy ?? entity.author?.id ?? '',
      );
}
