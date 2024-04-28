import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user.model.freezed.dart';

part 'user.model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @Default('') String id,
    @Default('') String email,
    @Default('') String nickname,
    String? profile_image,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromSession(User sessionUser) =>
      UserModel(id: sessionUser.id, email: sessionUser.email ?? '');

  factory UserModel.fromEntity(UserEntity user) => UserModel(
      id: user.id!,
      email: user.email ?? '',
      nickname: user.nickname ?? '',
      profile_image: user.profileImage);
}
