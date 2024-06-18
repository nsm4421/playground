import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/data/entity/user/account.entity.dart';

part 'presence.entity.freezed.dart';

part 'presence.entity.g.dart';

@freezed
class PresenceEntity with _$PresenceEntity {
  const factory PresenceEntity(
      {@Default('') String uid,
      @Default('') String nickname,
      @Default('') String profileUrl,
      DateTime? onlineAt}) = _PresenceEntity;

  factory PresenceEntity.fromJson(Map<String, dynamic> json) =>
      _$PresenceEntityFromJson(json);

  factory PresenceEntity.fromAccount(AccountEntity account) => PresenceEntity(
      uid: account.id ?? '',
      nickname: account.nickname ?? '',
      profileUrl: account.profileUrl ?? '',
      onlineAt: DateTime.now());
}
