import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_user.freezed.dart';

part 'auth_user.g.dart';

@freezed
class AuthUserModel with _$AuthUserModel {
  const factory AuthUserModel({
    @Default('') String id,
    @Default('') String username,
    @Default('') String avatar_url,
  }) = _AuthUserModel;

  factory AuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$AuthUserModelFromJson(json);

  factory AuthUserModel.from(User supabaseUser) => AuthUserModel(
      id: supabaseUser.id,
      username: supabaseUser.userMetadata?['username'],
      avatar_url: supabaseUser.userMetadata?['avatar_url']);
}
