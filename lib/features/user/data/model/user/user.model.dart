import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../app/constant/user.constant.dart';

part 'user.model.freezed.dart';

part 'user.model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @Default('') String uid,
    @Default('') String email,
    @Default('') String username,
    @Default('') String phoneNumber,
    @Default(UserStatus.active) UserStatus status,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
