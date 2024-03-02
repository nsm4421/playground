import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/data/model/post/post.model.dart';

import '../user/user.entity.dart';

part 'post.entity.freezed.dart';

@freezed
class PostEntity with _$PostEntity {
  const factory PostEntity({
    String? id,
    String? content,
    UserEntity? author,
    @Default(<String>[]) List<String> hashtags,
    @Default(<String>[]) List<String> images,
    DateTime? createdAt,
  }) = _PostEntity;

  static PostEntity fromModel({
    required PostModel post,
    required UserEntity author,
  }) =>
      PostEntity(
        id: post.id,
        content: post.content,
        author: author,
        hashtags: post.hashtags,
        images: post.images,
        createdAt: post.createdAt,
      );
}

extension PostEntityEx on PostEntity {
  PostModel toModel() => PostModel(
      id: id ?? '',
      content: content ?? '',
      authorUid: author?.uid ?? '',
      hashtags: hashtags,
      images: images,
      createdAt: createdAt);
}
