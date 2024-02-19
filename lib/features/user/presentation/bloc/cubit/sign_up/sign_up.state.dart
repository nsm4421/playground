import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/features/app/constant/user.constant.dart';

part 'sign_up.state.freezed.dart';

part 'sign_up.state.g.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState({
    @Default(SignUpStep.initial) SignUpStep step,
    @Default('') String phoneNumber,
    @Default('') String otpNumber,
    @Default(false) bool isLoading,
  }) = _SignUpState;

  factory SignUpState.fromJson(Map<String, dynamic> json) =>
      _$SignUpStateFromJson(json);
}
