import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/data/model/post/like/like.model.dart';
import 'package:hot_place/data/model/post/post.model.dart';

import '../user/user.entity.dart';

part 'post.entity.freezed.dart';

@freezed
class PostEntity with _$PostEntity {
  const factory PostEntity({
    String? id,
    String? content, // 본문
    UserEntity? author, // 작성자
    @Default(<String>[]) List<String> hashtags, // 해시태그
    @Default(<String>[]) List<String> images, // 이미지
    int? numLike, // 좋아요 개수
    String? likeId, // 현재 로그인 유저의 좋아요 document id
    DateTime? createdAt,
  }) = _PostEntity;

  static PostEntity fromModel(
          {required PostModel post,
          required UserEntity author,
          LikeModel? like}) =>
      PostEntity(
        id: post.id,
        content: post.content,
        author: author,
        hashtags: post.hashtags,
        images: post.images,
        numLike: post.numLike,
        likeId: like?.id,
        createdAt: post.createdAt,
      );
}

extension PostEntityEx on PostEntity {
  PostModel toModel() => PostModel(
      id: id ?? '',
      content: content ?? '',
      authorUid: author?.uid ?? '',
      hashtags: hashtags,
      numLike: numLike ?? 0,
      images: images,
      createdAt: createdAt);
}
