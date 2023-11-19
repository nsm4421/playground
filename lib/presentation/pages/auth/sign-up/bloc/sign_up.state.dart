import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/core/utils/exception/error_response.dart';

import '../../../../../core/constant/enums/sign_up.enum.dart';
import '../../../../../domain/model/user/user.model.dart';

part 'sign_up.state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState({
    @Default(SignUpStatus.initial) SignUpStatus status,
    @Default(UserModel()) UserModel user,
    @Default(ErrorResponse()) ErrorResponse error,
  }) = _SignUpState;
}
