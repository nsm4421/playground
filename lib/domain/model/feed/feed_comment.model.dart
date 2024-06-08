import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/data/entity/feed/feed_comment.entity.dart';

part 'feed_comment.model.freezed.dart';

part 'feed_comment.model.g.dart';

@freezed
class FeedCommentModel with _$FeedCommentModel {
  const factory FeedCommentModel({
    @Default('') String id,
    @Default('') String feedId,
    @Default('') String content,
    String? createdAt,
    String? createdBy,
  }) = _FeedCommentModel;

  factory FeedCommentModel.fromJson(Map<String, dynamic> json) =>
      _$FeedCommentModelFromJson(json);

  factory FeedCommentModel.fromEntity(FeedCommentEntity entity) =>
      FeedCommentModel(
          id: entity.id ?? '',
          feedId: entity.feedId ?? '',
          content: entity.content ?? '',
          createdAt: entity.createdAt?.toIso8601String(),
          createdBy: entity.createdBy);
}
