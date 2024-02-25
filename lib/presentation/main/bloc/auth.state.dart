import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/core/constant/user.constant.dart';
import 'package:hot_place/domain/entity/user/user.entity.dart';

part 'auth.state.freezed.dart';

part 'auth.state.g.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthStatus.unAuthenticated) AuthStatus status,
    UserEntity? currentUser,
  }) = _AuthState;

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);
}
