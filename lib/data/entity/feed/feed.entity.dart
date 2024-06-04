import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/domain/model/feed/feed.model.dart';

part 'feed.entity.freezed.dart';

part 'feed.entity.g.dart';

@freezed
class FeedEntity with _$FeedEntity {
  const factory FeedEntity({
    String? id,
    String? text,
    String? videoUrl,
    @Default(<String>[]) List<String> imageUrls,
    @Default(<String>[]) List<String> hashtags,
    DateTime? createdAt,
    String? createdBy,
  }) = _FeedEntity;

  factory FeedEntity.fromJson(Map<String, dynamic> json) =>
      _$FeedEntityFromJson(json);

  factory FeedEntity.fromModel(FeedModel model) => FeedEntity(
      id: model.id.isEmpty ? null : model.id,
      text: model.text.isEmpty ? null : model.text,
      videoUrl: model.videoUrl,
      imageUrls: model.imageUrls,
      hashtags: model.hashtags,
      createdAt:
          model.createdAt == null ? null : DateTime.parse(model.createdAt!),
      createdBy: model.createdBy);
}
