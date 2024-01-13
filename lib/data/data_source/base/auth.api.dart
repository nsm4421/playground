import 'package:my_app/data/dto/auth/user/user_metadata.dto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthApi {
  Future<AuthResponse> signUpWithEmailAndPassword(
      {required String email, required String password});

  Future<AuthResponse> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Stream<User?> getCurrentUserStream();

  User? getCurrentUer();

  Future<void> updateMetaData(UserMetaDataDto metaData);
}
