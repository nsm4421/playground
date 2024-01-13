import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/domain/model/auth/user_metadata.model.dart';

part 'user_metadata.dto.freezed.dart';

part 'user_metadata.dto.g.dart';

@freezed
class UserMetaDataDto with _$UserMetaDataDto {
  const factory UserMetaDataDto({
    @Default('') String nickname,
    @Default(<String>[]) List<String> profileImages,
  }) = _UserMetaDataDto;

  factory UserMetaDataDto.fromJson(Map<String, dynamic> json) =>
      _$UserMetaDataDtoFromJson(json);
}

extension UserMetaDataDtoExt on UserMetaDataDto {
  UserMetaDataModel dtoToModel() => UserMetaDataModel(
      nickname: nickname.isEmpty ? null : nickname,
      profileImages: profileImages);
}
