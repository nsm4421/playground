import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../app/constant/user.constant.dart';
import '../../../data/model/user/user.model.dart';

part 'user.entity.freezed.dart';

part 'user.entity.g.dart';

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    String? uid,
    String? email,
    String? username,
    String? phoneNumber,
    UserStatus? status,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
}

extension UserEntityEx on UserEntity {
  UserModel toModel() => UserModel(
      uid: uid ?? '',
      email: email ?? '',
      username: username ?? '',
      phoneNumber: phoneNumber ?? '',
      status: status ?? UserStatus.active);

  static UserEntity fromModel(UserModel user) => UserEntity(
      uid: user.uid,
      email: user.email,
      username: user.username,
      phoneNumber: user.phoneNumber,
      status: user.status);
}
