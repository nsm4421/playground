import 'package:supabase_flutter/supabase_flutter.dart';

part 'datasource.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final SupabaseClient _supabaseClient;

  AuthDataSourceImpl({required SupabaseClient supabaseClient})
      : _supabaseClient = supabaseClient;

  @override
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    return await _supabaseClient.auth
        .signUp(email: email, password: password)
        .then((res) => res.user);
  }

  @override
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    return await _supabaseClient.auth
        .signInWithPassword(email: email, password: password)
        .then((res) => res.user);
  }
}
