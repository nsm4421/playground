import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/domain/model/auth/user.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user.dto.freezed.dart';

part 'user.dto.g.dart';

@freezed
class UserDto with _$UserDto {
  const factory UserDto(
      {@Default('') String uid,
      @Default('') String email,
      @Default('') String nickname,
      @Default('') String profileImage}) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  factory UserDto.fromAuth(User? user) => UserDto(
      uid: user?.id ?? '',
      email: user?.email ?? '',
      nickname: user?.userMetadata?['nickname'] ?? '',
      profileImage: user?.userMetadata?['profileImage'] ?? '');
}

extension UserDtoExt on UserDto {
  UserModel dtoToModel() => UserModel(
      uid: uid.isEmpty ? null : uid,
      email: email.isEmpty ? null : email,
      nickname: nickname.isEmpty ? null : nickname,
      profileImage: profileImage.isEmpty ? null : profileImage);
}
