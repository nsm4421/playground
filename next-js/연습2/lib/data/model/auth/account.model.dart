import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gotrue/src/types/user.dart';
import 'package:portfolio/domain/entity/auth/account.entity.dart';

part 'account.model.freezed.dart';

part 'account.model.g.dart';

@freezed
class AccountModel with _$AccountModel {
  const factory AccountModel({
    @Default('') String id,
    String? nickname,
    String? profile_image,
    DateTime? created_at,
  }) = _AccountModel;

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);

  static AccountModel fromUser(User user) => AccountModel(
      id: user.id,
      nickname: (user.userMetadata?.containsKey("nickname") ?? false)
          ? user.userMetadata!["nickname"]
          : null,
      profile_image: (user.userMetadata?.containsKey("profile_image") ?? false)
          ? user.userMetadata!["profile_image"]
          : null,
      created_at: DateTime.tryParse(user.createdAt));

  static AccountModel fromEntity(AccountEntity entity) => AccountModel(
      id: entity.id ?? "",
      nickname: entity.nickname ?? "",
      profile_image: entity.profileImage ?? "",
      created_at: entity.createdAt);
}
