import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part "auth.datasource.dart";

class AuthDataSourceImpl implements AuthDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  AuthDataSourceImpl({required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  User? get currentUser => _client.auth.currentUser;

  @override
  Stream<AuthState> get authStream => _client.auth.onAuthStateChange;

  @override
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    return await _client.auth
        .signUp(email: email, password: password)
        .then((res) => res.user);
  }

  @override
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    return await _client.auth
        .signInWithPassword(email: email, password: password)
        .then((res) => res.user);
  }

  @override
  Future<void> signOut() async {
    await _client.auth.signOut();
  }
}
