part of '../export.entity.dart';

class AuthorEntity {
  final String id;
  final String username;

  AuthorEntity({required this.id, required this.username});

  factory AuthorEntity.from(AuthorDto dto) {
    return AuthorEntity(id: dto.id, username: dto.username);
  }
}

class UserEntity extends AuthorEntity {
  final String email;
  final String nickname;

  UserEntity({
    required super.id,
    required super.username,
    required this.email,
    required this.nickname,
  });

  factory UserEntity.from(UserModel model) {
    return UserEntity(
        id: model.id,
        email: model.email,
        username: model.username,
        nickname: model.nickname);
  }
}
