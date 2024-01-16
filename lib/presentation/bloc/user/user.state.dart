import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/domain/model/auth/user.model.dart';

import '../../../core/enums/status.enum.dart';
import '../../../core/response/error_response.dart';

part 'user.state.freezed.dart';

part 'user.state.g.dart';

@freezed
class UserState with _$UserState {
  const factory UserState({
    @Default(AuthStatus.initial) AuthStatus authStatus,
    @Default(Status.initial) Status status,
    UserModel? user,
    @Default(ErrorResponse()) error,
  }) = _UserState;

  factory UserState.fromJson(Map<String, dynamic> json) =>
      _$UserStateFromJson(json);
}
