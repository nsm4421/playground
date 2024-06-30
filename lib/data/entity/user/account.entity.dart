import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/model/user/account.dto.dart';

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

  factory AccountEntity.fromDto(AccountDto dto) => AccountEntity(
        id: dto.id.isEmpty ? null : dto.id,
        nickname: dto.nickname.isEmpty ? null : dto.nickname,
        profileUrl: dto.profileUrl.isEmpty ? null : dto.profileUrl,
        description: dto.description.isEmpty ? null : dto.description,
      );
}
