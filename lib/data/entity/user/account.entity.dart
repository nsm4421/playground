import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/domain/model/user/account.model.dart';

part 'account.entity.freezed.dart';

part 'account.entity.g.dart';

@freezed
class AccountEntity with _$AccountEntity {
  const factory AccountEntity({
    String? id,
    String? nickname,
    String? profileUrl,
    String? description,
  }) = _UserEntity;

  factory AccountEntity.fromJson(Map<String, dynamic> json) =>
      _$AccountEntityFromJson(json);

  factory AccountEntity.fromModel(AccountModel model) => AccountEntity(
        id: model.id.isEmpty ? null : model.id,
        nickname: model.nickname.isEmpty ? null : model.nickname,
        profileUrl: model.profileUrl.isEmpty ? null : model.profileUrl,
        description: model.description.isEmpty ? null : model.description,
      );
}
