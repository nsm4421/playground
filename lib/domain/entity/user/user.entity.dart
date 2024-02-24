import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/constant/user.constant.dart';
import '../../../data/model/user/user.model.dart';

part 'user.entity.freezed.dart';

part 'user.entity.g.dart';

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    String? uid,
    String? email,
    String? username,
    String? photoUrl,
    UserStatus? status,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  static UserEntity fromGoogleAccount(UserCredential credential) => UserEntity(
        uid: credential.user?.uid,
        email: credential.user?.email,
        username: credential.user?.displayName,
        photoUrl: credential.user?.photoURL,
      );
}

extension UserEntityEx on UserEntity {
  UserModel toModel() => UserModel(
      uid: uid ?? '',
      email: email ?? '',
      username: username ?? '',
      photoUrl: photoUrl ?? '',
      status: status ?? UserStatus.offline);
}
