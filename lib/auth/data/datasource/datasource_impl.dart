import 'dart:io';

import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../shared/constant/response/custom_exception.dart';

part 'datasource.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final SupabaseClient _supabaseClient;
  final Logger _logger;

  AuthDataSourceImpl(
      {required SupabaseClient supabaseClient, required Logger logger})
      : _supabaseClient = supabaseClient,
        _logger = logger;

  @override
  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
    required String avatarUrl,
  }) async {
    try {
      return await _supabaseClient.auth.signUp(
          email: email,
          password: password,
          data: {
            'username': username,
            'avatar_url': avatarUrl
          }).then((res) => res.user);
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }

  @override
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _supabaseClient.auth
          .signInWithPassword(email: email, password: password)
          .then((res) => res.user);
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }

  @override
  Future<bool> checkUsername(String username) async {
    try {
      return await _supabaseClient
          .from('accounts')
          .count()
          .eq('username', username)
          .then((res) => res == 0);
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }

  @override
  Future<String> uploadProfileImage(File profileImage) async {
    try {
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
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _supabaseClient.auth.signOut();
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }

  @override
  Stream<AuthState> get authStream => _supabaseClient.auth.onAuthStateChange;

  @override
  User? get currentUser => _supabaseClient.auth.currentUser;
}
