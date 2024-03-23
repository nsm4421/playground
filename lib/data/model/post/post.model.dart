import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/domain/entity/post/post.entity.dart';

part 'post.model.freezed.dart';

part 'post.model.g.dart';

@freezed
class PostModel with _$PostModel {
  const factory PostModel({
    @Default('') String id,
    @Default('') String content,
    @Default('') String authorUid,
    @Default(<String>[]) List<String> hashtags,
    @Default(<String>[]) List<String> images,
    @Default(0) int numLike,
    DateTime? createdAt,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  factory PostModel.fromEntity(PostEntity entity) => PostModel(
      id: entity.id ?? '',
      content: entity.content ?? '',
      authorUid: entity.author?.uid ?? '',
      hashtags: entity.hashtags,
      numLike: entity.numLike ?? 0,
      images: entity.images,
      createdAt: entity.createdAt);
}
