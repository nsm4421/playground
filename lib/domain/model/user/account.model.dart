import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/data/entity/user/account.entity.dart';

part 'account.model.freezed.dart';

part 'account.model.g.dart';

@freezed
class AccountModel with _$AccountModel {
  const factory AccountModel({
    @Default('') String id,
    @Default('') String nickname,
    @Default('') String profileUrl,
    @Default('') String description,
  }) = _AccountModel;

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);

  factory AccountModel.fromEntity(AccountEntity entity) => AccountModel(
        id: entity.id ?? '',
        nickname: entity.nickname ?? '',
        profileUrl: entity.profileUrl ?? '',
        description: entity.description ?? '',
      );
}
