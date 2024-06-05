import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/entity/feed/feed.entity.dart';

part 'feed.model.freezed.dart';

part 'feed.model.g.dart';

@freezed
class FeedModel with _$FeedModel {
  const factory FeedModel({
    @Default('') String id,
    @Default('') String text,
    String? videoUrl,
    @Default(<String>[]) List<String> imageUrls,
    @Default(<String>[]) List<String> hashtags,
    String? createdAt,
    String? createdBy,
  }) = _FeedModel;

  factory FeedModel.fromJson(Map<String, dynamic> json) =>
      _$FeedModelFromJson(json);

  factory FeedModel.fromEntity(FeedEntity entity) => FeedModel(
        id: entity.id ?? '',
        text: entity.text ?? '',
        videoUrl: entity.videoUrl,
        imageUrls: entity.imageUrls,
        hashtags: entity.hashtags,
        createdAt: entity.createdAt?.toIso8601String(),
        createdBy: entity.createdBy,
      );
}
