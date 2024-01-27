import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/data/dto/auth/user/user.dto.dart';

part 'user.model.freezed.dart';

part 'user.model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel(
      {String? uid,
      String? email,
      String? nickname,
      String? profileImage}) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

extension UserModelExt on UserModel {
  UserDto modelToDto() => UserDto(
      uid: uid ?? '',
      email: email ?? '',
      nickname: nickname ?? '',
      profileImage: profileImage ?? '');
}
