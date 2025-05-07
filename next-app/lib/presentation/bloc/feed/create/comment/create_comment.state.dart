import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/constant/status.dart';

part 'create_comment.state.freezed.dart';

@freezed
class CreateCommentState with _$CreateCommentState {
  const factory CreateCommentState({
    @Default(Status.initial) Status status,
    @Default('') String message,
  }) = _CreateCommentState;
}
