import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entity/feed/feed.entity.dart';

part 'feed.model.freezed.dart';

part 'feed.model.g.dart';

@freezed
class FeedModel with _$FeedModel {
  const factory FeedModel({
    @Default('') String id,
    @Default('') String content,
    @Default(<String>[]) List<String> media,
    @Default(<String>[]) List<String> hashtags,
    @Default('') String created_by,
    DateTime? created_at,
  }) = _FeedModel;

  factory FeedModel.fromJson(Map<String, dynamic> json) =>
      _$FeedModelFromJson(json);

  factory FeedModel.fromEntity(FeedEntity entity) => FeedModel(
      id: entity.id ?? "",
      content: entity.content ?? "",
      media: entity.media,
      hashtags: entity.hashtags,
      created_by: entity.createdBy?.id ?? "",
      created_at: entity.createAt);
}
