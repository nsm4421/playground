import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio/data/model/auth/account.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'account.entity.freezed.dart';

@freezed
class AccountEntity with _$AccountEntity {
  const factory AccountEntity({
    String? id,
    String? nickname,
    String? profileImage,
    DateTime? createdAt,
  }) = _AccountEntity;

  static AccountEntity fromUser(User user) => AccountEntity(
      id: user.id,
      nickname: (user.userMetadata?.containsKey("nickname") ?? false)
          ? user.userMetadata!["nickname"]
          : null,
      profileImage: (user.userMetadata?.containsKey("profile_image") ?? false)
          ? user.userMetadata!["profile_image"]
          : null,
      createdAt: DateTime.tryParse(user.createdAt));

  static AccountEntity fromModel(AccountModel model) => AccountEntity(
      id: model.id.isEmpty ? null : model.id,
      nickname: model.nickname,
      profileImage: model.profile_image,
      createdAt: model.created_at);
}
