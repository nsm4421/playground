import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/constant/status.dart';

part 'create_feed.state.freezed.dart';

@freezed
class CreateFeedState with _$CreateFeedState {
  const factory CreateFeedState({
    @Default(Status.initial) Status status,
    @Default('') String message,
  }) = _CreateFeedState;
}
