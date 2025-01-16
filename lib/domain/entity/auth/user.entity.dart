part of '../export.entity.dart';

class AuthorEntity {
  final String id;
  final String username;
  final String profileImage;

  AuthorEntity(
      {required this.id, required this.username, required this.profileImage});

  factory AuthorEntity.from(AuthorDto dto) {
    return AuthorEntity(
        id: dto.id,
        username: dto.username,
        profileImage: '${ApiEndPoint.domain}${dto.profileImage}');
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
    required super.profileImage,
  });

  factory UserEntity.from(UserModel model) {
    return UserEntity(
        id: model.id,
        email: model.email,
        username: model.username,
        nickname: model.nickname,
        profileImage: '${ApiEndPoint.domain}${model.profileImage}');
  }
}
