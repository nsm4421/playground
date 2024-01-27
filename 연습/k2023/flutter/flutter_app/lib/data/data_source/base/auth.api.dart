import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthApi {
  String? get currentUid => currentUser?.id;

  User? get currentUser;

  Stream<User?> get authStream;

  Future<AuthResponse> signUpWithEmailAndPassword(
      {required String email, required String password});

  Future<AuthResponse> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<void> updateUserMetaData(Map<String, String> data);
}
