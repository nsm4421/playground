import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth.state.freezed.dart';

part 'auth.state.g.dart';

enum AuthStatus {
  initial,
  loading,
  success,
  error;
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState(
      {@Default(AuthStatus.initial) AuthStatus status,
      @Default('') String uid,
      @Default('') String nickname,
      @Default(<String>[]) List<String> profileImageUrls}) = _AuthState;

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);
}
