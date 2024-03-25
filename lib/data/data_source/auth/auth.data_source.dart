import 'package:hot_place/domain/model/user/user.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthDataSource {
  Stream<AuthState> get authStream;

  UserModel getCurrentUserOrElseThrow();

  Future<UserModel> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String nickname});

  Future<UserModel> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<void> signOut();

  Future<void> insertUser(UserModel user);

  Future<void> modifyUser(UserModel user);
}
