import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../app/constant/user.constant.dart';

part 'auth.state.freezed.dart';

part 'auth.state.g.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    String? uid,
    @Default(AuthStatus.unAuthenticated) AuthStatus status,
  }) = _AuthState;

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);
}
