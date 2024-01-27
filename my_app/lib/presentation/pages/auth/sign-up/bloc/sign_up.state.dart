import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:my_app/core/utils/exception/error_response.dart';
import 'package:my_app/domain/model/user/user.model.dart';

import '../../../../../core/constant/enums/sign_up.enum.dart';

part 'sign_up.state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState({
    @Default(SignUpStatus.initial) SignUpStatus status,
    @Default('') String? uid,
    @Default(UserModel()) UserModel user,
    @Default(<Asset>[]) List<Asset> images, // 프로필 이미지
    @Default(ErrorResponse()) ErrorResponse error,
  }) = _SignUpState;
}
