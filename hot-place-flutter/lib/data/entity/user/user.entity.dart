import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/domain/model/user/user.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constant/user.constant.dart';

part 'user.entity.freezed.dart';

part 'user.entity.g.dart';

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    String? id,
    String? email,
    String? nickname,
    String? profileImage,
    DateTime? createdAt,
    DateTime? lastSeenAt,
    // bio
    Sex? sex,
    String? introduce,
    @Default(<String>[]) List<String> hashtags,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  factory UserEntity.fromModel(UserModel user) => UserEntity(
      id: user.id.isNotEmpty ? user.id : null,
      email: user.email.isNotEmpty ? user.email : null,
      nickname: user.nickname.isNotEmpty ? user.nickname : null,
      profileImage: user.profile_image,
      createdAt: user.created_at,
      lastSeenAt: user.last_seen_at,
      // bio
      sex: user.sex == Sex.none ? null : user.sex,
      introduce: user.introduce.isNotEmpty ? user.introduce : null,
      hashtags: user.hashtags);

  factory UserEntity.fromSession(User sessionUser) =>
      UserEntity.fromModel(UserModel.fromSession(sessionUser));
}
