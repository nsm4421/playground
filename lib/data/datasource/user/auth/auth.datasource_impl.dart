import 'package:logger/logger.dart';
import 'package:my_app/core/exception/custom_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth.datasource.dart';

class LocalAuthDataSourceImpl implements LocalAuthDataSource {}

class RemoteAuthDataSourceImpl implements RemoteAuthDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  RemoteAuthDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  User? get currentUser => _client.auth.currentUser;

  @override
  Stream<AuthState> get authStream => _client.auth.onAuthStateChange;

  @override
  Future<User> signInWithGoogle() async {
    try {
      await _client.auth.signInWithOAuth(OAuthProvider.google);
      return _client.auth.currentUser!;
    } catch (error) {
      throw CustomException.from(error,
          logger: _logger, message: 'google sign in fail');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (error) {
      throw CustomException.from(error,
          logger: _logger, message: 'sign out fail');
    }
  }
}
