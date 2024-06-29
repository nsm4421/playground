import 'package:logger/logger.dart';
import 'package:my_app/core/exception/custom_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part '../abstract/auth.remote_datasource.dart';

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
  Future<User?> signInWithGoogle() async => throw UnimplementedError();

  @override
  Future<User?> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final user = await _client.auth
          .signUp(email: email, password: password)
          .then((res) => res.user);
      if (user == null) {
        throw const AuthException('sign up fails');
      }
      return user;
    } catch (error) {
      throw CustomException.from(error,
          logger: _logger, message: 'sign up fails');
    }
  }

  @override
  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final user = await _client.auth
          .signInWithPassword(email: email, password: password)
          .then((res) => res.user);
      if (user == null) {
        throw const AuthException('sign in fails');
      }
      return user;
    } catch (error) {
      throw CustomException.from(error,
          logger: _logger, message: 'sign in fails');
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
