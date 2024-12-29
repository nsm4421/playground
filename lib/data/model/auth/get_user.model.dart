import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_user.model.freezed.dart';

part 'get_user.model.g.dart';

@freezed
class GetUserDto with _$GetUserDto {
  const factory GetUserDto(
      {required String message, required UserModel payload}) = _GetUserDto;

  factory GetUserDto.fromJson(Map<String, dynamic> json) =>
      _$GetUserDtoFromJson(json);
}

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    required String id,
    required String email,
    required String username,
    required String nickname,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
