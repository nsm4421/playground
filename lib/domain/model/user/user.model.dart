import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/data/entity/user/user.entity.dart';

part 'user.model.freezed.dart';

part 'user.model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @Default('') String id,
    @Default('') String nickname,
    @Default('') String profileUrl,
    @Default('') String description,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromEntity(UserEntity entity) => UserModel(
        id: entity.id ?? '',
        nickname: entity.nickname ?? '',
        profileUrl: entity.profileUrl ?? '',
        description: entity.description ?? '',
      );
}
