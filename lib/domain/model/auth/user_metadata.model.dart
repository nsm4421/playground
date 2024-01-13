import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/data/dto/auth/user/user_metadata.dto.dart';

part 'user_metadata.model.freezed.dart';

part 'user_metadata.model.g.dart';

@freezed
class UserMetaDataModel with _$UserMetaDataModel {
  const factory UserMetaDataModel({
    String? nickname,
    String? profileImage,
  }) = _UserMetaDataModel;

  factory UserMetaDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserMetaDataModelFromJson(json);
}

extension UserMetaDataModelExt on UserMetaDataModel {
  UserMetaDataDto modelToDto() => UserMetaDataDto(
      nickname: nickname ?? '', profileImage: profileImage ?? '');
}
