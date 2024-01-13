import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/data/dto/auth/user/user_metadata.dto.dart';
import 'package:my_app/domain/model/auth/user.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user.dto.freezed.dart';

part 'user.dto.g.dart';

@freezed
class UserDto with _$UserDto {
  const factory UserDto(
      {@Default('') String id,
      @Default('') String email,
      @Default(UserMetaDataDto()) UserMetaDataDto metaData}) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}

extension UserDtoExt on UserDto {
  UserModel dtoToModel() =>
      UserModel(id: id, email: email, metaData: metaData.dtoToModel());
}

extension UserExt on User {
  UserDto userToDto() => UserDto(
      id: id,
      email: email ?? '',
      metaData: UserMetaDataDto.fromJson(userMetadata ?? {}));
}
