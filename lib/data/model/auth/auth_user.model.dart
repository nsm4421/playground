import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_user.model.freezed.dart';

@freezed
class AuthUserModel with _$AuthUserModel {
  const factory AuthUserModel({
    @Default('') String id,
    @Default('') String email,
    @Default('') String username,
    @Default('') String avatar_url,
  }) = _AuthUserModel;

  static AuthUserModel? from(User? supabaseUser) {
    return supabaseUser == null
        ? null
        : AuthUserModel(
            id: supabaseUser.id,
            email: supabaseUser.email!,
            username: supabaseUser.userMetadata!['username'],
            avatar_url: supabaseUser.userMetadata!['avatar_url']);
  }
}
