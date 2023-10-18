import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/constant/status.enum.dart';
import '../../../../../model/user/user.model.dart';

part 'swipe.state.freezed.dart';

part 'swipe.state.g.dart';

@freezed
class SwipeState with _$SwipeState {
  const factory SwipeState({
    @Default(Status.initial) Status status,
    @Default(<UserModel>[]) List<UserModel> users,
  }) = _SwipeState;

  factory SwipeState.fromJson(Map<String, dynamic> json) =>
      _$SwipeStateFromJson(json);
}
