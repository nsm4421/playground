import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio/data/model/auth/account.model.dart';
import 'package:portfolio/domain/entity/auth/account.entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'presence.entity.freezed.dart';

part 'presence.entity.g.dart';

@freezed
class PresenceEntity with _$PresenceEntity {
  const factory PresenceEntity(
      {String? id, String? nickname, String? profileImage}) = _PresenceEntity;

  factory PresenceEntity.fromJson(Map<String, dynamic> json) =>
      _$PresenceEntityFromJson(json);

  factory PresenceEntity.fromEntity(AccountEntity entity) => PresenceEntity(
      id: entity.id,
      nickname: entity.nickname,
      profileImage: entity.profileImage);

  factory PresenceEntity.fromModel(AccountModel model) =>
      PresenceEntity.fromEntity(AccountEntity.fromModel(model));

  factory PresenceEntity.fromUser(User user) =>
      PresenceEntity.fromEntity(AccountEntity.fromUser(user));
}
