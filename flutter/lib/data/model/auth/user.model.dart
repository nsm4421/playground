import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.model.freezed.dart';

part 'user.model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @Default('') String id,
    @Default('') String nickname,
    @Default('') String profileImage,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
