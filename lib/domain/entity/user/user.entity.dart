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

  factory UserEntity.fromCredential(UserCredential credential) => UserEntity(
        uid: credential.user?.uid,
        email: credential.user?.email,
        username: credential.user?.displayName,
        photoUrl: credential.user?.photoURL,
      );

  factory UserEntity.fromModel(UserModel model) => UserEntity(
        uid: model.uid,
        email: model.email,
        username: model.username,
        photoUrl: model.photoUrl,
      );
}
