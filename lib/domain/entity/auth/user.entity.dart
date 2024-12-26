part of '../export.entity.dart';

class UserEntity {
  final String id;
  final String email;
  final String username;

  UserEntity(
      {required this.id,
      required this.email,
      required this.username});

  factory UserEntity.from(UserModel model) {
    return UserEntity(
        id: model.id,
        email: model.email,
        username: model.username);
  }
}
