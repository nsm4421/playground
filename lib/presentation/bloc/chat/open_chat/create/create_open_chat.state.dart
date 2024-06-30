import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/constant/status.dart';

part 'create_open_chat.state.freezed.dart';

@freezed
class CreateOpenChatState with _$CreateOpenChatState {
  const factory CreateOpenChatState(
      {@Default(Status.initial) Status status,
      @Default('') String title,
      @Default('') String errorMessage}) = _CreateOpenChatState;
}
