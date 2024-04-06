import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/constant/response.constant.dart';
import '../../../data/entity/user/user.entity.dart';

part 'user.state.freezed.dart';

@freezed
class UserState with _$UserState {
  const factory UserState({
    @Default(Status.initial) Status status,
    @Default(UserEntity()) UserEntity user,
    @Default('') String error,
  }) = _UserState;
}
