import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/domain/entity/post/comment/post_comment.entity.dart';

import '../../../../core/constant/response.constant.dart';

part 'post_comment.state.freezed.dart';

@freezed
class PostCommentState with _$PostCommentState {
  const factory PostCommentState({
    @Default(Status.initial) Status status,
    @Default('') String postId,
    String? parentCommentId,
    Stream<List<PostCommentEntity>>? parentCommentStream,
    Stream<List<PostCommentEntity>>? childCommentStream,
  }) = _PostCommentState;
}
