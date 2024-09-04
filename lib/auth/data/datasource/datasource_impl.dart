import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

part 'datasource.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final SupabaseClient _supabaseClient;

  AuthDataSourceImpl({required SupabaseClient supabaseClient})
      : _supabaseClient = supabaseClient;

  @override
  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
    required String avatarUrl,
  }) async {
    return await _supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {
          'username': username,
          'avatar_url': avatarUrl
        }).then((res) => res.user);
  }

  @override
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    return await _supabaseClient.auth
        .signInWithPassword(email: email, password: password)
        .then((res) => res.user);
  }

  @override
  Future<bool> checkUsername(String username) async {
    return await _supabaseClient
        .from('accounts')
        .count()
        .eq('username', username)
        .then((res) => res == 0);
  }

  @override
  Future<String> uploadProfileImage(File profileImage) async {
    final uuid = const Uuid().v4();
    final ext = profileImage.path.split('/').last;
    final path = '$uuid.$ext';
    final bucket = _supabaseClient.storage.from('avatars');
    await bucket.uploadBinary(path, await profileImage.readAsBytes(),
        fileOptions: FileOptions(
          contentType: 'image/$ext',
          cacheControl: '3600',
        ));
    return bucket.getPublicUrl(path);
  }
}
