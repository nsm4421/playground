part of '../export.entity.dart';

class UserEntity {
  final String id;
  final String email;
  final String username;
  final String token;

  UserEntity(
      {required this.id,
      required this.email,
      required this.username,
      required this.token});

  factory UserEntity.from(UserModel model) {
    return UserEntity(
        id: model.id,
        email: model.email,
        username: model.username,
        token: model.token);
  }
}
