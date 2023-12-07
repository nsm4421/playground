import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/core/constant/enums/status.enum.dart';
import 'package:my_app/core/utils/exception/error_response.dart';
import 'package:my_app/domain/model/feed/feed_comment.model.dart';

part 'feed_comment.state.freezed.dart';

@freezed
class FeedCommentState with _$FeedCommentState {
  const factory FeedCommentState({
    @Default(Status.initial) Status status,
    @Default('') String feedId,
    @Default(<FeedCommentModel>[]) List<FeedCommentModel> comments,
    @Default(ErrorResponse()) ErrorResponse error,
  }) = _FeedCommentState;
}
