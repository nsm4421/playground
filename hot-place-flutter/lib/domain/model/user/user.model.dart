import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constant/user.constant.dart';

part 'user.model.freezed.dart';

part 'user.model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @Default('') String id,
    @Default('') String email,
    @Default('') String nickname,
    String? profile_image,
    DateTime? created_at,
    DateTime? last_seen_at, // 가장 마지막 로그인한 시간
    // bio
    @Default(Sex.none) Sex sex,
    @Default('') String introduce,
    @Default(<String>[]) List<String> hashtags,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromSession(User sessionUser) => UserModel(
      id: sessionUser.id,
      email: sessionUser.email ?? '',
      created_at: DateTime.parse(sessionUser.createdAt),
      last_seen_at:
          DateTime.parse(sessionUser.lastSignInAt ?? sessionUser.createdAt));

  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      id: user.id!,
      email: user.email ?? '',
      nickname: user.nickname ?? '',
      profile_image: user.profileImage,
      created_at: user.createdAt,
      last_seen_at: user.lastSeenAt,
      // bio
      sex: user.sex ?? Sex.none,
      introduce: user.introduce ?? '',
      hashtags: user.hashtags,
    );
  }
}
