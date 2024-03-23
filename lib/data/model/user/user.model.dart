import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/domain/entity/user/user.entity.dart';

import '../../../core/constant/user.constant.dart';

part 'user.model.freezed.dart';

part 'user.model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @Default('') String uid,
    @Default('') String email,
    @Default('') String username,
    @Default('') String photoUrl,
    @Default(UserStatus.offline) UserStatus status,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromEntity(UserEntity entity) => UserModel(
      uid: entity.uid ?? '',
      email: entity.email ?? '',
      username: entity.username ?? '',
      photoUrl: entity.photoUrl ?? '',
      status: entity.status ?? UserStatus.offline);

  factory UserModel.fromCredential(UserCredential credential) => UserModel(
        uid: credential.user?.uid ?? '',
        email: credential.user?.email ?? '',
        username: credential.user?.displayName ?? '',
        photoUrl: credential.user?.photoURL ?? '',
      );
}
