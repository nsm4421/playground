import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constant/response.constant.dart';
import '../../../../domain/entity/post/post.entity.dart';

part 'get_post.state.freezed.dart';

@freezed
class GetPostState with _$GetPostState {
  const factory GetPostState({
    @Default(Status.initial) Status status,
    @Default(1) int page,
    Stream<List<PostEntity>>? stream,
  }) = _GetPostState;
}
