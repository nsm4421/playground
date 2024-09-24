import 'package:flutter_app/shared/shared.export.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  @override
  Future<void> updateMetaData({String? username, String? avatarUrl}) async {
    try {
      await _supabaseClient.auth.updateUser(UserAttributes(
        data: {
          if (username != null) 'username': username,
          if (avatarUrl != null) 'avatar_url': avatarUrl
        },
      ));
    } catch (error) {
      _logger.e(error);
      throw CustomException.from(error: error);
    }
  }
}
