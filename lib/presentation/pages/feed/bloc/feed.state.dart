import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/core/constant/enums/status.enum.dart';
import 'package:my_app/core/utils/exception/error_response.dart';
import 'package:my_app/domain/model/feed/feed.model.dart';

part 'feed.state.freezed.dart';

@freezed
class FeedState with _$FeedState {
  const factory FeedState(
      {@Default(Status.initial) Status status,
      @Default(<FeedModel>[]) List<FeedModel> feeds,
      Stream<List<FeedModel>>? feedStream,
      @Default(ErrorResponse()) ErrorResponse error}) = _FeedState;
}
