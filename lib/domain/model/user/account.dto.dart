import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/entity/user/account.entity.dart';

part 'account.dto.freezed.dart';

part 'account.dto.g.dart';

@freezed
class AccountDto with _$AccountDto {
  const factory AccountDto({
    @Default('') String id,
    @Default('') String nickname,
    @Default('') String profileUrl,
    @Default('') String description,
  }) = _AccountDto;

  factory AccountDto.fromJson(Map<String, dynamic> json) =>
      _$AccountDtoFromJson(json);

  factory AccountDto.fromEntity(AccountEntity entity) => AccountDto(
        id: entity.id ?? '',
        nickname: entity.nickname ?? '',
        profileUrl: entity.profileUrl ?? '',
        description: entity.description ?? '',
      );
}
