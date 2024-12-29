part of '../export.entity.dart';

class UserEntity {
  final String id;
  final String email;
  final String username;
  final String nickname;

  UserEntity(
      {required this.id,
      required this.email,
      required this.username,
      required this.nickname});

  factory UserEntity.from(UserModel model) {
    return UserEntity(
        id: model.id,
        email: model.email,
        username: model.username,
        nickname: model.nickname);
  }
}
