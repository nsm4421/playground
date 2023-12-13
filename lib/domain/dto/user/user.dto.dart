import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/domain/model/user/user.model.dart';

part 'user.dto.freezed.dart';

part 'user.dto.g.dart';

@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    @Default('') String uid,
    @Default('') String email,
    @Default('') String nickname,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}

extension UserDtoEx on UserDto {
  UserModel toModel() => UserModel(uid: uid, email: email, nickname: nickname);
}
