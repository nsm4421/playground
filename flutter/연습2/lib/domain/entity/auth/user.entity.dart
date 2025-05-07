part of '../export.entity.dart';

class UserEntity {
  final String id;
  final String nickname;
  final String profileImage;

  UserEntity({
    required this.id,
    required this.nickname,
    required this.profileImage,
  });

  factory UserEntity.from(UserModel model) {
    return UserEntity(
        id: model.id,
        nickname: model.nickname,
        profileImage: '${ApiEndPoint.domain}${model.profileImage}');
  }
}
