import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/domain/model/user/user.model.dart';

part 'user.entity.freezed.dart';

part 'user.entity.g.dart';

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    String? id,
    String? nickname,
    String? profileUrl,
    String? description,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  factory UserEntity.fromModel(UserModel model) => UserEntity(
        id: model.id.isEmpty ? null : model.id,
        nickname: model.nickname.isEmpty ? null : model.nickname,
        profileUrl: model.profileUrl.isEmpty ? null : model.profileUrl,
        description: model.description.isEmpty ? null : model.description,
      );
}
