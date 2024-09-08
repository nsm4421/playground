import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'presence.entity.freezed.dart';

@freezed
class PresenceEntity with _$PresenceEntity {
  const factory PresenceEntity({
    String? uid,
    String? username,
    String? avatarUrl,
  }) = _PresenceEntity;

  static PresenceEntity fromSupUser(User user) {
    return PresenceEntity(
      uid: user.id,
      username: user.userMetadata!['username'],
      avatarUrl: user.userMetadata!['avatar_url'],
    );
  }
}
