import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/constant/status.dart';

part 'upload_feed_comment.state.freezed.dart';

@freezed
class UploadFeedCommentState with _$UploadFeedCommentState {
  const factory UploadFeedCommentState({
    @Default(Status.initial) Status status,
    @Default('') String content,
    @Default('') String feedId,
    @Default('') String message,
  }) = _UploadFeedCommentState;
}
